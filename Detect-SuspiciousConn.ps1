<#
.SYNOPSIS
    Monitor de ameaças para detecção de conexões de rede suspeitas.
.DESCRIPTION
    Este script identifica conexões TCP estabelecidas e as correlaciona com processos de Shell.
#>

$PortasSuspeitas = @(4444, 4445, 8080, 8888, 9001)

Write-Host "[*] Iniciando Monitoramento de Rede..." -ForegroundColor Cyan

$Conexoes = Get-NetTCPConnection -State Established

foreach ($Conn in $Conexoes) {
    $Processo = Get-Process -Id $Conn.OwningProcess -ErrorAction SilentlyContinue
    
    $IsShell = $Processo.Name -match "powershell|cmd|pwsh"
    $IsSuspiciousPort = $PortasSuspeitas -contains $Conn.RemotePort

    if ($IsShell) {
        Write-Host "[ALERT] Shell com conexão ativa: $($Processo.Name) (PID: $($Processo.Id)) -> $($Conn.RemoteAddress):$($Conn.RemotePort)" -ForegroundColor Red -BackgroundColor Black
    }
    elseif ($IsSuspiciousPort) {
        Write-Host "[WARN] Porta suspeita detectada ($($Conn.RemotePort)) no processo: $($Processo.Name)" -ForegroundColor Yellow
    }
}
