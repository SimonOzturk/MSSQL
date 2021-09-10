using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Common
using namespace Microsoft.SqlServer.Management.Smo

$Config = Get-Content .\Config.json | ConvertFrom-Json
$Config.Imports | ForEach-Object { Import-Module $_}

Import-Module -Name 'SqlServer'
Get-PSDrive

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')

$Instance = "MIA-SQL"
#$Server = [Microsoft.SqlServer.Management.Smo.Server]::new($Instance)
$Server = [Server]::new($Instance)
$Server
$Database = "AdventureWorks2017"

Set-Location "SQLSERVER:\SQL\$Instance\DEFAULT"

$DB = [Database]::new($Instance, $Database)
#$Server.Databases["DatabaseName"].Drop()
$DB.Create()

$Db.RecoveryModel = $Config.Policy.RecoveryModel
$Db.Alter()

$DB.SetOwner('ADVENTUREWORKS\Student')
$Server.Databases

Restore-SQLDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017.bak"

$RelocateData = [RelocateFile]::new("AdventureWorks2017", "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017.mdf")
$RelocateLog = [RelocateFile]::new("AdventureWorks2017_Log", "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017_log.ldf")

Restore-SqlDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017.bak" -RelocateFile @($RelocateData, $RelocateLog) -ReplaceDatabase

Backup-SqlDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017NoComp.bak"
Backup-SqlDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017WithComp.bak" -CompressionOption On

# Backup All Databases in Instance
Get-ChildItem  | Backup-SqlDatabase

$Servers = @("MIA-DC","MIA-SQL")

foreach ($svr in $Servers) {
    Enter-PSSession $svr

    $svr
    Get-Service *WinRM*

    Exit-PSSession
}

Set-Location SQLSERVER:\SQL\$Instance\
Get-ChildItem | ForEach-Object {
    if ($_.Name -ne $Instance) {
        Set-Location "SQLSERVER:\SQL\$Instance\$($_.Name)\Databases"
        Get-ChildItem ##| Backup-SqlDatabase
    }
    else {
        Set-Location "SQLSERVER:\SQL\$Instance\DEFAULT\Databases"
        Get-ChildItem ##| Backup-SqlDatabase
    }
}