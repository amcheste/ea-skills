-- Read all incomplete reminders from Apple Reminders
-- Output: JSON-like format for easy parsing
-- Usage: osascript reminders_read.scpt [list_name]
-- If no list_name provided, reads all lists

on run argv
    set targetList to ""
    if (count of argv) > 0 then
        set targetList to item 1 of argv
    end if

    tell application "Reminders"
        set output to ""

        if targetList is "" then
            set allLists to lists
        else
            set allLists to {list targetList}
        end if

        repeat with reminderList in allLists
            set listName to name of reminderList
            set incompleteReminders to (reminders of reminderList whose completed is false)

            repeat with r in incompleteReminders
                set reminderName to name of r
                set reminderDue to ""
                set reminderPriority to priority of r as integer
                set reminderNotes to ""

                try
                    set reminderDue to due date of r as string
                end try
                try
                    set reminderNotes to body of r
                end try

                -- Priority: 0 = none, 1 = high, 5 = medium, 9 = low
                set priorityLabel to "none"
                if reminderPriority is 1 then
                    set priorityLabel to "high"
                else if reminderPriority is 5 then
                    set priorityLabel to "medium"
                else if reminderPriority is 9 then
                    set priorityLabel to "low"
                end if

                set output to output & "LIST:" & listName & "|TASK:" & reminderName & "|DUE:" & reminderDue & "|PRIORITY:" & priorityLabel & "|NOTES:" & reminderNotes & linefeed
            end repeat
        end repeat

        return output
    end tell
end run
