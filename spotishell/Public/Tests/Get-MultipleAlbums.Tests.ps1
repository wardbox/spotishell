$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\$sut"

$TestAlbumArray = @(
  "albumid1",
  "albumid2",
  "albumid3"
)

$TestResponse = @{
  albums = "yay"
}

Describe "Get-MultipleAlbums" {
  Context "We have multiple albums" {
    Mock Send-SpotifyCall {
      $TestResponse
    }
    It "returns the response" {
      Get-MultipleAlbums -AlbumArray $TestAlbumArray | Should -Be $TestResponse.albums
    }
  }
}