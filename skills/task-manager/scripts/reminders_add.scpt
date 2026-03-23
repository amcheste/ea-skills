-- Add a new reminder to Apple Reminders
-- Usage: osascript reminders_add.scpt "list_name" "task_name" "due_date_or_empty" "priority_or_empty" "notes_or_empty"
-- Priority: "high", "medium", "low", or "" for none
-- Due date: "YYYY-MM-DD" format or "" for no due date

on run argv
    set listName to item 1 of argv
    set taskName to item 2 of argv
    set dueStr to item 3 of argv
    set priorityStr to item 4 of argv
    set notesStr to item 5 of argv

    -- Convert priority string to Reminders priority value
    set priorityVal to 0
    if priorityStr is "high" then
        set priorityVal to 1
    else if priorityStr is "medium" then
        set priorityVal to 5
    else if priorityStr is "low" then
        set priorityVal to 9
    end if

    tell application "Reminders"
        -- Create or find the target list
        try
            set targetList to list listName
        on error
            set targetList to make new list with properties {name:listName}
        end try

        -- Build reminder properties
        set reminderProps to {name:taskName, priority:priorityVal}

        if notesStr is not "" then
            set reminderProps to reminderProps & {body:notesStr}
        end if

        -- Create the reminder
        set newReminder to make new reminder at end of targetList with properties reminderProps

        -- Set due date if provided
        if dueStr is not "" then
            set dueDate to date dueStr
            set due date of newReminder to dueDate
        end if

        return "OK: Added '" & taskName & "' to " & listName
    end tell
end run
