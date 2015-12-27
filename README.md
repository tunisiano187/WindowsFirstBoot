# WindowsFirstBoot
Script that will be ran on First Boot of a Windows

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://Install.ps1'))"
