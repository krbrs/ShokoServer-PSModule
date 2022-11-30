function Revoke-ShokoApiKey {
    <#
        .SYNOPSIS
        Revoke an API Key from ShokoServer if needed.

        .DESCRIPTION
        Revoke an API Key from ShokoServer if needed.
        Confirm that the API Key to be revoked is correctly Set using "Get-ShokoConfig"

        .EXAMPLE
        Revoke-ShokoApiKey
    #>

    Assert-ShokoConfigImported
    
    Invoke-RestMethod -Method Delete -Uri $global:ShokoURI/api/auth?apikey=$global:ShokoApiKey
    $ShokoApiKey = $null
    Set-ShokoConfig -ApiKey "revoked"
    Write-Host "ApiKey revoked! To request a new API Key use `"New-ShokoApiKey`"."
}