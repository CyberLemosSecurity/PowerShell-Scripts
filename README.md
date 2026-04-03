# 🛡️ PowerShell Threat Detection: Monitoramento de Reverse Shell

## 1. Objetivo
Este laboratório foca na utilização do PowerShell como ferramenta de **Threat Hunting** e **Incident Response**. O objetivo principal é criar um script automatizado capaz de detectar conexões de rede suspeitas (possíveis Beacons de C2 ou Reverse Shells) originadas de processos nativos do sistema, como `powershell.exe` e `cmd.exe`.

## 2. Ambiente do Laboratório
* **Editor de Código:** Visual Studio Code (VS Code)
* **Extensões:** PowerShell Extension (Microsoft)
* **Sistema Operacional:** Windows 10/11 ou Windows Server
* **Versão do PowerShell:** 5.1 / 7.x (Cross-platform)
* **Ferramentas de Apoio:** Terminal Integrado do VS Code e privilégios de Administrador.

## 3. Implementação Técnica (O Script)
O script `Detect-SuspiciousConn.ps1` realiza a correlação entre o ID do processo (`OwningProcess`) e o socket de rede aberto, filtrando portas comumente utilizadas em ataques (4444, 8080, etc.).

> **Nota:** O código completo está disponível no arquivo `scripts/Detect-SuspiciousConn.ps1`.

## 4. Análise dos Resultados
Durante a execução, o script demonstrou alta eficácia na correlação de dados:
* **Visibilidade:** Identificação em tempo real de qual processo iniciou a conexão externa.
* **Detecção de LotL (Living-off-the-Land):** Capacidade de sinalizar quando ferramentas legítimas da Microsoft são abusadas para comunicação externa.
* **Alertas Visuais:** Implementação de `Write-Host` com cores diferenciadas para facilitar a triagem rápida por um analista de SOC.

## 5. Riscos e Oportunidades de Melhoria (Visão Estratégica)
* **Risco de Evasão:** Atacantes podem usar **Process Injection** para ocultar a conexão dentro de processos confiáveis (ex: `explorer.exe`).
* **Falsos Positivos:** Softwares de VPN ou atualizadores podem disparar alertas em portas altas; a implementação de uma *Allowlist* é o próximo passo recomendado.
* **Melhoria Futura:** Integrar a verificação de assinatura digital (`Get-AuthenticodeSignature`) para validar a integridade dos executáveis.

## 6. Conclusão
O PowerShell provou ser uma camada de defesa essencial em ambientes onde o EDR pode estar ausente ou comprometido. A automação da coleta de evidências reduz o **MTTD** (Mean Time to Detect) e permite uma resposta a incidentes mais ágil e baseada em dados reais do sistema.
