Install-Module -Name 'SqlServer' -Confirm:$false -Force
Install-Module -Name 'SQLPS'


Import-Module -Name 'SqlServer'

Enter-PSSession MIA-DC
Import-Module -Name "ActiveDirectory"
$User = @{
    Name              = "User1"
    GivenName         = "Test"
    Surname           = "User"
    SamAccountName    = "User1"
    UserPrincipalName = "user1@adventureworks.msft"
    Enabled           = $true
}
New-ADUser @User -AccountPassword(ConvertTo-SecureString -AsPlainText 'Pa55w.rd' -Force)
Exit-PSSession


Get-SQLDatabase AWDB

Get-Command -Module SqlServer

Import-Module SQLPs
Clear-Host
$Credential = Get-Credential -UserName 'PSSA' -Message 'PowerShell SysAdmin Password'

Get-Childitem | ForEach-Object {
    $Login = Add-SqlLogin -LoginName $Credential.UserName -LoginType 'SqlLogin' -ServerInstance $_.Name -LoginPSCredential $Credential -Enable
    $Login.AddToRole('sysadmin')
}


Restart-Service MSSQLSERVER -Force

$Credential = Get-Credential -UserName 'SqlLogin1' -Message "SQL Admin Password"
$Instance = Get-SqlInstance -Credential $Credential -ServerInstance "127.0.0.1:1433"