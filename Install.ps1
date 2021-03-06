Write-Host -ForegroundColor 'GREEN' Windows Preparation
# Functions
function Download-File {
	param (
		[string]$url,
		[string]$file
	)
	Write-Host "Downloading $url to $file"
	#$webclient = New-Object System.Net.WebClient
	#$webclient.DownloadFile($url,$file)
	Import-Module BitsTransfer
	Start-BitsTransfer $url $file
}
# Configuration
$installDir = Join-Path $env:temp 'winfirstboot'
New-Item $installDir -type directory
$RepoURL= 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/'
$BGInfoURL='https://download.sysinternals.com/files/BGInfo.zip'
$BGInfoBGIURL= 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/Apps/template.bgi'
$7zURL= "https://github.com/tunisiano187/WindowsFirstBoot/raw/master/Apps/7za.exe"
$7zaExe = Join-Path $installDir '7za.exe'
$strAllUsersProfile = [io.path]::GetFullPath($env:AllUsersProfile)
$objShell = New-Object -com "Wscript.Shell"
$objShortcut = $objShell.CreateShortcut($strAllUsersProfile + "\Start Menu\Programs\Startup\BGInfo.lnk")
$BGInfoFinalFolder = $strAllUsersProfile + "\BGInfo\"
New-Item $BGInfoFinalFolder -type directory
$BGInfoFinalExe = $BGInfoFinalFolder + "BGInfo.exe"
$BGInfoBGI= $BGInfoFinalFolder + "template.bgi"
$BGInfoFinalPS1URL= "https://github.com/tunisiano187/WindowsFirstBoot/raw/master/Apps/BGInfo.ps1"
$BGInfoFinalPS1 = $BGInfoFinalFolder + "BGInfo.ps1"
$objShortcut.TargetPath = $BGInfoFinalExe
$objShortcut.Save()

New-Item $installDir -type directory

# Check OS Architecture 
$OSArch =Get-WmiObject Win32_OperatingSystem  | select OSArchitecture
if ($OSArch.OSArchitecture -eq '64 bits') 
{
  $url = $url64
}

cd $installDir
$BGInfoZip=Join-Path $installDir 'BGInfo.zip'
Download-File $BGInfoURL $BGInfoZip
Write-Host "$7zaExe"
Download-File $7zURL "$7zaExe"
Write-Host -ForegroundColor Green Extract BGInfo Files
Start-Process "$7zaExe" -ArgumentList "x -o`"$installDir`" -y `"$BGInfoZip`"" -Wait -NoNewWindow
Write-Host -ForegroundColor Yellow Copying Bginfo.exe to $BGInfoFinalExe
Copy-Item "$installDir\Bginfo.exe" $BGInfoFinalExe

# Configuration of BGInfo
Download-File $BGInfoBGIURL $BGInfoBGI

# Creation of Task Job
schtasks /create /tn BGInfo /tr "$BGInfoFinalExe $BGInfoBGI"  /sc onlogon
Write-host "$BGInfoFinalExe $BGInfoBGI"

#################### Installation of VMWare tools
# Detection if we are on VMWare Server

$wmibios = Get-WmiObject Win32_BIOS -ErrorAction Stop | Select-Object version,serialnumber
if ($wmibios.SerialNumber -like "*VMware*") {
# If we are on VMWare then install vmware Tools
	$VMWareTools='https://packages.vmware.com/tools/esx/latest/windows/x64/VMware-tools-9.10.5-2981885-x86_64.exe'
	$VMWareToolsExe = Join-Path $installDir 'VMWareTools.exe'
	Download-File $VMWareTools $VMWareToolsExe

	$VMWareToolsExe
}
