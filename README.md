# WindowsFirstBoot
Script that will be ran on First Boot of a Windows

It is downloading BGInfo, creating a scheduled job to run on user logon

Run this line in a command line executed with administrator rights

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/tunisiano187/WindowsFirstBoot/master/Install.ps1'))"
