#!/bin/bash

# Run wsl bash loginAndCreateBackendResources.sh to utilize this script

# Step 1: Source the vars.sh file to load credentials
source ./vars.sh

# Step 2: Log in to Azure using the service principal
echo "Logging in to Azure using Service Principal..."
az login --service-principal --username "$AZURE_CLIENT_ID" --password "$AZURE_CLIENT_SECRET" --tenant "$AZURE_TENANT_ID"

# Check if login was successful
if [ $? -ne 0 ]; then
    echo "Azure login failed."
    exit 1
fi

echo "Login successful!"

# Step 3: Creating a resource group for storing state file
echo "Creating resource group '$BACK_RESOURCE_GROUP' in 'eastus'..."
az group create --name "$BACK_RESOURCE_GROUP" --location eastus

# Check if resource group creation was successful
if [ $? -ne 0 ]; then
    echo "Failed to create resource group."
    exit 1
fi

# Step 4: Creating a storage account with the most basic SKU
echo "Creating storage account '$BACK_STORAGE_ACCOUNT' in resource group '$BACK_RESOURCE_GROUP' with SKU 'Standard_LRS'..."
az storage account create --name "$BACK_STORAGE_ACCOUNT" --location eastus --resource-group "$BACK_RESOURCE_GROUP" --sku Standard_LRS

# Check if storage account creation was successful
if [ $? -ne 0 ]; then
    echo "Failed to create storage account."
    exit 1
fi

echo "Storage account created successfully!"

# Step 5: Get the first key from the storage account and assign it to a variable
ACCOUNT_KEY=$(az storage account keys list --resource-group "$BACK_RESOURCE_GROUP" --account-name "$BACK_STORAGE_ACCOUNT" --query "[0].value" -o tsv)

# Check if the key was retrieved successfully
if [ -z "$ACCOUNT_KEY" ]; then
    echo "Failed to retrieve storage account key."
    exit 1
fi

echo "Storage account key: $ACCOUNT_KEY"

# Step 6: Create the storage container if it doesn't exist
echo "Creating storage container: $BACK_CONTAINER_NAME..."
az storage container create --name "$BACK_CONTAINER_NAME" --account-name "$BACK_STORAGE_ACCOUNT" --public-access off --account-key "$ACCOUNT_KEY"

# Check if container creation was successful
if [ $? -ne 0 ]; then
    echo "Failed to create storage container."
    exit 1
fi

echo "Storage container '$BACK_CONTAINER_NAME' created successfully!"