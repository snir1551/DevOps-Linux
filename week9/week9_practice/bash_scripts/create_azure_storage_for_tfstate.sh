#!/bin/bash



RESOURCE_GROUP="mtc-resources"
LOCATION="Israel Central"
STORAGE_ACCOUNT="mtcstatetf"
CONTAINER_NAME="tfstate"


az group create --name "$RESOURCE_GROUP" --location "$LOCATION"


az storage account create \
  --name "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku Standard_LRS \


ACCOUNT_KEY=$(az storage account keys list --resource-group "$RESOURCE_GROUP" --account-name "$STORAGE_ACCOUNT" --query '[0].value' -o tsv)

az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT" \
  --account-key "$ACCOUNT_KEY"

echo "\nStorage Account: $STORAGE_ACCOUNT"
echo "Container: $CONTAINER_NAME"
echo "Resource Group: $RESOURCE_GROUP"
echo "Location: $LOCATION"
