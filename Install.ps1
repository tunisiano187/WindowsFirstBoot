Write-Host -ForegroundColor 'GREEN' Download Git
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
$RepoURL= 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/'
$BGInfoURL='https://download.sysinternals.com/files/BGInfo.zip'
$7zURL= "$RepoURLApps/7za.exe"
$7zaExe = Join-Path $installDir '7za.exe'

$installDir = Join-Path $env:temp 'winfirstboot'
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

Download-File $7zURL "$7zaExe"
Write-Host -ForegroundColor Green Extract Files
Start-Process "$7zaExe" -ArgumentList "x -o`"$installDir`" -y `"$BGInfoZip`"" -Wait -NoNewWindow