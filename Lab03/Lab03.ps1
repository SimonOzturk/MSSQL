using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Common
using namespace Microsoft.SqlServer.Management.Smo

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')

Install-Module -Name 'SqlServer'
Import-Module -Name 'SqlServer'
Get-PSDrive

$Instance = "MIA-SQL"
$Server = [Server]::new($Instance)
$Database = "AdventureWorks2017"

Set-Location "SQLSERVER:\SQL\$Instance\DEFAULT"


$DB = [Database]::new($Instance,$Database)
#If you want to Drop and Create Call $Server.Databases[$Database].Drop() first
$Server.Databases[$Database].Drop()
$DB.Create()

$DB.RecoveryModel = "Full"
$DB.Alter()

$DB.SetOwner('Adventureworks\Student')

Set-Location "SQLSERVER:\SQL\$Instance\DEFAULT\Databases"

Backup-SqlDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017.bak" -CompressionOption On

Restore-SQLDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017.bak"

Get-ChildItem  | Backup-SqlDatabase