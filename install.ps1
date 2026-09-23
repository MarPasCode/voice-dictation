# Registers a silent startup task for the voice dictation server on every Windows login.
# Usage: .\install.ps1            (port from config.json, defaults to 7778)
#        .\install.ps1 -Port 8081 (saves a custom port to config.json)

param(
    [int]$Port
)

# Folder this script lives in — used to locate config.json and start-hidden.vbs.
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# If a custom port was passed, persist it to config.json so server.js picks it up.
if ($Port) {
    $configPath = Join-Path $scriptDir "config.json"
    @{ port = $Port } | ConvertTo-Json | Set-Content -Path $configPath -Encoding utf8
    Write-Output "Port set to $Port in config.json"
}

# Windows Startup folder and the shortcut that will silently launch the server there.
$startupFolder = [Environment]::GetFolderPath("Startup")
$shortcutPath = Join-Path $startupFolder "VoiceDictation.lnk"
$vbsPath = Join-Path $scriptDir "start-hidden.vbs"

# Create the autostart shortcut, running start-hidden.vbs via wscript.exe (no visible window).
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = "wscript.exe"
$Shortcut.Arguments = "`"$vbsPath`""
$Shortcut.WorkingDirectory = $scriptDir
$Shortcut.Description = "Voice dictation - autostart"
$Shortcut.Save()

Write-Output "Autostart registered: $shortcutPath"
Write-Output "The server will start silently on every Windows login."

# Start the server immediately so it can be tested without a reboot.
Start-Process wscript.exe -ArgumentList "`"$vbsPath`"" -WindowStyle Hidden
Start-Sleep -Milliseconds 500
Write-Output "Server started now. To remove autostart, delete: $shortcutPath"
