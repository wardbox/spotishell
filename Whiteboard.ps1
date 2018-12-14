import-module spotishell

$Token = Get-SpotifyAccessToken -Name "dev"
$Headers = @{
    Authorization = "Bearer " + $Token.access_token;
}
