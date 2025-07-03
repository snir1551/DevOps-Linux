#!/bin/bash

echo "Azure Cheap VM Creator"

read -p "Enter Resource Group name: " RESOURCE_GROUP
read -p "Enter VM name: " VM_NAME
read -p "Enter Azure location (e.g., israelcentral): " LOCATION
read -p "Enter SSH key file name (in ~/.ssh/, e.g., id_rsa.pub): " SSH_KEY_FILE

SSH_KEY_PATH=~/.ssh/${SSH_KEY_FILE}
ADMIN_USER="azureuser"
IMAGE="Ubuntu2204"
SIZE="Standard_B1s" 


echo "Creating resource group..."
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"


if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "SSH key $SSH_KEY_PATH not found. Creating new key..."
  ssh-keygen -t rsa -b 2048 -f "${SSH_KEY_PATH%.*}" -N ""
fi

echo "Creating VM..."
az vm create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --image "$IMAGE" \
  --size "$SIZE" \
  --admin-username "$ADMIN_USER" \
  --ssh-key-values "$SSH_KEY_PATH" \
  --location "$LOCATION"


echo "Opening SSH port..."
az vm open-port --port 22 --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"


IP_ADDRESS=$(az vm show --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --show-details --query publicIps -o tsv)


echo "VM '$VM_NAME' created successfully in '$LOCATION'"
echo "SSH command:"
echo "ssh -i $SSH_KEY_PATH $ADMIN_USER@$IP_ADDRESS"