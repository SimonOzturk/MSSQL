# https://www.nuget.org/packages/Microsoft.SqlServer.SqlManagementObjects
using namespace Microsoft.SqlServer.Management.Smo
[System.Reflection.Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')


$Instance = "MIA-SQL"   
$User1 = "AdventureWorks\User1"
$Server = [Server]::new($Instance)
$Server.ConnectionContext.ExecuteWithResults("CREATE DATABASE AWDB")