Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

Install-Module -Name 'SqlServer' -Confirm:$false -Force


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