# WindowsFirstBoot
Script that will be ran on First Boot of a Windows

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/tunisiano187/WindowsFirstBoot/master/Install.ps1'))"
