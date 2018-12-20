$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\$sut"

$AccessTokenScript = Get-ChildItem -Path "$here\..\" -Recurse | Where-Object Name -eq "Get-SpotifyAccessToken.ps1"
. $AccessTokenScript.FullName

# Variables
$Method = "Get"
$Uri = "https://google.com"
$Body = @{
  Blah = "blah"
}
$Result = @{
  StatusCode        = "200";
  StatusDescription = "OK"
}

Describe "Send-SpotifyCall" {

  Context "Current.json exists" {
    It "retrieves current.json dev from credential store when it exists" {
      Mock Get-Content {
        "dev"
      }
    }

    Mock Get-SpotifyAccessToken -ParameterFilter {$Name = "dev"}

    It "retrieves spotify access token with the credential name" {
      Mock Get-SpotifyAccessToken {
        @{
          access_token = 'substitute_token';
          expires      = '12/19/2018 19:17:55'
          scope        = '';
          token_type   = 'Bearer'
        }
      }
    }

    It "gets a response from Spotify with the data we requested" {
      Mock Invoke-WebRequest {
        '{
          StatusCode        = "200";
          StatusDescription = "OK";
        }'
      }
    }

    It "converts our response from JSON to an object" {
      Mock ConvertFrom-Json {
        $Result
      }
    }

    It "sends out our api call response as a powershell object without a body" {
      Send-SpotifyCall -Method $Method -Uri $Uri | Should -Be $Result
    }

    It "sends out our api call response as a powershell object with a body" {
      Send-SpotifyCall -Method $Method -Uri $Uri -Body $Body | Should -Be $Result
    }

    Assert-MockCalled Get-SpotifyAccessToken -Times 2 -Exactly -ParameterFilter {
      $Name -eq "dev"
    }
    Assert-MockCalled Get-Content -Times 2 -Exactly
    Assert-MockCalled Invoke-WebRequest -Times 2 -Exactly
    Assert-MockCalled ConvertFrom-Json -Times 2 -Exactly
  }

  Context "Current.json doesn't exist" {
    It "Fails to retrieve current.json" {
      Mock Get-Content {
        $null
      }
    }

    Mock Write-Warning {}

    It "throws an error" {
      Send-SpotifyCall -Method $Method -Uri $Uri | Should -Throw
    }

    Assert-MockCalled Get-Content -Times 1 -Exactly
    Assert-MockCalled Write-Warning -Times 1 -Exactly
  }
}