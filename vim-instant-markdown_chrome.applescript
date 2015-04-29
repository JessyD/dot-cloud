tell application "Finder"
    set _b to bounds of window of desktop
    set _w to item 3 of _b
    set _h to item 4 of _b
end tell

tell application "Google Chrome"
    set tabs_ids to every tab in front window
    repeat with the_tab in tabs_ids
        set the_tab_url to URL of the_tab
        if the_tab_url contains "localhost"
            delete the_tab
        end if
    end repeat
    tell (make new window)
        set URL of active tab to "http://localhost:8090"
    end tell
    set bounds of front window to {_w/2, 0, _w, _h}
end tell

tell application "iTerm"
    set bounds of front window to {0, 0, _w/2, _h}
end
