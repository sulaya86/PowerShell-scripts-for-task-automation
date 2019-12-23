<#      
.NOTES  
#===========================================================================  
# Script: movefilesbylimit.ps1   
# Original Script: https://gallery.technet.microsoft.com/scriptcenter/Robocoy-Files-to-Remote-bdfc5154#content
# Comments: The original script was modified to send files by chunks instead all at once  
#===========================================================================  
.DESCRIPTION  
        make sure to change these variables to make it fit into your scenario 
        
        Change $source  = "\\YourOwn\UNCPath\Source\"
        Change $destination = "\\YourOwn\UNCPath\Destination\"
        Change $limit_of_files = 50
#===========================================================================
#>  

$Space          = Write-host ""
$source         = '\\YourOwn\UNCPath\Source\'
$destination    = '\\YourOwn\UNCPath\Destination\'
$date           = Get-Date -UFormat "%Y%m%d"
$logfile        = "c:\temp\Robocopy1-$date.txt" 
$what           = @("/S","/E","/Z","/MOV") 
$options        = @("/R:5","/W:5","/NP","/LOG+:$logfile") 
$limit_of_files = 50

## Get Start Time 
$startDTM = (Get-Date) 
$Space  
$Space
Write-Host "........................................." -Fore Blue 

## Provide Information 
Write-host "Copying Files into $destination ....................." -fore Green -back black 
Write-Host "........................................." -Fore Blue 


## Copy with options defined  
get-childItem $source | Select-Object -First $limit_of_files | 
Foreach-Object { 
    $s          = (Split-Path $_.FullName) 
    $d          = $destination
    $filename   = $_.Name
    $cmdArgs        = @("$s","$d", "$filename",$what,$options)

    robocopy @cmdArgs 

    Write-Host $cmdArgs
}

## Get End Time 
$endDTM = (Get-Date)

## Echo Time elapsed 
$Time = "Elapsed Time: $(($endDTM-$startDTM).totalminutes) minutes" 

## Provide time it took 
Write-host "" 
Write-host " Copy Files to $DestFolder has been completed......" -fore Green -back black 
Write-host " Copy Files to $DestFolder took $Time        ......" -fore Blue 