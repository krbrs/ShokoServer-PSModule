function Get-ShokoFileInfo {
    <#
        .SYNOPSIS
        Get Info on a File with FileID or by searching for a File by Path from ShokoServer.

        .DESCRIPTION
        Get Info on a File with FileID or by searching for a File by Path from ShokoServer.
        This can be queried with or without XRefs or additional Data from e.g. AniDB (see examples).

        .EXAMPLE
        Get-ShokoFileInfo -ByID -FileID 1
        
        .EXAMPLE
        Get-ShokoFileInfo -ByID -FileID 1 -IncludeXRefs
        
        .EXAMPLE
        Get-ShokoFileInfo -ByID -FileID 1 -IncludeXRefs -IncludeDataFromAniDB

        .EXAMPLE
        Get-ShokoFileInfo -ByPath -PathEndsWith "Tonari no Totoro/Tonari no Totoro.mkv"

        .EXAMPLE
        Get-ShokoFileInfo -ByPath -PathEndsWith "Tonari no Totoro/Tonari no Totoro.mkv" -IncludeXRefs

        .EXAMPLE
        Get-ShokoFileInfo -ByPath -PathEndsWith "Tonari no Totoro/Tonari no Totoro.mkv" -IncludeXRefs -IncludeDataFromAniDB
    #>

    [CmdletBinding()]
    Param(
        [Parameter (Mandatory, ParameterSetName="ByID")]
        [switch]
        $ByID,
        [ValidateNotNullOrEmpty()]
        [Parameter (Mandatory, ParameterSetName="ByID")]
        [int]
        $FileID,
        [Parameter (Mandatory, ParameterSetName="ByPath")]
        [switch]
        $ByPath,
        [ValidateNotNullOrEmpty()]
        [Parameter (Mandatory, ParameterSetName="ByPath")]
        [string]
        $PathEndsWith,
        [switch]
        $includeXRefs,
        [switch]
        $includeDataFromAniDB
    )

    Assert-ShokoConfigImported

    $headers = @{
        apikey="$global:ShokoApiKey"
    }

    if ($ByID) {
        Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/File/$FileID`?includeXRefs`=$includeXRefs`&$includeDataFromAniDB`=$includeDataFromAniDB -Headers $headers -ContentType "application/json"
    }

    elseif ($ByPath) {
        $PathEndsWith = [uri]::EscapeUriString($pathEndsWith)
        Write-Verbose $PathEndsWith
        Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/File/PathEndsWith/$PathEndsWith -Headers $headers -ContentType "application/json"
    }
}