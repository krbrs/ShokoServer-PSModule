function Get-ShokoConfig {
    <#
        .SYNOPSIS
        Get the server parameters for ShokoServer.

        .DESCRIPTION
        Get the server parameters for ShokoServer.

        .EXAMPLE
        Get-ShokoConfig
    #>

    [CmdletBinding()]
    Param()

    try {
        Write-Verbose -Message 'Getting content of config.json'
        $config = Get-Content -Path "$shokoConfigDir\config.json" -ErrorAction 'Stop' | ConvertFrom-Json

        $config = [PSCustomObject] @{
            URI = $config.URI.ShokoURI;
            ApiKey   = $config.ApiKey.ShokoApiKey;
        }

        return $config
    } catch {
        throw "Can't find the JSON configuration file. Use 'Set-ShokoConfig' to create one."
    }
}