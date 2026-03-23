-- Mark a reminder as complete in Apple Reminders
-- Usage: osascript reminders_complete.scpt "list_name" "task_name"

on run argv
    set listName to item 1 of argv
    set taskName to item 2 of argv

    tell application "Reminders"
        set targetList to list listName
        set matchingReminders to (reminders of targetList whose name is taskName and completed is false)

        if (count of matchingReminders) > 0 then
            set completed of item 1 of matchingReminders to true
            return "OK: Completed '" & taskName & "' in " & listName
        else
            return "NOT_FOUND: No incomplete reminder '" & taskName & "' in " & listName
        end if
    end tell
end run
