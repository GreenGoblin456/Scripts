# === CONFIGURATION ===
$startDir = "S:\Vyroba"
$totalCmdPath = "C:\Program Files\totalcmd\TOTALCMD64.EXE"

# === ASK USER ===
$subfolderName = Read-Host "Zadej cislo zakazky"

# === COLLECT FOLDERS ===
$folderItems = Get-ChildItem $startDir
$numberedFolders = @()

foreach ($item in $folderItems) {
    if ($item.PSIsContainer -and ($item.Name -match '^\d+')) {
        $digits = [regex]::Match($item.Name, '^\d+').Value
        $entry = New-Object PSObject
        $entry | Add-Member NoteProperty Num ([int]$digits)
        $entry | Add-Member NoteProperty Path $item.FullName
        $numberedFolders += $entry
    }
}

# === SORT BY NUM DESC ===
$sorted = $numberedFolders | Sort-Object Num -Descending

# === SEARCH FOR MATCHING SUBFOLDER ===
$found = $false

foreach ($entry in $sorted) {
    $candidate = $entry.Path + "\" + $subfolderName
    if (Test-Path $candidate) {
        Write-Host "Opening $candidate in Total Commander..."
        & "$totalCmdPath" /O /L="$candidate"
        $found = $true
        exit
    }
}

if (-not $found) {
    Write-Host "Subfolder '$subfolderName' not found in any numbered folder."
}

Write-Host "`nPress any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# SIG # Begin signature block
# MIII1wYJKoZIhvcNAQcCoIIIyDCCCMQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU1JBqeFmIC2sGUOHaRuxCn9yi
# +HagggZEMIIGQDCCBCigAwIBAgITRwAAAAMIHKoVJ9tPGAAAAAAAAzANBgkqhkiG
# 9w0BAQsFADBFMRQwEgYKCZImiZPyLGQBGRYEcHJnYjESMBAGCgmSJomT8ixkARkW
# AkFEMRkwFwYDVQQDExBBRC1GSUxFU0VSVkVSLUNBMB4XDTI1MDcyNzE1MzUxNVoX
# DTI3MDcyNzE1MzUxNVowGDEWMBQGA1UEAwwNRGFuaWVsIERpdmnFoTCCASIwDQYJ
# KoZIhvcNAQEBBQADggEPADCCAQoCggEBAPNa+WSXmbpeYQnmxENlkjV9B/fjA1ch
# yWab1jWAxqu8OqxCvZZiHn+xHNtwXRFbcpKVf+6rsv+qbwxH9le9rx+RLu1Z9rZJ
# ApWBimGdsWY1F9JhxMTNlbwnaYCMQMA+xLWn2ILz0KtyfEiNeZ7kEMUtb3ecg606
# qcXUGMY0/fVqBDuheaP2zihd0jy+Ln0Uj2nWb7X8ALKIBwBweSvfAWdtZ28wjb6k
# Cap19ufYvfhrpWPh7ldP7iPsGZUfCEdH6YHQOg10p69rINjYydJEC1zQ6uV5sJAT
# atZWO2+hVLHvOOWzmP0mAH+PYQtTl3bSrUH90uEis745150qX6TpDIECAwEAAaOC
# AlQwggJQMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCISxoWOE68U+hJ2FHOCY
# U6qLDoEXiq47guL6ZgIBZAIBAzATBgNVHSUEDDAKBggrBgEFBQcDAzAOBgNVHQ8B
# Af8EBAMCB4AwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQU
# hl8N2HWiqkqYTbeGTs62BTybbXUwHwYDVR0jBBgwFoAUWDrCrOaoZLDxonsrSU/+
# eGJewSUwgc0GA1UdHwSBxTCBwjCBv6CBvKCBuYaBtmxkYXA6Ly8vQ049QUQtRklM
# RVNFUlZFUi1DQSxDTj1GaWxlU2VydmVyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
# MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPUFELERD
# PXByZ2I/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
# PWNSTERpc3RyaWJ1dGlvblBvaW50MIG+BggrBgEFBQcBAQSBsTCBrjCBqwYIKwYB
# BQUHMAKGgZ5sZGFwOi8vL0NOPUFELUZJTEVTRVJWRVItQ0EsQ049QUlBLENOPVB1
# YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
# b24sREM9QUQsREM9cHJnYj9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9
# Y2VydGlmaWNhdGlvbkF1dGhvcml0eTANBgkqhkiG9w0BAQsFAAOCAgEAoF7U/SYG
# a5ji1GDD5kiSzvtcbUR2yaXwX6djjLIVSu6+WdDFseEfYazEZUqn0VLY5z+u5x10
# k7gz81wAURBdHRt4WtsgBpeI/u3/CbgKjXGKO0KlATZWX7UbFkoI8Ude+h/69PUG
# NZrHsRkjWvgzgkimn1P01gl0lADjfwaKPiheoKESov6+2kourllq2I3JCvjbL/HI
# iW+seuILqRA0s2eajUFN6A6re2sOC+3xHrIZuNrNkuyss75WCr3JDyzPMWSXf3v+
# fb97OP0hhInZ5n4aJRz+r118plKpq9+8q7BlAxMlVYaEVVKIwJWvC9KtdWuRLgXW
# volFxS1ld4SK3CK0uhIxzUhph3lPwXO8YGKvns8E4W2T6hTaviBdq1mfHVkmg49b
# QvIQ6Uuqtpe/sVTLyK7nAdGuE5Dt4LqJVVmLcb1Ri8kBP+iqKtoK9Gcc8f25Uf1y
# Pwxtxm6HbB4JAu6qGtFL9UfxGF5l2DJ4/C/3vnDIpbwPp/5S5DkGyWxiBie0U3eA
# 0dn+CbedDDfKseGxBh6nGTpVYMgBgouk7f30ZQHkdlfbKeI7RN982WmcnxXwcw+S
# CRt4daic79z0t3utdhq3h3xEksMYzeUaDysO+Yy+z9OO26SgHh/WBUcFK/cIEYCj
# 4tECI3smMDMXwyXor7cVAJUpmC2Sp9vQdJYxggH9MIIB+QIBATBcMEUxFDASBgoJ
# kiaJk/IsZAEZFgRwcmdiMRIwEAYKCZImiZPyLGQBGRYCQUQxGTAXBgNVBAMTEEFE
# LUZJTEVTRVJWRVItQ0ECE0cAAAADCByqFSfbTxgAAAAAAAMwCQYFKw4DAhoFAKB4
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkE
# MRYEFMuOo5QcPzUlgvrp1H8pJ5T2NPypMA0GCSqGSIb3DQEBAQUABIIBAO+FD2zC
# 939pnA9crQbl0tYm/l6Mony9r+9IXYBGUHNo+egCP12BQyXd5r05suL5CqyBlGCR
# 3vtwgqsejc+8PplqL45j6Hf0Eq8inuJ3Fveh+NQ7Z8vG1PUWkgEPzjImgS15xIki
# xJfgVCB8/lm5zNBKqvkrZetsMdL0MPd3cFcTkLVRYP1BUN446Ka177kzQRXhkKw6
# A80XJwJ1A6iJzAfW8dxXNvBeHRmox53Bd2gSpX3dRF4r+fQbQ7UwisHIA1fJh6FV
# L1zdF1oJsv+Mf8F+zg9D9hpmu5Vom4HRWuCL/n5AE1k+gBwKBJj2D/QnFz0Oi/9Q
# w159JPT+QrhO0Kk=
# SIG # End signature block
