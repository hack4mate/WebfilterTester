function WebFilterTest {
    [CmdletBinding()]

param (
    [string]$inputFilePath,
    [string]$outputFilePath
)

# my logo 
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
Write-Host "   00100000010011110111011100 1001   "
Write-Host "  001000000100000101110111011  1001   "
Write-Host " 10111 1011 100 10111011  100 1 1011   "
Write-Host "110111 1011 100 100 1011   00 1 10111  "
Write-Host "110111      100 100 1011 1   00 10111  "
Write-Host "110111 1011 100       00 00  00 11011  "
Write-Host " 10111 1011 1011100 1011 101110 01011  "
Write-Host " 11000 1000 1011100 1011 10111011100   "
Write-Host "   0010000010111011 101110111011001    "
Write-Host "    010010001011101110111011111101     "
Write-Host "      10111011101110111011101111       "
Write-Host "        1110111011101110111011         "
Write-Host "            01101110001000             "
Write-Host "                                       "
Write-Host " ----------------------------------- "
Write-Host "|        Test your Webfilter        |"
Write-Host "|        Twitter @ Hack4Mate        |"
Write-Host " ----------------------------------- "
Write-Host "                                      "


# checks for input file
if (-not (Test-Path $inputFilePath)) {
    Write-Output "Input File '$inputFilePath' doesen't exist."
    exit
}

# Open output file to write
$outputFile = [System.IO.File]::CreateText($outputFilePath)

$inputList = Get-Content -Path $inputFilePath
foreach ($line in $inputList) {
    # Checks for title
    Start-Sleep -Seconds 2
    if ($line.Contains("#")) {
        $line | Add-Content -Path $outputFilePath
        Write-Output "Checking: $line"
    } 
    elseif ($line -eq "") {
        $line | Add-Content -Path $outputFilePath
    } 
    # Checks site
    else {
        try {
            $HTTP_Request = Invoke-WebRequest $line
            if ($HTTP_Request.StatusCode -eq 200) {
                $line | Add-Content -Path $outputFilePath
            }
        } catch {
            Write-Output "Site blocked or down: $line"
        }
    }
}

# Closes file.
$outputFile.Close()

Write-Output "Done - File with Sites that aren't blocked: $outputFilePath"

}

