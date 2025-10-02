# === CONFIGURATION ===
$startDir = "S:\Vyroba"
$totalCmdPath = "C:\Program Files\totalcmd\TOTALCMD64.EXE"
$tempList = "$env:TEMP\numbered_folders.txt"

# === USER INPUT ===
$subfolderName = Read-Host "Zadej cislo zakazky"

# === CLEANUP TEMP ===
if (Test-Path $tempList) {
    Remove-Item $tempList -Force
}

# === GENERATE SORTABLE LIST ===
$folders = Get-ChildItem -Path $startDir -Directory |
    Where-Object { $_.Name -match '^\d+' } |
    ForEach-Object {
        [PSCustomObject]@{
            Num  = [int]($_.Name -replace '[^\d].*','')
            Path = $_.FullName
        }
    } |
    Sort-Object Num -Descending |
    Select-Object -ExpandProperty Path

$folders | Out-File -FilePath $tempList -Encoding UTF8

# === CHECK FOR RESULTS ===
if (-not (Test-Path $tempList) -or -not (Get-Content $tempList)) {
    Write-Host "No numbered folders found in $startDir."
    pause
    exit
}

# === SEARCH FOR SUBFOLDER ===
$foundPath = $null
foreach ($folder in $folders) {
    $checkPath = Join-Path $folder $subfolderName
    if (Test-Path $checkPath) {
        $foundPath = $checkPath
        break
    }
}

# === RESULT ===
if ($foundPath) {
    Write-Host "Opening '$foundPath' in Total Commander..."
    Start-Process -FilePath "$totalCmdPath" -ArgumentList "/O", "/L=`"$foundPath`""
} else {
    Write-Host "Subfolder '$subfolderName' not found in any numbered folder."
}

# === CLEANUP ===
if (Test-Path $tempList) {
    Remove-Item $tempList -Force
}

# SIG # Begin signature block
# MIII1wYJKoZIhvcNAQcCoIIIyDCCCMQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU/ZBbyoGix3wuidxqY1vhS26o
# ifygggZEMIIGQDCCBCigAwIBAgITRwAAAAMIHKoVJ9tPGAAAAAAAAzANBgkqhkiG
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
# MRYEFIWqaQ51XEW3clWsUO/a7UWRngwxMA0GCSqGSIb3DQEBAQUABIIBABwnwmge
# RAyYA3k8sBcGfLaIN/72DUGUi3TQV3oJHx3P3KSei1m+ROHYCKX6cxpSg8CbyUg/
# 3Nm+uuiC+f3c5PD1379O0hOBFiACX3fGTLESuOBqwCI8dBpi8oVGYvlm39doqJ2G
# s5mgYHJH/Wwu81Vklp4CAMoB50PawB1w2RVsM7sHnah3sCNmdZ3tX4BE83kRBPU6
# pXNhpM9SApiu+qsmW9RXCgXbJHrg1Mjn9VWo7prbuRLydFwVHV/UOvFishg5Zb38
# mnDD46SyN2ybZL37SOjLZjo34aEbBsx/5y87mUHgIl6exvGPJtbJlqHhoNX+l5JQ
# ZJOd0A6RhiM7oSM=
# SIG # End signature block
