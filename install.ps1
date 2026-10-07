$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$sflsDownloadDir = Join-Path ([IO.Path]::GetTempPath()) ('sfls-online-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $sflsDownloadDir | Out-Null
$sflsZip = Join-Path $sflsDownloadDir 'sfls.zip'
Write-Host 'Downloading the SFLS installer...'
Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.7/SFLS-0.1.7-windows.zip' -OutFile $sflsZip -TimeoutSec 300
if ((Get-FileHash -LiteralPath $sflsZip -Algorithm SHA256).Hash.ToLowerInvariant() -ne '3476fdffc50f751132ca372b2219c36bae3bec61cf32a7cf724b6afb0e19c492') { throw 'Checksum failed. Installer not executed.' }
$sflsPackage = Join-Path $sflsDownloadDir 'package'
Expand-Archive -LiteralPath $sflsZip -DestinationPath $sflsPackage
$sflsOriginalLocation = Get-Location
try {
    & (Join-Path $sflsPackage 'Install.ps1')
    if ($LASTEXITCODE -ne 0) { throw 'SFLS installation did not complete. Check the messages above.' }
} finally { Set-Location -LiteralPath $sflsOriginalLocation.Path }
# This script shares the current PowerShell session; refresh PATH without machine changes.
$sflsBin = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.sfls-runtime\bin'
if (([Environment]::GetEnvironmentVariable('Path', 'User') -split ';') -contains $sflsBin) {
    $env:Path = $sflsBin + ';' + $env:Path
}
