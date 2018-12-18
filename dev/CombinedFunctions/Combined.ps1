function Get-SpotifyAccessToken {
    [CmdletBinding()]
    param (
        <# This is the name of the credential you want to use #>
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )

    $SpotishellStore = $env:LOCALAPPDATA + "\wardbox\spotishell\"
    $AccessTokenStorePath = $SpotishellStore + "access_token\"
    $AccessTokenFilePath = $AccessTokenStorePath + $Name + ".json"
    $CredentialStorePath = $SpotishellStore + "credential\"
    #$CredentialFilePath = $CredentialStorePath + $Name + ".json"

    <# Check if we have a valid access token already #>
    if (!(Test-Path -Path $AccessTokenStorePath)) {
        <# There is no access token store, let's try to make one. #>
        try {
            Write-Verbose "Attempting to create access token store at $AccessTokenStorePath"
            New-Item -Path $AccessTokenStorePath -ItemType Directory -ErrorAction Stop
            Write-Verbose "Successfully created access token store at $AccessTokenStorePath"
        } catch {
            Write-Warning "Failed attempting to create access token store at $AccessTokenStorePath"
            Write-Warning "Check error for more details."
            break
        }
    }

    Write-Verbose "Access token store exists at $AccessTokenStorePath"

    try {
        Write-Verbose "Attempting to read access token from $AccessTokenFilePath"
        $ExistingAccessToken = Get-Content -Path $AccessTokenFilePath -ErrorAction SilentlyContinue | ConvertFrom-Json -ErrorAction Stop
    } catch {
        Write-Warning "Couldn't convert existing access token from JSON"
        break
    }

    if ($ExistingAccessToken) {
        $Expires = $ExistingAccessToken.expires | Get-Date
        $CurrentTime = Get-Date
        if ($CurrentTime -le $Expires.AddSeconds(-10)) {
            return $ExistingAccessToken
        }
    }

    try {
        $SpotifyCredentials = Get-SpotifyCredential -Name $Name -ErrorAction Stop
    } catch {
        Write-Warning "Couldn't find spotify credentials with name $Name"
        break
    }

    if ($SpotifyCredentials.ClientId -and $SpotifyCredentials.ClientSecret) {
        <# The request is sent to the /api/token endpoint of the Accounts service:
    POST https://accounts.spotify.com/api/token #>
        $Uri = "https://accounts.spotify.com/api/token"
        $Method = "Post"

        <# The body of this POST request must contain the following parameters encoded
    in application/x-www-form-urlencoded as defined in the OAuth 2.0 specification #>
        $Body = @{
            "grant_type" = "client_credentials"
        }

    } else {
        $SpotifyCredentials = New-SpotifyCredential -Name $Name -ClientId (Read-Host -Prompt "ClientId") -ClientSecret (Read-Host "ClientSecret")
    }

    <# Base 64 encoded string that contains the client ID and client secret key. #>
    $CombinedCredentials = [System.Text.Encoding]::UTF8.GetBytes($SpotifyCredentials.ClientId + ":" + $SpotifyCredentials.ClientSecret)
    $Base64Credentials = [System.Convert]::ToBase64String($CombinedCredentials)
    $Auth = @{
        "Authorization" = "Basic " + $Base64Credentials
    }

    <# Call api for auth token #>
    try {
        Write-Verbose "Attempting to send request to API to get access token."
        $Response = Invoke-WebRequest -Uri $Uri -Method $Method -Body $Body -Headers $Auth
        $CurrentTime = Get-Date
    } catch {
        Write-Warning "Failed sending request to API to get access token."
        break
    }

    if ($Response) {
        Write-Verbose "We got a response!"
        if ($Response.StatusCode -eq "200") {
            $Response = $Response.Content | ConvertFrom-Json
            try {
                $Expires = $CurrentTime.AddSeconds($Response."expires_in")
                $AccessTokenJSON = @{
                    access_token = $Response."access_token";
                    token_type   = $Response."token_type";
                    expires      = "$Expires";
                    scope        = $Response."scope";
                }
                $AccessTokenJSON | ConvertTo-Json -Depth 100 | Out-File -FilePath $AccessTokenFilePath
                Write-Verbose "Successfully saved access token to $AccessTokenFilePath"
                $AccessTokenObject = Get-Content $AccessTokenFilePath | ConvertFrom-Json -ErrorAction Stop
                return $AccessTokenObject
            } catch {
                Write-Warning "Failed saving access token to $AccessTokenFilePath"
            }
        } else {
            Write-Warning "We got a bad response."
            Write-Warning "$($Response.StatusCode)"
            Write-Warning "$($Response.StatusDescription)"
            break
        }
    } else {
        Write-Warning "No response!"
        break
    }
}

<# This is for testing #>

#Get-SpotifyAccessToken -Name "dev" -Verbose

