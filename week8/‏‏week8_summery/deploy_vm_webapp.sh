#!/bin/bash

set -e

# === Default values ===
RESOURCE_GROUP=""
VM_NAME=""
LOCATION="israelcentral"
VM_USER="azureuser"
PORTS=(3000)
DEPLOY_APP=false
OPEN_PORT=false
CLEANUP=false
CREATE_VM=false
VM_SIZE="Standard_B1s"
DISK_SKU="Standard_LRS"
DISK_SIZE=30
SSH_KEY_PATH=""

# === Help Menu ===
function show_help {
  echo ""
  echo "Usage: ./deploy_vm_webapp.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --resource-group=NAME     Resource group name (required unless --interactive)"
  echo "  --vm-name=NAME            VM name (required unless --interactive)"
  echo "  --location=REGION         Azure region (default: israelcentral)"
  echo "  --admin-user=NAME         Admin username for VM (default: azureuser)"
  echo "  --ports=PORTS             Comma-separated list of ports to open (default: 3000)"
  echo "  --vm-size=SIZE            VM size (default: Standard_B1s)"
  echo "  --deploy-app              Deploy Dockerized app to the VM"
  echo "  --open-port               Open specified ports in NSG"
  echo "  --cleanup                 Delete all resources after deployment"
  echo "  --interactive             Use interactive mode to guide through steps"
  echo "  --help                    Show this help message"
  echo ""
  echo "Examples:"
  echo "  ./deploy_vm_webapp.sh --resource-group=rg1 --vm-name=vm1 --ports=3000,4000 --deploy-app --open-port"
  echo "  ./deploy_vm_webapp.sh --resource-group=rg1 --cleanup"
  echo "  ./deploy_vm_webapp.sh --interactive"
  echo ""
  exit 0
}

# === Interactive Mode ===
function interactive_mode {
  echo "Interactive Setup Mode"

  read -p "Enter resource group name: " RESOURCE_GROUP
  read -p "Enter VM name: " VM_NAME
  read -p "Enter Azure region [example: israelcentral]: " LOCATION_INPUT
  LOCATION=${LOCATION_INPUT:-$LOCATION}
  read -p "Enter VM username [example: azureuser]: " VM_USER_INPUT
  VM_USER=${VM_USER_INPUT:-$VM_USER}
  read -p "Enter ports to open (comma-separated, example: 3000,3001): " PORT_INPUT
  IFS=',' read -ra PORTS <<< "${PORT_INPUT:-3000}"

  ./deploy_vm_webapp.sh --resource-group=$RESOURCE_GROUP --vm-name=$VM_NAME --location=$LOCATION_INPUT --admin-user=$VM_USER_INPUT --ports=$PORT_INPUT --deploy-app --open-port
}

# === Parse arguments ===
function parse_arguments {
  for arg in "$@"; do
    case $arg in
      --resource-group=*) RESOURCE_GROUP="${arg#*=}" ;;
      --vm-name=*) VM_NAME="${arg#*=}" ;;
      --location=*) LOCATION="${arg#*=}" ;;
      --admin-user=*) VM_USER="${arg#*=}" ;;
      --ports=*) IFS=',' read -ra PORTS <<< "${arg#*=}" ;;
      --vm-size=*) VM_SIZE="${arg#*=}" ;;
      --deploy-app) DEPLOY_APP=true ;;
      --open-port) OPEN_PORT=true ;;
      --cleanup) CLEANUP=true ;;
      --interactive) interactive_mode ;;
      --help) show_help ;;
      *) echo "Unknown option: $arg"; show_help ;;
    esac
  done
}

function validate_inputs {
  if [[ -z "$RESOURCE_GROUP" ]]; then
    echo "Missing required argument: --resource-group"
    exit 1
  fi

  if ! $CLEANUP && [[ -z "$VM_NAME" ]]; then
    echo "Missing required argument: --vm-name (required unless --cleanup)"
    exit 1
  fi
}

function check_dependencies {
  if $DEPLOY_APP && ! $CREATE_VM; then
    CREATE_VM=true
  fi
  if $OPEN_PORT && ! $CREATE_VM; then
    CREATE_VM=true
  fi
}

function create_resource_group() {
  if ! az group show --name "$RESOURCE_GROUP" &> /dev/null; then
    echo "Resource group '$RESOURCE_GROUP' not found. Creating it..."
    az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
  fi
}

function generate_ssh_key() {
  SSH_KEY_PATH="$HOME/.ssh/${VM_NAME}_id_rsa"

  if [[ ! -f "$SSH_KEY_PATH" ]]; then
    echo "Generating SSH key at $SSH_KEY_PATH"
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t rsa -b 2048 -f "$SSH_KEY_PATH" -N ""
    echo "SSH key created"
  else
    echo "SSH key already exists at $SSH_KEY_PATH"
  fi
}

