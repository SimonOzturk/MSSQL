# MSSQL
PowerShell for MSSQL Administrators

## PowerShell Gallery

### Transport Layer Security

#### PowerShell Gallery TLS Support

> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS) versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS 1.2
[PowerShell Gallery TLS Support](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/)

```powershell
using namespace System.Net
[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12
```

or

```powershell
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
```

#### Repository

The Set-PSRepository cmdlet sets values for a registered module repository. The settings are persistent for the current user and apply to all versions of PowerShell installed for that user.

This command sets the installation policy for the PSGallery repository to Trusted, so that you are not prompted before installing modules from that source.

```powershell
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
```

### Policy

> The Set-ExecutionPolicy cmdlet changes PowerShell execution policies for Windows computers. For more information [Set-ExecutionPolicy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.1)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

### Modules

#### Install Modules

Downloads one or more modules from a repository, and installs them on the local computer.

```powershell
Install-Module -Name 'SqlServer' -Confirm:$false -Force
```

Adds modules to the current session.

#### Import Modules

```powershell
Import-Module -Name 'SqlServer'
```

### Connecting Services

#### PowerShell Session

Creates a persistent connection to a local or remote computer.

```powershell
New-PSSession
```

The New-PSSession cmdlet creates a PowerShell session (PSSession) on a local or remote computer. When you create a PSSession, PowerShell establishes a persistent connection to the remote computer.

Use a PSSession to run multiple commands that share data, such as a function or the value of a variable. To run commands in a PSSession, use the Invoke-Command cmdlet. To use the PSSession to interact directly with a remote computer, use the Enter-PSSession cmdlet. For more information,

You can run commands on a remote computer without creating a PSSession by using the ComputerName parameters of Enter-PSSession or Invoke-Command. When you use the ComputerName parameter, PowerShell creates a temporary connection that is used for the command and is then closed.

##### Example 1: Create a session on the local computer

```powershell
$s = New-PSSession
```

This command creates a new PSSession on the local computer and saves the PSSession in the $s variable.

You can now use this PSSession to run commands on the local computer.

##### Example 2: Create a session on a remote computer

```powershell
$Server01 = New-PSSession -ComputerName Server01
```

This command creates a new PSSession on the Server01 computer and saves it in the $Server01 variable.

When creating multiple PSSession objects, assign them to variables with useful names. This will help you manage the PSSession objects in subsequent commands.

###### Example 3: Create sessions on multiple computers

```powershell
$s1, $s2, $s3 = New-PSSession -ComputerName Server01,Server02,Server03
```

This command creates three PSSession objects, one on each of the computers specified by the ComputerName parameter.

The command uses the assignment operator (=) to assign the new PSSession objects to variables: $s1, $s2, $s3. It assigns the Server01 PSSession to $s1, the Server02 PSSession to $s2, and the Server03 PSSession to $s3.

When you assign multiple objects to a series of variables, PowerShell assigns each object to a variable in the series respectively. If there are more objects than variables, all remaining objects are assigned to the last variable. If there are more variables than objects, the remaining variables are empty (null).