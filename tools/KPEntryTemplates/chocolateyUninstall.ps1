﻿$packageName = "keepass-KPEntryTemplates"
$PLGX = "KPEntryTemplates.plgx"

$is64bit = Get-ProcessorBits 64
$programUninstallEntryName = "KeePass Password Safe 2."

if ($is64bit) {
  $installPath = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, InstallLocation | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).InstallLocation
}
else {
  $installPath = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, InstallLocation | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).InstallLocation
}

if (!$installPath) {
  throw "Could not locate KeePass Password Safe 2.x installation location. The plugin may still exist on disk."
}
$fileFullPath = "$installPath\Plugins\$PLGX"
Remove-Item $fileFullPath
