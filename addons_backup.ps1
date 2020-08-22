param (
    [Parameter(Mandatory=$true)]
    $wow_folder,
    [int]$history)

#setting up some variables
$backup_path = $PSScriptRoot                #getting path to folder in which script is placed from system variable
$date = Get-Date -Format "yyyyMMdd_HHmm"    #getting today's date
$filename_classic = $date + " - classic.zip" #setting up filename for classic backup
$filename_retail = $date + " - retail.zip"   #setting up filename for retail backup
$classic_path = "$wow_folder\_classic_"
$retail_path = "$wow_folder\_retail_"
$classic_check = test-path $classic_path
$retail_check = test-path $retail_path
 

Write-Host "Wow Folder: $wow_folder"
Write-Host "Classic: $classic_path"
Write-Host "Retail: $retail_path"

IF ($history){ 
   #Delete files older than specified in paramter $history
   Get-ChildItem *.zip -path $backup_path | where {$_.Lastwritetime -lt (date).adddays(-$history)} | remove-item -Confirm:$false -Force -Recurse
}


IF($classic_check){
    #if classic installed zip it's addons and configs
    Compress-Archive -LiteralPath "$classic_path\WTF\","$classic_path\Interface\" -DestinationPath $backup_path\$filename_classic
}

IF($retail_check){
    #if retail installed zip it's addons and configs
    Compress-Archive -LiteralPath "$retail_path\WTF\","$retail_path\Interface\" -DestinationPath $backup_path\$filename_retail
}