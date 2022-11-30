function Reset-ShokoAdminPass {
    <#
        .SYNOPSIS
        Reset the Password for the initial admin account with ID "1" to a blank password.

        .DESCRIPTION
        Reset the Password for the initial admin account with ID "1" to a blank password.
        
        Be aware that this will revoke -all- issued ApiKeys used by -any- other application e.g. Shokofin, Plexmetadata.

        To confirm this you need to add the "IamAwareThisIsPotentiallyDestructiveAndWantToContinue" switch.
        
        After the reset a new ApiKey will be requested for you - you will need to enter your credentials like in the initial setup.
        
        If you want to set a password for another User, use "Set-ShokoUserPass" (to be implemented)

        .EXAMPLE
        Reset-ShokoAdminPass -IamAwareThisIsPotentiallyDestructiveAndWantToContinue
    #>
    param(
        [switch]$IamAwareThisIsPotentiallyDestructiveAndWantToContinue
    )

    Assert-ShokoConfigImported

    if ($IamAwareThisIsPotentiallyDestructiveAndWantToContinue) {
        Invoke-RestMethod -Method Post -Uri $global:ShokoURI/v1/User/ChangePassword/1 -Body (@{ newPassword = ""} | ConvertTo-Json) -ContentType "application/json"
        $global:ShokoApiKey=$null
        Set-ShokoConfig -ApiKey "revoked"
        Write-Host "API Key revoked, super admin password reset to empty password. Calling Function to request new ApiKey now."
        New-ShokoApiKey
    }
    else {
        Write-Error "Please read the info from `"Get-Help Reset-ShokoAdminPass`" before you continue."
        Write-Error "You need to confirm this acction by adding the `"IamAwareThisIsPotentiallyDestructiveAndWantToContinue`" switch"
    }
}