# Deployment Log
## zure CLI Commands Used
```bash
az group create --name RG-DEVOPS-LAB --location eastus
az vm create --resource-group RG-DEVOPS-LAB --name Linux-VM01 --image UbuntuLTS --admin-username snir --generate-ssh-keys
az network nsg rule create --resource-group RG-DEVOPS-LAB --nsg-name Linux-VM01NSG --name Allow-Port-3000 --priority 100 --destination-port-ranges 3000 --access Allow --protocol Tcp --direction Inbound
az network nsg rule create --resource-group RG-DEVOPS-LAB --nsg-name Linux-VM01NSG --name Allow-Port-8080 --priority 101 --destination-port-ranges 8080 --access Allow --protocol Tcp --direction Inbound
az disk create --resource-group RG-DEVOPS-LAB --name task8-disk --size-gb 10 --sku Standard_LRS --location eastus
az vm disk attach --resource-group RG-DEVOPS-LAB --vm-name Linux-VM01 --name task8-disk
az vm restart --resource-group RG-DEVOPS-LAB --name Linux-VM01
```
## Deployment Steps
- Synced files to VM via rsync over SSH
- Docker Compose used on VM to build and run app
- .env file uploaded securely via GitHub Secrets
## Healthcheck
- curl used to test port 3000 and 8080 accessibility
## Persistent Disk
- Attached task8-disk to VM (4GB), not mounted or used yet
## Reboot & Recovery
- VM rebooted successfully
- Application was verified accessible after reboot
