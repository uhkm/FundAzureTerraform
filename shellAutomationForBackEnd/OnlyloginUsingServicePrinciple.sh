#!/bin/bash

# Run wsl bash OnlyloginUsingServicePrinciple.sh to utilize this script

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
