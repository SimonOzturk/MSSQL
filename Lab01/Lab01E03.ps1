# https://www.nuget.org/packages/Microsoft.SqlServer.SqlManagementObjects
using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Smo

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')

# TASK 1
$Instance = "MIA-SQL"
$Server = [Server]::new($Instance)
$Server.Configuration.MaxServerMemory.ConfigValue = 2048
$Server.Configuration.Alter()
$Server.Settings.LoginMode = "Mixed"
$Server.Settings.Alter()
Invoke-SqlCmd -Query "Alter Server Configuration SET PROCESS AFFINITY CPU = 0 TO 1"