function Send-SpotifyCall {
    [CmdletBinding()]
    param (

        # This is our method
        [Parameter(Mandatory = $true)]
        [string]
        $Method,

        # URI to api endpoint
        [Parameter(Mandatory = $true)]
        [string]
        $Uri,

        # This is the header constructed by previous function.  Typically contains the access token
        [Parameter(Mandatory = $false)]
        [hashtable]
        $Header,

        # Body for call, typically contains sporadic values. Should always be a hash table still.
        [Parameter(Mandatory = $false)]
        [hashtable]
        $Body
    )

    $SpotishellStore = $env:LOCALAPPDATA + "\wardbox\spotishell\"
    $CredentialStorePath = $SpotishellStore + "credential\"
    $CredentialName = Get-Content -Path ($CredentialStorePath + "current.txt")

    if ($CredentialName) {

        $AccessToken = Get-SpotifyAccessToken -Name $CredentialName

        if (!($Header)) {
            $Header = @{
                "Authorization" = "Bearer " + $AccessToken.access_token
            }
        }

        <# Call api for auth token #>
        try {
            Write-Verbose "Attempting to send request to API"
            if ($Body) {
                $Response = Invoke-WebRequest -Method $Method -Headers $Header -Body $Body -Uri $Uri
            } else {
                $Response = Invoke-WebRequest -Method $Method -Headers $Header -Uri $Uri
            }
        } catch {
            Write-Warning "Failed sending request to API"
            break
        }

        if ($Response) {
            Write-Verbose "We got a response!"
            $Response = $Response.Content | ConvertFrom-Json
            return $Response
        } else {
            Write-Warning "No response!"
            break
        }
    } else {
        Write-Warning "No current credential found. Either do New-SpotifyCredential or Set-SpotifyCredential first."
        break
    }
}

function  Get-SpotifyCredential {
    param (
        <# Credential name so user can identify it #>
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )

    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

    if (!(Test-Path -Path $CredentialStorePath)) {
        Write-Warning "No path at $CredentialStorePath, you need to make a credential first"
    }

    Write-Verbose "Credential store exists at $CredentialStorePath"

    <# Construct filepath #>
    $CredentialFilePath = $CredentialStorePath + $Name + ".json"

    $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

    if ($ExistingCredential) {
        $Credential = Get-Content $ExistingCredential | ConvertFrom-Json -ErrorAction Stop
        return $Credential
    } else {
        Write-Warning "No credential found with name $Name"
        return "No credential found with name $Name"
    }
}

function  New-SpotifyCredential {
    param (
        <# Credential name so user can identify it #>
        # Parameter help description
        [Parameter(Mandatory = $true)]
        [String]
        $Name,

        <# Client ID, obtained from one of your applications on the Spotify developer dashboard:
        https://developer.spotify.com/dashboard/applications (as of this writing) #>
        [Parameter(Mandatory = $true)]
        [String]
        $ClientId,

        <# Client Secret, obtained from one of your applications on the Spotify developer dashboard:
        https://developer.spotify.com/dashboard/applications (as of this writing) #>
        [Parameter(Mandatory = $true)]
        [String]
        $ClientSecret
    )

    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

    <# We don't want to destroy any existing credential files, proceeding with caution. #>
    $Overwrite = "n"

    if (!(Test-Path -Path $CredentialStorePath)) {

        <# 1. There is no credential repo, let's try to make one. #>
        try {
            Write-Verbose "Attempting to create credential store at $CredentialStorePath"
            New-Item -Path $CredentialStorePath -ItemType Directory -ErrorAction Stop
            Write-Verbose "Successfully created credential store at $CredentialStorePath"
        } catch {
            Write-Warning "Failed attempting to create credential store at $CredentialStorePath"
            Write-Warning "Check error for more details."
            break
        }

    }

    Write-Verbose "Credential store exists at $CredentialStorePath"

    <# Construct filepath #>
    $CredentialFilePath = $CredentialStorePath + $Name + ".json"

    $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

    if ($ExistingCredential) {
        $Overwrite = Read-Host -Prompt "Found existing credential with name $Name, do you want to overwrite it? (y/n)"
    } else {
        $OverWrite = "y"
    }

    <# Assemble credential JSON #>
    $CredentialJSON = @{
        ClientId     = $ClientId;
        ClientSecret = $ClientSecret
    }

    <# Converts our hash table to JSON so we can save it locally. #>
    $CredentialJSON = $CredentialJSON | ConvertTo-Json -Depth 100

    if ($Overwrite -like "y*") {
        <# Try to save credential to file. #>
        try {
            Write-Verbose "Attempting to save credentials to $CredentialFilePath"
            $CredentialJSON | Out-File -FilePath $CredentialFilePath
            Write-Verbose "Successfully saved credentials to $CredentialFilePath"
            if (Get-Item -Path ($CredentialStorePath + "current.txt")) {
                $CurrentOverwrite = Read-Host "There's a current.txt with a different credential, want to overwrite it with $Name?(y/n)"
                if ($CurrentOverwrite -like "y*") {
                    Set-SpotifyCredential -Name $Name
                }
            } else {
                Set-SpotifyCredential -Name $Name
            }
            $CredentialObject = Get-Content $CredentialFilePath | ConvertFrom-Json -ErrorAction Stop
            return $CredentialObject
        } catch {
            Write-Warning "Failed saving credentials to $CredentialFilePath"
        }
    } else {
        Write-Verbose "No work to do."
    }
}

