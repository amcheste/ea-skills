-- List all calendars available in Apple Calendar
-- Shows calendar name and which account it belongs to
-- Usage: osascript calendar_list.scpt

tell application "Calendar"
    set output to ""
    repeat with cal in calendars
        set calName to name of cal
        set calDesc to ""
        try
            set calDesc to description of cal
        end try
        set output to output & "NAME:" & calName & "|DESCRIPTION:" & calDesc & linefeed
    end repeat
    return output
end tell
