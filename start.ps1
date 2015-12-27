Write-Host -ForegroundColor 'GREEN' Windows Preparation
# Functions
function Download-File {
	param (
		[string]$url,
		[string]$file
	)
	Write-Host -ForeGround Blue "Downloading $url to $file"
	Import-Module BitsTransfer
	Start-BitsTransfer $url $file
}
# Configuration
$installDir = Join-Path $env:temp 'winfirstboot'
$installDirFiles = Join-Path $installDir "\*"
Remove-Item $installDirFiles -recurse
$RepoURL= 'https://github.com/tunisiano187/WindowsFirstBoot/raw/master/'
$InstallFileURL = $RepoURL + 'Install.ps1'
$InstallFile = Join-Path $installDir 'install.ps1'
. $InstallFile