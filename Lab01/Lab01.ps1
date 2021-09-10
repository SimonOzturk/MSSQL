# https://www.nuget.org/packages/Microsoft.SqlServer.SqlManagementObjects
using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Smo

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')

# Exercise 3

# TASK 1
$Instance = "MIA-SQL"
$Server = [Server]::new($Instance)
$Server.Configuration.MaxServerMemory.ConfigValue = 2048
$Server.Configuration.Alter()
$Server.Settings.LoginMode = "Mixed"
$Server.Settings.Alter()
Invoke-SqlCmd -Query "Alter Server Configuration SET PROCESS AFFINITY CPU = 0 TO 1"

# Exercise 4

# TASK 1

Set-Location "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Policies\DatabaseEngine\1033"

Set-Location "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Policies"
Get-ChildItem
Get-ChildItem "DatabaseEngine\1033\Backup and Data File Location.xml" | Invoke-PolicyEvaluation -TargetServer MIA-SQL
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL"
New-Item -Path "D:\" -Name "Temp" -ItemType Directory
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL" -OutputXML > "D:\Temp\MIA-SQL_Evaluation.xml"
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL\SQL2" -OutputXML > "D:\Temp\MIA-SQL-SQL2_Evaluation.xml"
Get-ChildItem "D:\Temp\*.XML"
