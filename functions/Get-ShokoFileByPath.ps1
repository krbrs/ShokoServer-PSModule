function Get-ShokoFileByPath {
    <#
        .SYNOPSIS
        Search for a File by path or name on ShokoServer.

        .DESCRIPTION
        Search for a File by path or name on ShokoServer.

        .EXAMPLE
        Get-ShokoFileByPath -PathEndsWith "Tonari no Totoro/Tonari no Totoro.mkv"
    #>

    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [string]
        $PathEndsWith
    )

    $PathEndsWith = [Web.HttpUtility]::UrlPathEncode($pathEndsWith)

    $headers = @{
        apikey="$global:ShokoApiKey"
    }
    Assert-ShokoConfigImported
    $result = (Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/File/PathEndsWith/$PathEndsWith -Headers $headers -ContentType "application/json")
    $result
}