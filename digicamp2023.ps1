# Description: Boxstarter Script
# Author: Christian Erhardt
# Common dev settings for M5 stack development

If ($Boxstarter.StopOnPackageFailure) { $Boxstarter.StopOnPackageFailure = $false }

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function drawLine { Write-Host '------------------------------' }

function executeScript {
    Param ([string]$script)
	drawLine;
    write-host "executing $helperUri/$script ..."
	Invoke-Expression ((New-Object net.webclient).DownloadString("$helperUri/$script")) -ErrorAction Continue
	drawLine;
	RefreshEnv;
	Start-Sleep -Seconds 1;
}

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
# executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "M5StackTools.ps1";

choco install -y awscli
choco install -y arduino

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
#Install-WindowsUpdate -AcceptEula
