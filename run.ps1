# run.ps1

# Az.Storage will be loaded automatically because of requirements.psd1
param($TriggerMetadata, $InputMessage)

# Get connection string from environment variable
$storageConnectionString = $env:AzureWebJobsStorage

# Create storage context
$ctx = New-AzStorageContext -ConnectionString $storageConnectionString

# Container and blob name
$containerName = "mycontainer"
$blobName = "message-" + (Get-Date -Format "yyyyMMddHHmmss") + ".txt"

# Convert message to bytes
$content = [System.Text.Encoding]::UTF8.GetBytes($InputMessage)

# Upload message to blob
Set-AzStorageBlobContent -Container $containerName -Blob $blobName -Context $ctx -Content $content

Write-Host "Blob '$blobName' uploaded to container '$containerName'."
