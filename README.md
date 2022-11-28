# ShokoServer-PSModule
A PowerShell Module for ShokoServer-Management

# Disclaimer
**This is still in an alpha state! By downloading you agree, that by using the module in the current state you might suffer data loss!!**

# Intial Configuration

## Importing the module

*_The Module is not yet signed and your system might need another execution policy set. Please only change it if you know what you are doing! (If this is needed the following Import will throw an error message)_*

Download the Module by cloning the GitHub repository to a local folder.
Open PowerShell and change to the directory with the module.

now import the module using: 
```PS 
Import-Module ./Shoko-PSModule.psm1
```

If you want to troubleshoot the import or just want more info, just append ```-Verbose``` at the end of the command.

## Setting the Server URI and API Key

_This needs to be performed prior first use. If you don't have an API Key yet, please continue on to find out how to obtain it._

You need to set the ShokoServer URI first in the following format:

```PS
Set-ShokoConfig -URI "http://your-IP-or-DNS-name:port"
```

(This is the same address you are using to connect to the webui)

If you already have an API Key, you can set it with:

```PS
Set-ShokoConfig -APIKey "your-api-key-without-braces"
```

You can also combine both commands:

```PS
Set-ShokoConfig -URI "http://your-IP-or-DNS-name:port" -APIKey "your-api-key-without-braces"
```

If you don't have an API Key already, after setting the URI above, use the following command to obtain one and store it in the configuration:

```PS
New-ShokoServerApiKey
```
You will be prompted for the Credentials to your Shoko instance.

You can also revoke the _currently loaded_ ApiKey using
```PS
Revoke-ShokoApiKey
```

## Currently supported commands

List all currently available functions use:
```PS
Get-Command -Module ShokoServer
```

## Additional Info

The config should automatically load but can also be loaded with:
```PS
Import-ShokoConfig
```
This step is not necessary during initial configuration, as the variables are populated with your input.

You can always confirm the values stored in a ```config.json``` which resides in the modules base folder with:

```PS
Get-ShokoConfig
```
