# Lab 1

> All PowerShell and Command-line consoles should be opened with elevated Administrator privileges. Unless otherwise stated, all exercises will be completed from the **MIA-SQL** server with the **AdventureWorks\Student** credentials. All user account passwords are the same (**Pa55w.rd**).

# Exercise 3

We will configure SQL Server using SQL Server Management Objects (SMO).

> 30 minitues

## Task 1 : Configure SQL Server with SMO

1. Load SQL Server SMO:

```powershell
using namespace System.Reflection
using namespace Microsoft.SqlServer.Management.Smo

[Assembly]::LoadWithPartialname('Microsoft.SQLServer.SMO')
```

2. Create a variable named **$Instance** to refer to the name of the **MIA-SQL** server:

```powershell
$Instance = "MIA-SQL"
```

3. Use SMO components to connect to the **MIA-SQL** instance using the $Server variable: 

```powershell
$Server = [Server]::new($Instance)
```

4. Change the maximum memory assigned to **MIA-SQL** to 2048MB:

```powershell
$Server.Configuration.MaxServerMemory.ConfigValue = 2048
```

5. Save the new memory configuration changes to the **MIA-SQL** instance:

```powershell
$Server.Configuration.Alter()
```

6. Change the login mode to mixed to allow the use of Windows and SQL Server based authentication: 

```powershell
$Server.Settings.LoginMode = "Mixed"
```

7. Apply the authentication mode change to the **MIA-SQL** instance: 

```powershell
$Server.Settings.Alter()
```

8. Configure the default **MIA-SQL** instance to use only the first two processors on the server: 

```powershell
Invoke-SqlCmd -Query "Alter Server Configuration SET PROCESS AFFINITY CPU = 0 TO 1"
```

> Completed Configuration Script

```powershell
$Instance = "MIA-SQL"
$Server = [Server]::new($Instance)
$Server.Configuration.MaxServerMemory.ConfigValue = 2048
$Server.Configuration.Alter()
$Server.Settings.LoginMode = "Mixed"
$Server.Settings.Alter()

Invoke-SqlCmd -Query "Alter Server Configuration SET PROCESS AFFINITY CPU = 0 TO 1"
```

# Exercise 4

We will evaluate SQL Server policies using PowerShell

> 30 minitues

## Task 1 : SQL Server Policy

1. Change the working directory to the folder where the policy files are stored: 

```powershell
Set-Location "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Policies"
```

2. List the folders in the policies directory:

```powershell
Get-ChildItem
```

3. Default policy files exist for the **Analysis Services**, **Reporting Services** and **Database Engine** features in each of the listed folders.

4. List the policy files for the Database Engine feature: 

```powershell
Get-ChildItem "DatabaseEngine\1033"
```

5. Evaluate **MIA-SQL** with the "backup and data file location" policy file: 

```powershell
Get-ChildItem "DatabaseEngine\1033\Backup and Data File Location.xml" | Invoke-PolicyEvaluation -TargetServer MIA-SQL
```

6. Evaluate **MIA-SQL** with all the Database Engine policy files: 

```powershell
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer MIA-SQL
```

7. Export the policy evaluation data for **MIA-SQL** to an XML file: 

```powershell
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL" -OutputXML "D:\Temp\MIA-SQL_Evaluation.xml"
```

8. Export the policy evaluation data for **MIA-SQL\SQL2** to an XML file: 

```powershell
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL\SQL2" -OutputXML "D:\Temp\MIA-SQL-SQL2_Evaluation.xml"

9. Verify the evaluations of the MIA-SQL and SQL2 instances were saved: 

```powershell
Get-ChildItem "D:\Temp\*.XML"
```

10. Completed Script

```powershell
Set-Location "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Policies"
Get-ChildItem
Get-ChildItem "DatabaseEngine\1033\Backup and Data File Location.xml" | Invoke-PolicyEvaluation -TargetServer MIA-SQL
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL"
New-Item -Path "D:\" -Name "Temp" -ItemType Directory
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL" -OutputXML > "D:\Temp\MIA-SQL_Evaluation.xml"
Get-ChildItem "DatabaseEngine\1033" | Invoke-PolicyEvaluation -TargetServer "MIA-SQL\SQL2" -OutputXML > "D:\Temp\MIA-SQL-SQL2_Evaluation.xml"
Get-ChildItem "D:\Temp\*.XML"
```

