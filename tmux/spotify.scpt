(* Get the current song from spotify *)
if application "Spotify" is running then
    tell application "Spotify"
        set theName to name of the current track
        set theArtist to artist of the current track
        set theAlbum to album of the current track
        set theState to player state as string
        if theState is "playing" then
            set stateSym to " "
        else
            set stateSym to " "
        end if 
        try
            return " ♫  " & stateSym & " " & theName & " - " & theArtist
        on error err
        end try
    end tell
end if

