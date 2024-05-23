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
        Write-Output "Input File '$inputFilePath' doesn't exist."
        exit
    }

    # Read input CSV
    $inputList = Import-Csv -Path $inputFilePath -Delimiter ';'
    
    # Open output file to write
    $outputFile = [System.IO.StreamWriter]::new($outputFilePath)
    "Criticality;Category;Domain;Reachable" | Add-Content -Path $outputFilePath
    
    foreach ($entry in $inputList) {
        $criticality = $entry.criticality
        $category = $entry.category
        $domain = $entry.domain

        # Check if site is reachable
        try {
            $HTTP_Request = Invoke-WebRequest $domain
            if ($HTTP_Request.StatusCode -eq 200) {
                $reachable = "Not Blocked"
                Write-Output "Can connect to site: $domain"

            } 
        } catch {
            $reachable = "Blocked"
            Write-Output "Site blocked: $domain"
        }
        # Write result to output file
        "$criticality;$category;$domain;$reachable" | Add-Content -Path $outputFilePath
    }

    # Closes file.
    $outputFile.Close()

    Write-Output "Done - Results written to: $outputFilePath"
}