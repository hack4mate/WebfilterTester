# URLchecker.ps1

# Installation der 'requests'-Bibliothek, falls nicht vorhanden
try {
    $null = [System.Reflection.Assembly]::LoadWithPartialName('System.Net.Http')
}
catch {
    Write-Host "Request library not found, please install it before proceeding"
    exit
}

# Deaktiviere Warnungen
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Add-Type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

Write-Host "                                    011"
Write-Host "                                  110  "
Write-Host "                                110    "
Write-Host "                             11011     "
Write-Host "                            1001       "
Write-Host "                          1100         "
Write-Host "        1011001101110111011001         "
Write-Host "      1011:::...        1011011        "
Write-Host "     100::::::::....  1100   100       "
Write-Host "    10111011101110111011101110111      "
Write-Host "   10111011101110111011101110011001    "
Write-Host "  1011101110111011101110111011  1001   "
Write-Host " 10111 1011 100 10111011  100 1 1011   "
Write-Host "110111 1011 100 100 1011   00 1 10111  "
Write-Host "110111      100 100 1011 1   00 10111  "
Write-Host "110111 1011 100       00 00  00 11011  "
Write-Host " 10111 1011 1011100 1011 101110 01011  "
Write-Host " 11000 1000 1011100 1011 10111011100   "
Write-Host "   1011101110111011 101110111011001    "
Write-Host "    101110111011101110111011111101     "
Write-Host "      10111011101110111011101111       "
Write-Host "        1110111011101110111011         "
Write-Host "            01101110001000             "
Write-Host "                                       "
Write-Host " ----------------------------------- "
Write-Host "|        Test your Webfilter        |"
Write-Host "|        Twitter @ Hack4Mate        |"
Write-Host " ----------------------------------- "
Write-Host "                                      "

function Usage {
    $scriptName = $MyInvocation.MyCommand.Name
    $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Path -Leaf

    if ($scriptPath -eq $scriptName) {
        $scriptPath = "./$scriptName"
    }

    Write-Host "Usage: $scriptPath -s <List of URLs to test against> -o <Output file (CSV)>`n"
    Write-Host "    -s: List of URLs to test against"
    Write-Host "    -o: Output file (CSV)"
}

function Start-URLCheck {
    param (
        [string]$siteList,
        [string]$outputFile
    )

    $results = "init"

    $myList = Get-Content $siteList

    foreach ($line in $myList) {
        try {
            $bob = "http://$line"
            $res = Invoke-WebRequest -Uri $bob -TimeoutSec 6 -UseBasicParsing -ErrorAction Stop
            $results = "$line,PASS,0"
        }
        catch [System.Net.WebException] {
            $errorCode = $_.Exception.Response.StatusCode.value__
            $results = "$line,FAIL,$errorCode"
        }
        catch {
            $results = "$line,FAIL,Unknown"
        }

        Write-Host $results
        Add-Content -Path $outputFile -Value "$results"
    }
}

if ($args.Count -lt 4) {
    Usage
    exit
}

try {
    $opts = Getopt -args $args -options 's:o:' -longoptions 'siteList:,outputFile:' -passThru -errorAction Stop
}
catch {
    Usage
    exit
}

$siteList = ""
$outputFile = ""

foreach ($opt in $opts) {
    switch ($opt.Name) {
        's' {
            $siteList = $opt.Value
        }
        'o' {
            $outputFile = $opt.Value
        }
    }
}

Start-URLCheck -siteList $siteList -outputFile $outputFile
