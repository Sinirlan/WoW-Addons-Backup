param ($wow,$history)

#setting up some variables
$backup_path = $PSScriptRoot                #getting path to folder in which script is placed from system variable
$date = Get-Date -Format "yyyyMMdd_HHmm"    #getting today's date
$filename_classic = $date + " - classic.zip" #setting up filename for classic backup
$filename_retail = $date + " - retail.zip"   #setting up filename for retail backup
$classic_check = test-path $wow\_classic_
$retail_check = test-path $wow\_retail_




IF ($history){ 
   #Delete files older than specified in paramter $history
   Get-ChildItem -path $backup_path | where {$_.Lastwritetime -lt (date).adddays(-$history)} | remove-item -Confirm:$false -Force -Recurse
}


IF($classic_check){
    #if classic installed zip it's addons and configs
    Compress-Archive -LiteralPath $wow\_classic_\WTF\,$wow\_classic_\Interface\ -DestinationPath $backup_path\$filename_classic
}

IF($retail_check){
    #if retail installed zip it's addons and configs
    Compress-Archive -LiteralPath $wow\_retail_\WTF\,$wow\_retail_\Interface\ -DestinationPath $backup_path\$filename_retail
}