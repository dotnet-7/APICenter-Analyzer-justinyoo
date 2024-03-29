#!/bin/bash

echo "Configuring EventGrid subscription for API Center"

# Sleep for 2 minutes to allow the function app to be deployed
sleep 120

functionID=$(az functionapp function show --name ${AZURE_FUNCTION_NAME} \
    --function-name apicenter-analyzer --resource-group ${RESOURCE_GROUP_NAME} \
    --query "id" --output tsv)
MSYS_NO_PATHCONV=1 az eventgrid event-subscription create --name MyEventSubscription \
    --source-resource-id "${AZURE_API_CENTER_ID}" --endpoint "$functionID" \
    --endpoint-type azurefunction --included-event-types \
    Microsoft.ApiCenter.ApiDefinitionAdded Microsoft.ApiCenter.ApiDefinitionUpdated

