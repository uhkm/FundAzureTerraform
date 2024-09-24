#!/bin/bash

# if not already done create a service principle so that you do not need to login with manual intervention
# az ad sp create-for-rbac --name "<YourServicePrincipalName>" --role contributor --scopes /subscriptions/<SubscriptionID>

# Fill up the empty strings with appropriate values from your subscription
# Note that when backend is involved, we cannot use service principle to connect to azure and initialize tf
# We will have to use az login --use-device-code and follow the steps

# Service Principal details
export AZURE_CLIENT_ID=""   # appId of the Service Principal
export AZURE_TENANT_ID=""  # tenantId of your Azure Active Directory
export AZURE_CLIENT_SECRET=""  # Password/Secret of the Service Principal

# Backend storage details for storing the tf state file
export BACK_RESOURCE_GROUP=""
export BACK_STORAGE_ACCOUNT=""
export BACK_CONTAINER_NAME=""