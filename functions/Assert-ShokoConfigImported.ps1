function Assert-ShokoConfigImported {
    <#
        .SYNOPSIS
        Checks if the configuration file was imported before executing a command.

        .DESCRIPTION
        Checks if the configuration file was imported before executing a command.

        .EXAMPLE
        Assert-ShokoConfigImported
    #>

    [CmdletBinding()]
    Param()

    Write-Verbose "Checking wether config needs to be imported."

    if ((Test-Path Variable:Global:ShokoURI)) {
        if ((Test-Path Variable:Global:ShokoApiKey))
            {
                Write-Verbose "Config already imported. Continuing."
        }
    }
    else {
        Import-ShokoConfig
    }
}