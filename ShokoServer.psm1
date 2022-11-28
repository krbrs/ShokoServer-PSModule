<#
 .Synopsis
  Powershell Module for interacting with the ShokoServer API.

 .Description
  Powershell Module for interacting with the ShokoServer API. This Module lets you perform different
  actions on your ShokoServer instance from a PowerShell environment.
#>

$folderPath = Join-Path -Path "$PSScriptRoot" -ChildPath "functions"
    If (Test-Path -Path $folderPath) {
        Write-Verbose -Message "Importing $folder"
        $functions = Get-ChildItem -Path $folderPath -Filter '*.ps1' 
        ForEach ($function in $functions) {
            Write-Verbose -Message "  Importing $($function.BaseName)"
            . $($function.FullName)
        }
    }    
$availableFunctions = (Get-ChildItem -Path "$PSScriptRoot\functions" -Filter '*.ps1').BaseName
Export-ModuleMember -Function $availableFunctions

$global:shokoConfigDir = $PSScriptRoot