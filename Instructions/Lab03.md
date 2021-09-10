# Lab 3

> All PowerShell and Command-line consoles should be opened with elevated Administrator privileges. Unless otherwise stated, all exercises will be completed from the **MIA-SQL** server with the **AdventureWorks\Student** credentials. All user account passwords are the same (**Pa55w.rd**).

## Exercise 1

## Task 1 : Prepare Variables and Server Instance

1. Download AdventureWorks Sample Database ([SQL Server 2017](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak)) to **D:\Backup** folder

2. Load the SMO assembly.

```powershell
using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Smo

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')
```

3. Import SQL Server Module

```powershell
Import-Module -Name 'SQLServer'
```

> Make sure "**SQLSERVER:**" PSDrive is exists by running this command:

```powershell
Get-PSDrive
```

4. Create a variable named **$Instance** to refer to the name of the **MIA-SQL** server:

```powershell
$Instance = "MIA-SQL"
```

5. Use SMO components to connect to the **MIA-SQL** instance using the $Server variable: 

```powershell
$Server = [Server]::new($Instance)
```

6. Create a variable to hold the database name.

```powershell
$Database = "AdventureWorks2017"
```

7. Change current directory to SQL Server PSDrive

```powershell
Set-Location "SQLSERVER:\SQL\$Instance
```

> Completed Script

```powershell
# Lab 3 Exercise 1 Task 1
using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Smo

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')

Import-Module -Name 'SQLServer'

#Make Sure you see SQLSERVER:\ in PSDrive list
Get-PSDrive

$Instance = "MIA-SQL"
$Server = [Server]::new($Instance)
$Database = "AdventureWorks2017"

Set-Location "SQLSERVER:\SQL\$Instance\DEFAULT"
```

## Task 2 : Create Database

1. Create Database 

```powershell
$DB = [Database]::new($Instance,$Database)
$DB.Create()
```
> If you want to Drop and Create call Drop() method first.

```powershell
$DB = [Database]::new($Instance,$Database)
$Server.Databases[$Database].Drop()
$DB.Create()
```
2. Set Recovery Model

```powershell
$DB.RecoveryModel = "Full"
$DB.Alter()
```

3. Change Owner

```powershell
$DB.SetOwner('Adventureworks\Administrator')
```

4. Completed Script

```powershell
# Lab 3 Exercise 1 Task 2
$DB = [Database]::new($Instance,$Database)
$DB.Create()

$DB.RecoveryModel = "Full"
$DB.Alter()

$DB.SetOwner('Adventureworks\Administrator')
```

## Task 3 : Backup / Restore Database

1. Navigate to the **Databases** folder in the SQL Server **PSDrive** Hierarchy: 

```powershell
Set-Location "SQLServer:\SQL\$Instance\DEFAULT\Databases"
```

2. Perform a backup of the AdventureWorks2017 database using the SQLServer Module backup command.
```powershell
Backup-SqlDatabase -Database "AdventureWorks2017" -BackupFile "D:\Backup\AdventureWorks2017.bak" -CompressionOption On
Restore-SQLDatabase -Database $Database -BackupFile "D:\Backup\AdventureWorks2017.bak"
```


