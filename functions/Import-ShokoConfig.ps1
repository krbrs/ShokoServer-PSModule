function Import-ShokoConfig {
    <#
        .SYNOPSIS
        Import the PSModule configuration from config.json and fill the according variables.

        .DESCRIPTION
        Import the PSModule configuration from config.json and fill the according variables.
        Prints out the current configuration for the user to verify.

        .EXAMPLE
        Import-ShokoConfig
    #>

    [CmdletBinding()]
    Param()

    Write-Verbose "Importing current Shoko Config..."
    
    $global:shokoconfig = Get-ShokoConfig -ErrorAction 'SilentlyContinue'
    $global:ShokoURI = $shokoconfig.URI
    $global:ShokoApiKey = $shokoconfig.ApiKey
    }