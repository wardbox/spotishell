#Get public and private function definition files.
$Public = @( Get-ChildItem -Path Spotishell\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path Spotishell\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($import in @($Public + $Private)) {
  Try {
    . $import.fullname
  } Catch {
    Write-Error -Message "Failed to import function $($import.fullname): $_"
  }
}

# create spotify credential
# set spotify credential
# delete spotify credential
#find an artist
$Artist = "Adam Tell"
$ArtistObject = Search-Spotify -Query $Artist
Write-Output $ArtistObject