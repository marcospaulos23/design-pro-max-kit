# install.ps1 - Instalador do Antigravity UI/UX Design Kit by Marcos Paulo
param (
    [string]$Destino = (Get-Location).Path,
    [switch]$Global
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "[*] Antigravity UI/UX Design Kit - Instalador Automatico" -ForegroundColor Green
Write-Host "    Criado por Marcos Paulo" -ForegroundColor DarkCyan
Write-Host "==========================================================" -ForegroundColor Cyan

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$origemAgent = Join-Path $scriptDir ".agent"

if (-not (Test-Path $origemAgent)) {
    Write-Host "[!] Pasta .agent nao encontrada em: $scriptDir" -ForegroundColor Red
    exit 1
}

if ($Global) {
    $targetBase = "$HOME\.gemini\config"
    Write-Host "[*] Instalando no escopo GLOBAL ($targetBase)..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path "$targetBase\agents", "$targetBase\skills", "$targetBase\workflows" | Out-Null
    
    Copy-Item "$origemAgent\agents\*" -Destination "$targetBase\agents\" -Recurse -Force
    Copy-Item "$origemAgent\skills\*" -Destination "$targetBase\skills\" -Recurse -Force
    Copy-Item "$origemAgent\workflows\*" -Destination "$targetBase\workflows\" -Recurse -Force
    
    Write-Host "[OK] Design Kit instalado GLOBALMENTE com sucesso!" -ForegroundColor Green
    Write-Host "[i] Agora qualquer projeto aberto nesta maquina tem acesso ao @frontend-specialist e /ui-ux-pro-max!" -ForegroundColor Cyan
} else {
    Write-Host "[*] Instalando no projeto: $Destino..." -ForegroundColor Yellow
    $targetAgent = Join-Path $Destino ".agent"
    New-Item -ItemType Directory -Force -Path "$targetAgent\agents", "$targetAgent\skills", "$targetAgent\workflows" | Out-Null
    
    Copy-Item "$origemAgent\agents\*" -Destination "$targetAgent\agents\" -Recurse -Force
    Copy-Item "$origemAgent\skills\*" -Destination "$targetAgent\skills\" -Recurse -Force
    Copy-Item "$origemAgent\workflows\*" -Destination "$targetAgent\workflows\" -Recurse -Force
    
    Write-Host "[OK] Design Kit instalado no projeto com sucesso!" -ForegroundColor Green
    Write-Host "[i] Experimente digitar no chat: /ui-ux-pro-max ou @frontend-specialist" -ForegroundColor Cyan
}
