#!/bin/bash

# wsl bash deleteBackend.sh to utilize this script

# Step 1: Source the vars.sh file to load credentials
source ./vars.sh

# ----------------------
# Uncomment the following lines to delete all resources when needed
# ----------------------

# Step 1: Check if the storage container exists
CONTAINER_CHECK=$(az storage container exists --name "$BACK_CONTAINER_NAME" --account-name "$BACK_STORAGE_ACCOUNT" --account-key "$ACCOUNT_KEY" --query "exists" -o tsv 2>/dev/null)

if [ "$CONTAINER_CHECK" == "true" ]; then
    echo "Deleting storage container: $BACK_CONTAINER_NAME..."
    az storage container delete --name "$BACK_CONTAINER_NAME" --account-name "$BACK_STORAGE_ACCOUNT" --account-key "$ACCOUNT_KEY"
    if [ $? -ne 0 ]; then
        echo "Failed to delete storage container '$BACK_CONTAINER_NAME'."
    else
        echo "Storage container '$BACK_CONTAINER_NAME' deleted."
    fi
else
    echo "Storage container '$BACK_CONTAINER_NAME' does not exist."
fi

# Step 2: Check if the storage account exists
SA_CHECK=$(az storage account show --name "$BACK_STORAGE_ACCOUNT" --resource-group "$BACK_RESOURCE_GROUP" --query "name" -o tsv 2>/dev/null)

if [ -n "$SA_CHECK" ]; then
    echo "Deleting storage account: $BACK_STORAGE_ACCOUNT..."
    az storage account delete --name "$BACK_STORAGE_ACCOUNT" --resource-group "$BACK_RESOURCE_GROUP" --yes
    if [ $? -ne 0 ]; then
        echo "Failed to delete storage account '$BACK_STORAGE_ACCOUNT'."
    else
        echo "Storage account '$BACK_STORAGE_ACCOUNT' deletion initiated."
    fi
else
    echo "Storage account '$BACK_STORAGE_ACCOUNT' does not exist."
fi

# Step 3: Check if the resource group exists
RG_CHECK=$(az group exists --name "$BACK_RESOURCE_GROUP")

if [ "$RG_CHECK" ]; then
    echo "Deleting resource group: $BACK_RESOURCE_GROUP..."
    az group delete --name "$BACK_RESOURCE_GROUP" --yes
    if [ $? -ne 0 ]; then
        echo "Failed to delete resource group '$BACK_RESOURCE_GROUP'."
    else
        echo "Resource group '$BACK_RESOURCE_GROUP' deletion initiated."
    fi
else
    echo "Resource group '$BACK_RESOURCE_GROUP' does not exist."
fi