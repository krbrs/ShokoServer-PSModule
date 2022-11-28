function Sync-ShokoPlexWatchedState {
    <#
        .SYNOPSIS
        Trigger synchronisation of watched states between ShokoServer and your Plex Server.

        .DESCRIPTION
        Trigger synchronisation of watched states between ShokoServer and your Plex Server.
        Make sure you have your Plex Server linked and set the correct Plex Libraries on Shoko. 
        This uses the v3 API so make sure you are running the current version of ShokoServer.

        .EXAMPLE
        Sync-ShokoPlexWatchedState
    #>
    $headers = @{
        apikey="$global:ShokoApiKey"
    }
    Assert-ShokoConfigImported
    Invoke-RestMethod -Method GET -Uri $global:ShokoURI/api/v3/Action/PlexSyncAll -Headers $headers -ContentType "application/json"
    Write-Host "Sync triggered. Please check docker or WebUI logs for progress."
}