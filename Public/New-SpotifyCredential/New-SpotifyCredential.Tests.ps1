$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New-SpotifyCredential" {
    It "does something useful" {
        $TestData = '{"ClientId": "blah","ClientSecret": "blah"}'
        $FilePath = $env:LOCALAPPDATA + "blah.json"
        Mock Test-Path { $False } -ParameterFilter { $Path -eq $FilePath }
    }
}