function create_vm() {
  generate_ssh_key

  echo "Creating VM: $VM_NAME"
  az vm create \
    --resource-group "$RESOURCE_GROUP" \
    --name "$VM_NAME" \
    --image Ubuntu2204 \
    --admin-username "$VM_USER" \
    --size "$VM_SIZE" \
    --os-disk-size-gb "$DISK_SIZE" \
    --storage-sku "$DISK_SKU" \
    --public-ip-sku Basic \
    --ssh-key-values "${SSH_KEY_PATH}.pub"

  PUBLIC_IP=$(az vm show --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --show-details --query publicIps --output tsv)
  echo -e "Host: $PUBLIC_IP\nUser: $VM_USER\nPrivateKey: $SSH_KEY_PATH\nPorts: ${PORTS[*]}" > "${VM_NAME}_connect.txt"
  echo "Connection info saved to ${VM_NAME}_connect.txt"
}

function open_ports() {
  echo "Opening ports: ${PORTS[*]}"

  NIC_NAME=$(az vm show \
    --resource-group "$RESOURCE_GROUP" \
    --name "$VM_NAME" \
    --query "networkProfile.networkInterfaces[0].id" \
    --output tsv | awk -F/ '{print $NF}')

  NSG_NAME=$(az network nic show \
    --resource-group "$RESOURCE_GROUP" \
    --name "$NIC_NAME" \
    --query "networkSecurityGroup.id" \
    --output tsv | awk -F/ '{print $NF}')

  if [[ -z "$NSG_NAME" ]]; then
    NSG_NAME="${VM_NAME}NSG"
    echo "Creating NSG: $NSG_NAME"
    az network nsg create --resource-group "$RESOURCE_GROUP" --name "$NSG_NAME" --location "$LOCATION"
    echo "Attaching NSG to NIC: $NIC_NAME"
    az network nic update \
      --resource-group "$RESOURCE_GROUP" \
      --name "$NIC_NAME" \
      --network-security-group "$NSG_NAME"
  fi

  BASE_PRIORITY=110

  for i in "${!PORTS[@]}"; do
    PORT=${PORTS[$i]}
    PRIORITY=$((BASE_PRIORITY + i))
    RULE_NAME="open-port-$PORT"

    echo "Creating NSG rule for port $PORT with priority $PRIORITY"
    az network nsg rule create \
      --resource-group "$RESOURCE_GROUP" \
      --nsg-name "$NSG_NAME" \
      --name "$RULE_NAME" \
      --priority "$PRIORITY" \
      --direction Inbound \
      --access Allow \
      --protocol Tcp \
      --destination-port-range "$PORT" \
      --source-address-prefixes '*' \
      --destination-address-prefixes '*' \
      --description "Allow TCP port $PORT"
  done
}

function deploy_app() {
  PUBLIC_IP=$(az vm show --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --show-details --query publicIps --output tsv)
  echo "Uploading app to $PUBLIC_IP (excluding node_modules)..."

  rsync -avz --exclude 'node_modules' -e "ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no" ./app/ "$VM_USER@$PUBLIC_IP:/home/$VM_USER/app"

  setup_vm_environment
  echo "Starting Docker Compose on the VM..."
  ssh -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no "$VM_USER@$PUBLIC_IP" bash -s << 'EOF'
  cd /home/$USER/app
  sudo docker compose up -d
EOF

  echo "App deployed! Access it via: http://$PUBLIC_IP"
}

function cleanup_resources() {
  echo "Deleting resource group: $RESOURCE_GROUP"
  az group delete --name "$RESOURCE_GROUP" --yes --no-wait
}


function setup_vm_environment() {
  echo "Setting up environment on VM (Docker + swap)..."
  ssh -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no "$VM_USER@$PUBLIC_IP" bash -s << EOF
    # Install Docker & Docker Compose
    if ! command -v docker &> /dev/null; then
      echo "Installing Docker..."
      sudo apt update
      sudo apt install -y ca-certificates curl gnupg lsb-release

      sudo install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

      echo \
        "deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

      sudo apt update
      sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    else
      echo "Docker is already installed."
    fi

    # Add swap if missing
    if ! swapon --show | grep -q "/swapfile"; then
      echo "[+] Creating 1GB swapfile..."
      sudo fallocate -l 1G /swapfile
      sudo chmod 600 /swapfile
      sudo mkswap /swapfile
      sudo swapon /swapfile
      echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
    else
      echo "Swap already enabled."
    fi
EOF
}

function main {
  parse_arguments "$@"
  validate_inputs
  check_dependencies
  create_resource_group
  $CREATE_VM && create_vm
  $OPEN_PORT && open_ports
  $DEPLOY_APP && deploy_app
  $CLEANUP && cleanup_resources
}

main "$@"
