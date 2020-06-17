
Write-Host "  "

$inputpath= Read-Host "Please enter the location of the input file. This should be a TXT file containing list of systems."

Write-Host "  "

$outputpath= Read-Host "Please enter the location of the output file. This should be a TXT file where all details would be extracted."

Write-Host "  "

$Serverlist = get-content -Path $inputpath

$output= foreach ($Server in $ServerList)

{

Write-Host "  "

Write-Output "------------------------------------------------------"

Write-Output "Server Name : $Server"

Write-Output "------------------------------------------------------"

Invoke-Command -ComputerName $Server -ScriptBlock { Get-ItemProperty -Path "hklm:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"}

}

$output | out-file -FilePath $outputpath -Append