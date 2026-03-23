-- Read events from Apple Calendar for a given date range
-- Output: pipe-delimited format for easy parsing
-- Usage: osascript calendar_read.scpt "YYYY-MM-DD" "YYYY-MM-DD"
-- First arg: start date, Second arg: end date
-- If only one arg provided, reads that single day

on run argv
    set startDateStr to item 1 of argv
    if (count of argv) > 1 then
        set endDateStr to item 2 of argv
    else
        set endDateStr to startDateStr
    end if

    -- Parse start date
    set startDate to date startDateStr
    set time of startDate to 0

    -- Parse end date and set to end of day
    set endDate to date endDateStr
    set time of endDate to 86399

    tell application "Calendar"
        set output to ""
        set allCalendars to calendars

        repeat with cal in allCalendars
            set calName to name of cal
            try
                set dayEvents to (every event of cal whose start date ≥ startDate and start date ≤ endDate)
                repeat with evt in dayEvents
                    set evtTitle to summary of evt
                    set evtStart to start date of evt as string
                    set evtEnd to end date of evt as string
                    set evtLocation to ""
                    set evtNotes to ""
                    set evtAllDay to allday event of evt

                    try
                        set evtLocation to location of evt
                    end try
                    try
                        set evtNotes to description of evt
                    end try

                    set allDayStr to "false"
                    if evtAllDay then
                        set allDayStr to "true"
                    end if

                    set output to output & "CAL:" & calName & "|EVENT:" & evtTitle & "|START:" & evtStart & "|END:" & evtEnd & "|ALLDAY:" & allDayStr & "|LOCATION:" & evtLocation & "|NOTES:" & evtNotes & linefeed
                end repeat
            end try
        end repeat

        return output
    end tell
end run
