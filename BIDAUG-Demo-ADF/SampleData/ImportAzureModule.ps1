$azurePowerShellPath = "Microsoft SDKs\Azure\PowerShell"
$serviceManagementModuleName = "Azure.psd1"
$resourceManagementModuleName = "AzureResourceManager.psd1"
$serviceManagementModulePath = "$azurePowerShellPath\ServiceManagement\Azure\$serviceManagementModuleName"
$resourceManagementModulePath = "$azurePowerShellPath\ResourceManager\AzureResourceManager\$resourceManagementModuleName"

<# Get Azure Modules Path #>
if(Test-Path ${env:ProgramFiles(x86)})
{
    <# This is x64 machine if this ProgramFiles(x86) variable is set #>
    $installFolder = "${env:ProgramFiles(x86)}"
}
else
{
    <# This is x86 machine if this ProgramFiles(x86) variable is not set #>
    $installFolder = "${env:ProgramFiles}"
}

$AzureModules = Get-ChildItem -Path "$installFolder\$azurePowerShellPath" -File $serviceManagementModuleName -Recurse -Verbose:$false
$AzureResourceManagerModules = Get-ChildItem -Path "$installFolder\$azurePowerShellPath" -File $resourceManagementModuleName -Recurse -Verbose:$false

<# Load Azure Modules if present #>
if ($AzureModules.count -eq 0 -or $AzureResourceManagerModules.count -eq 0) 
{
    Write-Verbose "Please install Microsoft Azure Powershell from: http://go.microsoft.com/?linkid=9811175&clcid=0x409" 
    Write-Verbose "More info @ https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/"
}
else
{
    Write-Verbose "Start: Importing Azure Modules"

	Import-Module "$installFolder/$serviceManagementModulePath" -Verbose:$false > $null
	Get-ChildItem -Path "$installFolder\$azurePowerShellPath" -File $resourceManagementModuleName -Recurse -Verbose:$false > $null
	
    Write-Verbose "Done: Importing Azure Modules"
}
