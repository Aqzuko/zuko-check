$outputFile = "$env:USERPROFILE\Desktop\R6_ProfileLinks.txt"
$X0 = $Host.UI.RawUI
$X0.BackgroundColor = ([string][char]66 + [char]108 + [char]97 + [char]99 + [char]107)
$X0.ForegroundColor = ([string][char]82 + [char]101 + [char]100)
&('C'+'lear-Host')

&('W'+'rite-Host') @'
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
'@

$sleep = 'Start' + '-Sleep'
$w = 'W' + 'rite' + '-Host'

&$sleep -Milliseconds 400; &$w "Injecting mainframe hooks..."
&$sleep -Milliseconds 600; &$w "Zuko Wittally in the main frame."
&$sleep -Milliseconds 600; &$w "Thanks for the cookies..."
&$sleep -Milliseconds 600; &$w "Shout out to Reapiin Tech..."
&$sleep -Milliseconds 600; &$w "Establishing DMA uplink..."
&$sleep -Milliseconds 600; &$w "Verifying MojoJojo Tech protocols..."
&$sleep -Milliseconds 600; &$w "Reapiin uses ChatGPT..."
&$sleep -Milliseconds 600; &$w "Reapiin is ChatGPT made."
&$sleep -Milliseconds 600; &$w "Downloading... get_ratted_payload.dll"
&$sleep -Milliseconds 800; &$w "Bypassing firewall shadows..."
&$sleep -Milliseconds 600; &$w "System hook injected successfully."

Add-Type -AssemblyName ([string]::Join('', @([char]83,121,115,116,101,109,46,87,105,110,100,111,119,115,46,70,111,114,109,115)))

$Z = @()
$DL = "$env:USERPROFILE\Downloads"
$Z += "`n--- Downloads folder files ---`n"
if (Test-Path $DL) {
    Get-ChildItem -Path $DL -Recurse -ErrorAction SilentlyContinue | % {
        $Z += "Found: $($_.FullName)"
    }
} else {
    $Z += "Downloads folder not found."
}

$Z += "`n--- Recycle Bin ---`n"
$sh = New-Object -ComObject ("Shell." + "Application")
$rb = $sh.Namespace(0xa)
if ($rb.Items().Count -gt 0) {
    $rb.Items() | % {
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
        Get-ItemProperty -Path $i -ErrorAction SilentlyContinue | % {
            $_.PSObject.Properties | % {
                if ($_.Value -match "\.exe") {
                    $Z += "$($_.Name): $($_.Value)"
                }
            }
        }
    } else {
        $Z += "Path not found."
    }
}

[System.Windows.Forms.Clipboard]::SetText($Z -join "`r`n")
&$w "`nScan complete. Results copied to clipboard." -ForegroundColor Green


# === Ubisoft savegames profile linking ===
$ubisoftPath = "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames"
if (Test-Path $ubisoftPath) {
    Write-Host "Found Ubisoft savegames folder. Retrieving folder names..."
    $savegameFolders = Get-ChildItem -Path $ubisoftPath -Directory | Select-Object -ExpandProperty Name
    foreach ($savegameFolder in $savegameFolders) {
        $url = "https://r6.tracker.network/r6siege/profile/ubi/$savegameFolder"
        Add-Content -Path $outputFile -Value "Ubisoft Savegame: $url"
        Start-Process $url
    }
    Write-Host "Ubisoft profile links opened in browser."
} else {
    Write-Host "Ubisoft savegames folder not found."
}
