function Get-ShokoFileInfo {
    <#
        .SYNOPSIS
        Get Info on a File with FileID from ShokoServer.

        .DESCRIPTION
        Get Info on a File with FileID from ShokoServer.
        This can be queried with or without XRefs or additional Data from e.g. AniDB (see examples).

        .EXAMPLE
        Get-ShokoFileInfo -FileID 1
        
        .EXAMPLE
        Get-ShokoFileInfo -FileID 1 -IncludeXRefs
        
        .EXAMPLE
        Get-ShokoFileInro -FileID 1 -IncludeXRefs -IncludeDataFromAniDB
    #>

    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [int]
        $FileID,
        [switch]
        $includeXRefs,
        [switch]
        $includeDataFromAniDB
    )

    $headers = @{
        apikey="$global:ShokoApiKey"
    }
    Assert-ShokoConfigImported
    $result = (Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/File/$FileID`?includeXRefs`=$includeXRefs`&$includeDataFromAniDB`=$includeDataFromAniDB -Headers $headers -ContentType "application/json")
    $result
}