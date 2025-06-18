$outputFile = "$env:USERPROFILE\Desktop\R6_ProfileLinks.txt"

# Set console colors
$X0 = $Host.UI.RawUI
$X0.BackgroundColor = "Black"
$X0.ForegroundColor = "Red"
Clear-Host

# Fancy ASCII splash
Write-Host @'
██████╗ ███╗   ███╗ █████╗     ██████╗ ██╗   ██╗██████╗ ██████╗  █████╗ 
██╔══██╗████╗ ████║██╔══██╗    ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══██╗
██║  ██║██╔████╔██║███████║    ██████╔╝██║   ██║██████╔╝██████╔╝███████║
██║  ██║██║╚██╔╝██║██╔══██║    ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══██║
██████╔╝██║ ╚═╝ ██║██║  ██║    ██████╔╝╚██████╔╝██████╔╝██████╔╝██║  ██║
╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝    ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝
'@

Start-Sleep -Milliseconds 400; Write-Host "Injecting fent reactors..."
Start-Sleep -Milliseconds 600; Write-Host "Zuko Wittally in the main frame."
Start-Sleep -Milliseconds 600; Write-Host "Thanks for the cookies..."
Start-Sleep -Milliseconds 600; Write-Host "Establishing DMA uplink..."
Start-Sleep -Milliseconds 600; Write-Host "Verifying MojoJojo Tech protocols..."
Start-Sleep -Milliseconds 600; Write-Host "Reapiin is ChatGPT made."
Start-Sleep -Milliseconds 600; Write-Host "Downloading... get_ratted_payload.dll"
Start-Sleep -Milliseconds 800; Write-Host "Bypassing firewall..."

Add-Type -AssemblyName System.Windows.Forms

$Z = @()
$Z += "`n--- Downloads folder files ---`n"
$DL = "$env:USERPROFILE\Downloads"
if (Test-Path $DL) {
    Get-ChildItem -Path $DL -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        $Z += "Found: $($_.FullName)"
    }
} else {
    $Z += "Downloads folder not found."
}

$Z += "`n--- Recycle Bin ---`n"
$sh = New-Object -ComObject Shell.Application
$rb = $sh.Namespace(0xa)
if ($rb.Items().Count -gt 0) {
    $rb.Items() | ForEach-Object {
        $Z += "Deleted File: $($_.Path)"
    }
} else {
    $Z += "Recycle Bin is empty."
}

$Z += "`n--- Registry EXE references ---`n"
$p = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)
foreach ($i in $p) {
    $Z += "`n> $i"
    if (Test-Path $i) {
        Get-ItemProperty -Path $i -ErrorAction SilentlyContinue | ForEach-Object {
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

# Copy results to clipboard safely
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Clipboard]::SetText(($Z -join "`r`n"))

Write-Host "`nScan complete. Results copied to clipboard." -ForegroundColor Green

# === Ubisoft savegames ===
$ubisoftPath = "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames"
if (Test-Path $ubisoftPath) {
    Write-Host "Found Ubisoft savegames folder. Retrieving folder names..."
    $savegameFolders = Get-ChildItem -Path $ubisoftPath -Directory | Select-Object -ExpandProperty Name
    foreach ($folder in $savegameFolders) {
        $url = "https://r6.tracker.network/r6siege/profile/ubi/$folder"
        Add-Content -Path $outputFile -Value "Ubisoft Savegame: $url"
        # Comment this out if you don't want to open all URLs
        # Start-Process $url
    }
    Write-Host "Ubisoft profile links written to $outputFile"
} else {
    Write-Host "Ubisoft savegames folder not found."
}
