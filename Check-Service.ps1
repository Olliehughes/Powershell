<#
#############################################################
    Filename:     Check Service.ps1
    Author :      Ollie Hughes                  
    Contact:      ollie_hughes@hotmail.co.uk
    Created:      22 January 2025
    Usage  :      Check and start service
    Updated:      
    Version:      1.o
#############################################################

#>

$logpath = "C:\Admin\Check_Service.log"

Start-Transcript -path $logpath

#Checking elevation rights
if (!(New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Write-Host -ForegroundColor Yellow "You're running PowerShell without elevated rights. Please open a PowerShell window as an Administrator."
  Exit
}
else {Write-Host -ForegroundColor Green "You're running PowerShell as an Administrator. Starting data collection."}


$Servers = "localhost"

$serviceName = "pla"


foreach ( $server in $servers ) {

$service = Get-Service | ? name -EQ $serviceName
write-host "Service Status is" $service.Status

If ($service.Status -eq "Stopped") {

start-service $serviceName

}

Else {

write-host "Service is Running" $serviceName

}

}

Stop-Transcript
