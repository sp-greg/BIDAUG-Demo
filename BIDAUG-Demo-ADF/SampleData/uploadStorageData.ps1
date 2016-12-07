<#
.SYNOPSIS 
uploadStorageData.ps1.ps1 uploads the sample data and script to your Azure Storage.

.DESCRIPTION
Remember to update the storage account name, storage account key before running the script.

.NOTES 
File Name : uploadStorageData.ps1
Version   : 2.0
#>    
&.\ImportAzureModule.ps1

$storageAccount = "spgregadfstorage"
$storageKey = "+W+F3KSLtkCC9MZHnjNFR7XZyKG3wvLKKupi0PxF+Z32mAqQ1Cz5tYUQlFm9lRWFQDjTv1R+YTEbcydJb2EGdg=="

$adfcontainerName = "adfblobtodatalakestoresampledata"
Write-Verbose   "Preparing the storage account. Adding the container [$adfcontainerName]"
$destContext = New-AzureStorageContext  -StorageAccountName $storageAccount -StorageAccountKey $storageKey -ea silentlycontinue
If ($destContext -eq $Null) {
	Write-Error "Invalid storage account name and/or storage key provided"
	Exit
}


#check whether the Azure storage container already exists
$container = Get-AzureStorageContainer -Name $adfcontainerName -context $destContext -ea silentlycontinue
If ($container -eq $Null) {
	Write-Verbose "Creating storage container [$adfcontainerName]"
	New-AzureStorageContainer -Name $adfcontainerName -context $destContext 
}
else {
	Write-Verbose "[$adfcontainerName] exists."
}

# STEP 1- Upload sample data and script files to the blob container
Write-Verbose  "Uploading sample data and script files to the storage container [$adfcontainerName]"
Set-AzureStorageBlobContent -File ".\part-r-00000-1"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno2015/monthno04/dayno01/" -Force
Set-AzureStorageBlobContent -File ".\part-r-00000-2"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno2015/monthno04/dayno02/" -Force
Set-AzureStorageBlobContent -File ".\part-r-00000-3"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno2015/monthno04/dayno03/" -Force
Set-AzureStorageBlobContent -File ".\part-r-00000-4"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno2015/monthno04/dayno04/" -Force
