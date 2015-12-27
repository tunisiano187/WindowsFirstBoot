Write-Host -ForegroundColor 'GREEN' Download Git
# Configuration
$installDir = Join-Path $env:temp 'winfirstboot'
$url = 'https://github.com/git-for-windows/git/releases/download/v2.6.4.windows.1/PortableGit-2.6.4-32-bit.7z.exe'
$url64 = 'https://github.com/git-for-windows/git/releases/download/v2.6.4.windows.1/PortableGit-2.6.4-64-bit.7z.exe'

# Check OS Architecture 
$OSArch =Get-WmiObject Win32_OperatingSystem  | select OSArchitecture

# Downloading file
$webclient = New-Object System.Net.WebClient
if ($OSArch.OSArchitecture -eq '64 bits') 
{
  $url = $url64
}
$file = "$installDir\PortableGit.7z.exe"
#$webclient.DownloadFile($url,$file)

Write-Host $installDir
