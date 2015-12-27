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

$url = 'https://github.com/git-for-windows/git/releases/download/v2.6.4.windows.1/PortableGit-2.6.4-32-bit.7z.exe'
$url64 = 'https://github.com/git-for-windows/git/releases/download/v2.6.4.windows.1/PortableGit-2.6.4-64-bit.7z.exe'

# Check OS Architecture 
$OSArch =Get-WmiObject Win32_OperatingSystem  | select OSArchitecture

# Downloading Git file
if ($OSArch.OSArchitecture -eq '64 bits') 
{
  $url = $url64
}
Write-Host "Download Git Portable 7z"
$GitExe = Join-Path $installDir 'PortableGit.7z.exe'
Download-File $url "$GitExe"

Write-Host "Download 7Zip commandline tool"
$7zaExe = Join-Path $installDir '7za.exe'
Download-File $7zURL "$7zaExe"
