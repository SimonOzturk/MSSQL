using namespace System.Net
[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

Install-Module -Name 'SqlServer' -Confirm:$false -Force

Import-Module -Name 'SqlServer'