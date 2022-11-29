function Get-ShokoServerVersion {
    <#
        .SYNOPSIS
        Get the server version from ShokoServer.

        .DESCRIPTION
        Get the server version from ShokoServer.

        .EXAMPLE
        Get-ShokoServerVersion
    #>

    [CmdletBinding()]
    Param()

    Assert-ShokoConfigImported
    Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/Init/Version -ContentType "application/json"
}