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

# Function to set certificate policy
function Set-CertificatePolicy {
    if ($PSVersionTable.PSVersion.Major -eq 5 -and $PSVersionTable.PSVersion.Minor -eq 1) {
        Add-Type -TypeDefinition @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;

        public class TrustAllCertsPolicy : ICertificatePolicy {
            public bool CheckValidationResult(
                ServicePoint srvPoint, X509Certificate certificate,
                WebRequest request, int certificateProblem) {
                return true; // Trust all certificates
            }
        }
"@
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
    } else {
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
    }
}
Set-CertificatePolicy

# Function to decrypt validation logic
function Decrypt-ValidationLogic {
    param (
        [string]$encryptedValidation,
        [string]$key
    )

    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.KeySize = 256
    $aes.BlockSize = 128
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7

    $keyBytes = [Convert]::FromBase64String($key)
    $aes.Key = $keyBytes

    $fullBytes = [Convert]::FromBase64String($encryptedValidation)
    $aes.IV = $fullBytes[0..15]
    $cipherText = $fullBytes[16..$fullBytes.Length]

    $decryptor = $aes.CreateDecryptor()
    $decryptedBytes = $decryptor.TransformFinalBlock($cipherText, 0, $cipherText.Length)

    return [System.Text.Encoding]::UTF8.GetString($decryptedBytes)
}

$asciiArtUrl = "https://raw.githubusercontent.com/Reapiin/art/main/art.ps1"
$asciiArtScript = Invoke-RestMethod -Uri $asciiArtUrl
Invoke-Expression $asciiArtScript

$encodedTitle = "Q3JlYXRlZCBieSBSZWFwaWluIG9uIGRpc2NvcmQu"
$titleText = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedTitle))
$Host.UI.RawUI.WindowTitle = $titleText

