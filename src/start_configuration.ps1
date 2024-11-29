#############################################################################################
# Reminder
# Before running this powershell script:
# 1) Open powershell with admin rights and run: "Set-ExecutionPolicy Unrestricted -Force"
#         - This will permit run scripts in your machine.
# 2) Update your windows to last version before running
#         - This is to perform a non-error install, if you don't, some programs will fail.
#############################################################################################

#############################################################################################
# Install chocolatey
#############################################################################################
Write-Output "Start Chocolatey install process"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#############################################################################################
# Install dev environment
#############################################################################################
Write-Output "Start dev environment install process"
choco install curl -y
choco install nvm -y
choco install yarn -y
choco install python -y
choco install git -y
choco install vscode -y
choco install docker-desktop -y
choco install insomnia-rest-api-client -y
choco install androidstudio -y
choco install visualstudio2019community -y

#############################################################################################
# Install and select node version
#############################################################################################
Write-Output "Start nvm install and select version process"
start powershell {nvm install node | nvm alias default node}

#############################################################################################
# Install programs
#############################################################################################
Write-Output "Start usual programs install process"
choco install googlechrome -y
choco install google-backup-and-sync -y
choco install vivaldi -y
choco install adobereader -y
choco install avastfreeantivirus -y
choco install superantispyware -y
choco install notion -y
choco install tunein-radio -y
choco install logitech-options -y
choco install spotify -y
choco install discord -y
choco install microsoft-edge -y
choco install office365business -y
choco install obs-studio -y
choco install k-litecodecpackfull -y
choco install 7zip.install -y
choco install powerbi -y

#############################################################################################
# Uninstall OneDrive
#############################################################################################
Write-Output "Start OneDrive uninstall process"
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\New-FolderForced.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1

taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"

Write-Output "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}

Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"

If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
}

New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
mkdir -Force "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
mkdir -Force "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
Remove-PSDrive "HKCR"

reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ea SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

Invoke-Item c:\windows\explorer.exe

#############################################################################################
# Rename your computer
#############################################################################################
$PCName = Read-Host "Enter the new name for your PC: "
Rename-Computer -NewName $PCName
