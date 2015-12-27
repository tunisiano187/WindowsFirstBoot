Write-Host -ForegroundColor 'GREEN' Download Git
# Functions
function Download-File {
	param (
		[string]$url,
		[string]$file
	)
	Write-Host "Downloading $url to $file"
	$webclient = New-Object System.Net.WebClient
	$webclient.DownloadFile($url,$file)
}
# Configuration
$unzipMethod = '7zip'
$7zURL= 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/Apps/7za.exe'

$installDir = Join-Path $env:temp 'winfirstboot'
New-Item $installDir -type directory

$url = 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/Apps/PortableGit32.zip'
$url64 = 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/Apps/PortableGit64.zip'

# Check OS Architecture 
$OSArch =Get-WmiObject Win32_OperatingSystem  | select OSArchitecture

# Downloading Git file
if ($OSArch.OSArchitecture -eq '64 bits') 
{
  $url = $url64
}
Write-Host "Download Git Portable zip"
$GitZip = Join-Path $installDir 'PortableGit.zip'
Download-File $url "$GitZip"

Write-Host "Download 7Zip commandline tool"
$7zaExe = Join-Path $installDir '7za.exe'
Download-File $7zURL "$7zaExe"

Write-Host -ForegroundColor Green Extract Files
Start-Process "$7zaExe" -ArgumentList "x -o`"$installDir`" -y `"$GitZip`"" -Wait -NoNewWindow