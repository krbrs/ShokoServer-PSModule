function Get-ShokoServerSettings {
    <#
        .SYNOPSIS
        Get the current server settings from ShokoServer.

        .DESCRIPTION
        Get the current server settings from ShokoServer.

        .EXAMPLE
        Get-ShokoServerSettings
    #>

    [CmdletBinding()]
    Param()

    $headers = @{
        apikey="$global:ShokoApiKey"
    }
    Assert-ShokoConfigImported
    Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/Settings -Headers $headers -ContentType "application/json"
}