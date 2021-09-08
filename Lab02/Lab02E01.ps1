# https://www.nuget.org/packages/Microsoft.SqlServer.SqlManagementObjects
using namespace Microsoft.SqlServer.Management.Smo
[System.Reflection.Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')

#LAB 2

#TASK 1
$Instance = "MIA-SQL"   
$User1 = "AdventureWorks\User1"
$Server = [Server]::new($Instance)
$Server.ConnectionContext.ExecuteWithResults("CREATE DATABASE AWDB")

#TASK 2
$Login = [Login]::new($Instance,$User1)
$Login.LoginType = "WindowsUser"
$Login.Create()
$Login.AddToRole("dbcreator")

#TASK 3
$SQLLogin1 = "SQLLogin1"
$Password = 'Pa55w.rd'
$LoginSQL = [Login]::new($Instance,$SQLLogin1)
$LoginSQL.LoginType = "SQLLogin"
$LoginSQL.Create($Password)
$AWDB = $Server.Databases["AWDB"]
$DBUser = [User]::new($AWDB, $SQLLogin1)
$DBUser.Login = $SQLLogin1
$DBUser.DefaultSchema = "dbo"
$DBUser.Create()
$db_ddladmin = $AWDB.roles["db_ddladmin"]
$db_ddladmin.AddMember($SQLLogin1)
$db_datawriter = $AWDB.roles["db_datawriter"]
$db_datawriter.AddMember($SQLLogin1)

#TASK 4
Import-Module -Name 'SQLServer'
$Connection = @{
    ServerInstance = "MIA-SQL"
    UserName = "SQLLogin1"
    Password  = 'Pa55w.rd'
    Database = "AWDB"
}
Invoke-SQLCMD @Connection -Query 'Create Table Contacts (ID INT, FirstName NVarChar(50), LastName NVarChar(50))'
Invoke-SQLCMD @Connection -Query "Insert Contacts Values(1,'John', 'Brown')"
Invoke-SQLCMD @Connection -Query "SELECT * FROM Contacts"