function Search-Spotify {
    param (
        # The data we want to look for
        [Parameter(Mandatory = $true)]
        $Query,

        # Artist switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Artist,

        # Album switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Album,

        # Track switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Track,

        # Playlist switch
        [Parameter(Mandatory = $false)]
        [switch]
        $Playlist

    )

    $Query = "q=" + $Query.replace(" ", "+")

    $Filters = @()

    if ($Artist) {
        $Filters += "artist"
    } elseif ($Album) {
        $Filters += "album"
    } elseif ($Track) {
        $Filters += "track"
    } elseif ($Playlist) {
        $Filters += "playlist"
    }

    # If we have anything to filter by, we need to add this to our query first.
    if ($Filters) {
        Write-Verbose "We've got some filters, let's load up our query."
        $Query += "&type="
        $Count = $Filters.Count

        foreach ($Record in $Filters) {
            if ($Count -gt 1) {
                $Query += "$Record,"
            } else {
                $Query += $Record
            }
            Write-Verbose "Current query: $Query"
            # Decrement so we can see if we need to add a comma at the end or not, kinda dumb but easy enough
            $Count--
        }
    }

    $Method = "Get"
    $Uri = "https://api.spotify.com/v1/search" + "?" + $Query

    $Response = Send-SpotifyCall -Method $Method -Uri $Uri
    return $Response

}

function Set-SpotifyCredential {
    param(
        # Name of our credential we've created
        [Parameter(Mandatory = $true)]
        [string]
        $Name
    )

    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

    # If we don't have a credential store, tell user to make one
    if (!(Test-Path -Path $CredentialStorePath)) {
        Write-Warning "Failed attempting to create credential store at $CredentialStorePath"
        Write-Warning "Suggest running New-SpotifyCredential to create a credential first."
        break
    }

    Write-Verbose "Credential store exists at $CredentialStorePath"

    <# Construct filepath #>
    $CredentialFilePath = $CredentialStorePath + $Name + ".json"

    $ExistingCredential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

    if ($ExistingCredential) {
        $CurrentCredential = Get-Content -Path ($CredentialStorePath + "current.txt")
        if ($CurrentCredential -ne $Name) {
            try {
                Write-Verbose "Attempting to save current.txt with $Name credentials"
                "$Name" | New-Item -Path ($CredentialStorePath + "current.txt") -Force
                Write-Verbose "Success"
            } catch {
                Write-Warning "Unable to create current.txt with $Name credentials."
                break
            }
        } else {
            Write-Verbose "$Name is already set as the current credential."
        }
    } else {
        Write-Warning "There's no existing credential with name $Name"
    }
}

function Remove-SpotifyCredential {
    param(
        # Name of our credential we've created
        [Parameter(Mandatory = $true)]
        [string]
        $Name
    )

    $CredentialStorePath = $env:LOCALAPPDATA + "\wardbox\spotishell\credential\"

    # If we don't have a credential store, tell user to make one
    if (!(Test-Path -Path $CredentialStorePath)) {
        Write-Warning "Failed attempting to create credential store at $CredentialStorePath"
        Write-Warning "Suggest running New-SpotifyCredential to create a credential first."
        break
    }

    Write-Verbose "Credential store exists at $CredentialStorePath"

    <# Construct filepath #>
    $CredentialFilePath = $CredentialStorePath + $Name + ".json"

    $Credential = Get-Item -Path $CredentialFilePath -ErrorAction SilentlyContinue

    if ($Credential) {
        $CurrentCredential = Get-Content -Path ($CredentialStorePath + "current.txt")
        if ($CurrentCredential -eq $Name) {
            try {
                Write-Verbose "Current credential is set as $Name, make sure to use Set-SpotifyCredential to create new current credential."
                Remove-Item -Path ($CredentialStorePath + "current.txt") -Force
                Write-Verbose "Deleted file at $($CredentialStorePath + "current.txt")"
            } catch {
                Write-Warning "Unable to delete current.txt with $Name credentials."
                break
            }
        }
        try {
            Write-Verbose "Attempting to delete $Name at $CredentialFilePath"
            Remove-Item -Path $CredentialFilePath
            Write-Verbose "Success"
        } catch {
            Write-Warning "Failed deleting $Name credential"
            break
        }
    } else {
        Write-Warning "There's no existing credential with name $Name"
    }
}