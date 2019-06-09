$packageName = "keepass-KPEntryTemplates"
$url = "https://github.com/mitchcapper/KPEntryTemplates/releases/download/8.0/KPEntryTemplates.plgx"
$checksum = "9FD0E73FA2D3EAB0931BDDB1494EC32FD61D614DC874B83251CF9EAB73440932"
$checksumType = "sha256"
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
  throw "Could not locate KeePass Password Safe 2.x installation location."
}
$fileFullPath = "$installPath\Plugins\$PLGX"

# Cleanup plugin if exists at previous location
if (Test-Path $fileFullPath) {
  Remove-Item $fileFullPath
}



Get-ChocolateyWebFile $packageName $fileFullPath $url -Checksum $checksum -ChecksumType $checksumType