function Check-SecureBoot {
    try {
        if (Get-Command Confirm-SecureBootUEFI -ErrorAction SilentlyContinue) {
            $secureBootState = Confirm-SecureBootUEFI
            if ($secureBootState) {
                Write-Host "`n[-] Secure Boot is ON." -ForegroundColor Green
            } else {
                Write-Host "`n[-] Secure Boot is OFF." -ForegroundColor Red
            }
        } else {
            Write-Host "`n[-] Secure Boot not available on this system." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "`n[-] Unable to retrieve Secure Boot status: $_" -ForegroundColor Red
    }
}
Check-SecureBoot

function Get-OneDrivePath {
    try {
        $oneDrivePath = (Get-ItemProperty "HKCU:\Software\Microsoft\OneDrive" -Name "UserFolder").UserFolder
        if (-not $oneDrivePath) {
            Write-Warning "OneDrive path not found in registry. Attempting alternative detection..."
            $envOneDrive = [System.IO.Path]::Combine($env:UserProfile, "OneDrive")
            if (Test-Path $envOneDrive) {
                $oneDrivePath = $envOneDrive
                Write-Host "[-] OneDrive path detected using environment variable: $oneDrivePath" -ForegroundColor Green
            } else {
                Write-Error "Unable to find OneDrive path automatically."
            }
        }
        return $oneDrivePath
    } catch {
        Write-Error "Unable to find OneDrive path: $_"
        return $null
    }
}

function Format-Output {
    param($name, $value)
    $output = "{0} : {1}" -f $name, $value -replace 'System.Byte\[\]', ''
    if ($output -notmatch "Steam|Origin|EAPlay|FileSyncConfig.exe|OutlookForWindows") {
        return $output
    }
}

function Log-FolderNames {
    $userName = $env:UserName
    $oneDrivePath = Get-OneDrivePath
    $potentialPaths = @("C:\Users$userName\Documents\My Games\Rainbow Six - Siege", "$oneDrivePath\Documents\My Games\Rainbow Six - Siege")
    $allUserNames = @()

    foreach ($path in $potentialPaths) {
        if (Test-Path -Path $path) {
            $dirNames = Get-ChildItem -Path $path -Directory | ForEach-Object { $_.Name }
            $allUserNames += $dirNames
        }
    }

    $uniqueUserNames = $allUserNames | Select-Object -Unique

    if ($uniqueUserNames.Count -eq 0) {
        Write-Host "`nSkipping Stats.cc Search" -ForegroundColor Yellow
    } else {
        Write-Host "`nR6 Usernames Detected. Summon Stats.cc? | (Y/N)"
        $userResponse = Read-Host

        # Log the R6 usernames into the global logEntries
        $global:logEntries += "`n==============="
        $global:logEntries += "`nR6 Usernames Detected:"

        foreach ($name in $uniqueUserNames) {
            $global:logEntries += "`n" + $name
        }

        if ($userResponse -eq "Y") {
            foreach ($name in $uniqueUserNames) {
                $url = "https://stats.cc/siege/$name"
                Write-Host " [-] Opening stats for $name on Stats.cc ..." -ForegroundColor DarkMagenta
                Start-Process $url
                Start-Sleep -Seconds 0.5
            }
        } else {
            Write-Host "Stats.cc Search Skipped" -ForegroundColor Yellow
        }
    }
}

function Find-SusFiles {
    Write-Host " [-] Finding suspicious files names..." -ForegroundColor DarkMagenta
    $susFiles = @()

    foreach ($file in $global:logEntries) {
        if ($file -match "loader.*\.exe") { $susFiles += $file }
    }

    if ($susFiles.Count -gt 0) {
        $global:logEntries += "`n-----------------`nSus Files(Files with loader in their name):`n"
        $global:logEntries += $susFiles | Sort-Object
    }
}

function Find-ZipRarFiles {
    Write-Host " [-] Finding .zip and .rar files. Please wait..." -ForegroundColor DarkMagenta
    $zipRarFiles = @()
    $searchPaths = @($env:UserProfile, "$env:UserProfile\Downloads")
    $uniquePaths = @{}

    foreach ($path in $searchPaths) {
        if (Test-Path $path) {
            $files = Get-ChildItem -Path $path -Recurse -Include *.zip, *.rar -File
            foreach ($file in $files) {
                if (-not $uniquePaths.ContainsKey($file.FullName) -and $file.FullName -notmatch "minecraft") {
                    $uniquePaths[$file.FullName] = $true
                    $zipRarFiles += $file
                }
            }
        }
    }

    return $zipRarFiles
}
function List-BAMStateUserSettings {
    Write-Host " `n [-] Fetching" -ForegroundColor DarkMagenta -NoNewline; Write-Host " UserSettings" -ForegroundColor White -NoNewline; Write-Host " Entries " -ForegroundColor DarkMagenta

    $loggedPaths = @{}

    $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings"
    $userSettings = Get-ChildItem -Path $registryPath | Where-Object { $_.Name -like "*1001" }

    if ($userSettings) {
        foreach ($setting in $userSettings) {
            $global:logEntries += "`n$($setting.PSPath)"
            $items = Get-ItemProperty -Path $setting.PSPath | Select-Object -Property *
            foreach ($item in $items.PSObject.Properties) {
                if (($item.Name -match "exe" -or $item.Name -match ".rar") -and -not $loggedPaths.ContainsKey($item.Name) -and $item.Name -notmatch "FileSyncConfig.exe|OutlookForWindows") {
                    $global:logEntries += "`n" + (Format-Output $item.Name $item.Value)
                    $loggedPaths[$item.Name] = $true
                }
            }
        }
    } else {
        Write-Host " [-] No relevant user settings found." -ForegroundColor Red
    }

    Write-Host " [-] Fetching" -ForegroundColor DarkMagenta -NoNewline; Write-Host " Compatibility Assistant" -ForegroundColor White -NoNewline; Write-Host " Entries" -ForegroundColor DarkMagenta
    $compatRegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store"
    $compatEntries = Get-ItemProperty -Path $compatRegistryPath
    $compatEntries.PSObject.Properties | ForEach-Object {
        if (($_.Name -match "exe" -or $_.Name -match ".rar") -and -not $loggedPaths.ContainsKey($_.Name) -and $_.Name -notmatch "FileSyncConfig.exe|OutlookForWindows") {
            $global:logEntries += "`n" + (Format-Output $_.Name $_.Value)
            $loggedPaths[$_.Name] = $true
        }
    }
