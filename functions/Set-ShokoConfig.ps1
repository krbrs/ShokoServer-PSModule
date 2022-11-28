function Set-ShokoConfig {
    <#
        .SYNOPSIS
        Sets and writes the server parameters for Shoko Server to a config file.

        .DESCRIPTION
        Set the server parameters for Shoko Server, convert parameter values to a PSCustomObject and write to a JSON configuration file.

        .PARAMETER URI
        The Shoko Server URI in format http(s)://127.0.0.1:8111.

        .PARAMETER ApiKey
        The Shoko Server API Key. This Key will be used for Communication with ShokoServer.
        Can be obtained manually or via "New-ShokoApiKey".

        .EXAMPLE
        Set-ShokoConfig -ShokoURI "http://127.0.0.1:8111" -ShokoApiKey "89898989-dead-beef-bbff-3ddbbaffffba"
        Writes both the ShokoURI "http://127.0.0.1:8111" and ShokoApiKey "89898989-dead-beef-bbff-3ddbbaffffba" to the config file.

        .EXAMPLE
        Set-ShokoConfig -ShokoURI "http://127.0.0.1:8111"
        Writes the ShokoURI "http://127.0.0.1:8111" to the config file.

        .EXAMPLE
        Set-ShokoConfig -ApiKey "89898989-dead-beef-bbff-3ddbbaffffba"
        Writes the ShokoApiKey "89898989-dead-beef-bbff-3ddbbaffffba" to the config file.
        Requires a previously-saved ShokoURI.
    #>

    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        $URI,
        [ValidateNotNullOrEmpty()]
        [String]
        $ApiKey
    )

    try {
        Write-Verbose -Message 'Trying Get-ShokoConfig before Set-ShokoConfig.'
        $config = Get-Content -Path "$shokoConfigDir\config.json" -ErrorAction 'Stop' |
            ConvertFrom-Json
        Write-Verbose -Message 'Stored config.json found.'
    } catch {
        Write-Verbose -Message 'No configuration found - starting with empty configuration.'
        $jsonString = @'
{   
    "URI" : {
        "ShokoURI" : ""
    },
    "ApiKey" : {
        "ShokoApiKey" : ""
    }
}
'@
        $config = $jsonString |
            ConvertFrom-Json
    }

    # Detailed parameter validation against current configuration
    if ($ApiKey -and (!($URI)) -and (!($config.URI.ShokoURI))) {
        throw 'Cannot set ShokoApiKey with an empty ShokoURI setting.'
    }

    if ($URI) {$config.URI.ShokoURI = $URI}
    if ($ApiKey) {$config.ApiKey.ShokoApiKey = $ApiKey}

    Write-Verbose -Message 'Setting config.json.'
    $config |
        ConvertTo-Json |
            Set-Content -Path "$shokoConfigDir\config.json"
}