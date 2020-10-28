$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\$sut"

$GetSpotifyCredentialScript = Get-ChildItem -Path "$here\..\..\" -Exclude "*Tests.ps1" -Recurse | Where-Object Name -eq "Get-SpotifyCredential.ps1"
. $GetSpotifyCredentialScript.FullName


$Name = "dev"
$AccessT =
@{
  StatusCode        = "200";
  StatusDescription = "OK";
  Content           = '{
    "access_token" : "blahblahtoken"
    "token_type"   : "Bearer"
    "expires_in"   : 3600
    "scope"        : ""
  }'
}

$AccessTokenImport =
'{
  access_token : "blahblahtoken",
  token_type   : "Bearer",
  expires      : "12/20/2018 16:42:03",
  scope        : ""
}'

$AccessTokenObject = $AccessTokenImport | ConvertFrom-Json

Describe "Get-SpotifyAccessToken" {
  Context "Access token doesn't exist yet" {
    It "finds that the access token store path doesn't exists" {
      Mock Test-Path {
        $false
      }
    }

    It "creates a new access token store" {
      Mock New-Item {

      }
    }

    It "can't find an existing access token" {
      Mock Get-Content {

      }
    }

    It "tries to get the spotify credentials to make a new one" {
      Mock Get-SpotifyCredential {
        @{
          ClientSecret = "blahblahsecret";
          ClientId     = "blahblahId"
        }
      }
    }

    It "gets an access token with existing credentials" {
      Mock Invoke-WebRequest {
        $AccessT
      }
    }

    It "gets the current time" {
      "Thursday, December 20, 2018 3:42:03 PM"
    }

    It "writes the file out to the access token file path" {
      Mock Out-File {
        $true
      }
    }

    It "returns JSON" {
      Mock ConvertFrom-Json {
        $AccessTokenObject
      }
    }

  }

  Context "Access token exists" {

  }
}