function New-ShokoApiKey {
    <#
        .SYNOPSIS
        Request an API Key from ShokoServer for usage with the PSModule.

        .DESCRIPTION
        Request an API Key from ShokoServer for usage with the PSModule.
        You will be prompted to enter the credentials for your Shoko Instance.

        .EXAMPLE
        New-ShokoApiKey
    #>

    param (
        [pscredential] $ShokoCredentials = (Get-Credential -Message "Please enter your Shoko credentials:")
    )
    Assert-ShokoConfigImported
    $ShokoUser = $ShokoCredentials.GetNetworkCredential().UserName
    $ShokoPass = $ShokoCredentials.GetNetworkCredential().Password
    $response = (Invoke-RestMethod -Method Post -Uri $global:ShokoURI/api/auth -Body (@{ user = "$ShokoUser"; pass ="$ShokoPass"; device = "ShokoServer-PSModule"} | ConvertTo-Json) -ContentType "application/json")
    $global:ShokoApiKey=$response.apikey
    Set-ShokoConfig -ApiKey $global:ShokoApiKey
    Write-Host "New API Key generated. Config updated:"
    Get-ShokoConfig
}