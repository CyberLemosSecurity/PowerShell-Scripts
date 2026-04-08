# PowerShell Threat Detection: Reverse Shell Monitoring

### 1. Objective
This lab focuses on leveraging PowerShell as a tool for **Threat Hunting** and **Incident Response**. The primary goal is to develop an automated script capable of detecting suspicious network connections—potential C2 Beacons or Reverse Shells—originating from native system processes such as `powershell.exe` and `cmd.exe`.

### 2. Lab Environment
* **Code Editor:** Visual Studio Code (VS Code)
* **Extensions:** PowerShell Extension (Microsoft)
* **Operating System:** Windows 10/11 or Windows Server
* **PowerShell Version:** 5.1 / 7.x (Cross-platform)
* **Support Tools:** VS Code Integrated Terminal with **Administrator privileges**.

---

### 3. Technical Implementation
The script `Detect-SuspiciousConn.ps1` performs correlation between the **OwningProcess ID** and open network sockets, filtering for ports commonly utilized in attacks (e.g., 4444, 8080).

> **Note:** The full source code is available in `scripts/Detect-SuspiciousConn.ps1`.

---

### 4. Results Analysis
During execution, the script demonstrated high efficacy in data correlation:
* **Visibility:** Real-time identification of the specific process initiating external connections.
* **LotL (Living-off-the-Land) Detection:** Capability to flag legitimate Microsoft tools when they are abused for external communication.
* **Visual Alerts:** Implementation of `Write-Host` with color-coded outputs to facilitate rapid triaging for SOC analysts.

---

### 5. Risks and Opportunities (Strategic Overview)
* **Evasion Risk:** Attackers may use **Process Injection** to hide connections within trusted processes (e.g., `explorer.exe`).
* **False Positives:** VPN software or legitimate update agents may trigger alerts on high-range ports. Implementing a robust **Allowlist** is the recommended next step.
* **Future Improvement:** Integrate digital signature verification (`Get-AuthenticodeSignature`) to validate executable integrity.

---

### 6. Conclusion
PowerShell serves as an essential defense layer, particularly in environments where EDR might be absent or compromised. Automating evidence collection significantly reduces **MTTD** (Mean Time to Detect) and enables an agile incident response based on real-time system telemetry.
