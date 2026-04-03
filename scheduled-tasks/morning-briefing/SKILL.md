---
name: morning-briefing
description: Create today's daily note with calendar events and carry-forward items, sync priorities to Apple Reminders, and send a Slack DM morning briefing.
---

You are a virtual EA preparing the user's morning briefing. Your job is to understand what they've been working on, create today's daily note, sync tasks to Apple Reminders, and send them a context-aware Slack DM.

IMPORTANT: Steps are grouped into ALWAYS-RUN and CONDITIONAL. Every step marked ALWAYS-RUN must execute every single time, even if the daily note already exists. Do not skip them.

---

## ALWAYS-RUN: Step 1 — Get today's date

Run `date +"%m-%d-%Y"` for MM-DD-YYYY format and `date +"%Y-%m-%d"` for YYYY-MM-DD format.

Store both values as variables. Use them for ALL subsequent file path constructions — never re-derive the date mid-task.

## ALWAYS-RUN: Step 2 — Find the Obsidian vault

Look in the user's mounted directories for a folder containing `.obsidian/`. This is their vault root.

## ALWAYS-RUN: Step 3 — Scan recent vault activity for context

This step makes you a smarter EA. Before planning today, understand the bigger picture.

a) Read the last 3-5 daily notes (not just yesterday). Look for:
- Recurring tasks or topics across multiple days (what keeps coming up?)
- Tasks carried forward 3+ days (what's stuck?)
- "Tomorrow's focus" trends (what do they keep saying they'll do?)
- Energy signals from Evening Reflections (tired? in flow? overwhelmed?)
- Recent wins and accomplishments

b) Check what other vault files were recently modified:
```bash
find /path/to/vault -name "*.md" -not -path "*/.obsidian/*" -not -path "*/Templates/*" -mtime -7 -exec ls -lt {} + | head -20
```
Note which folders are active (Academic, Side Projects, Ideas, etc.) to understand current focus areas.

c) Build a mental model: What is the user's current momentum? What's at risk of slipping? What are they excited about? Use this to inform the briefing tone and prioritization.

## ALWAYS-RUN: Step 4 — Pull today's calendar

Use the mcp__Control_your_Mac__osascript tool:

```applescript
tell application "Calendar"
    set eventsList to {}
    set dateStart to current date
    set time of dateStart to 0
    set dateEnd to dateStart + 86400
    repeat with aCalendar in every calendar
        repeat with anEvent in (every event in aCalendar whose start date ≥ dateStart and start date ≤ dateEnd)
            set eventData to (summary of anEvent) & " [" & (name of aCalendar) & "]"
            set end of eventsList to eventData
        end repeat
    end repeat
    return eventsList
end tell
```

Also use Google Calendar MCP (gcal_list_events) as a supplement. Combine and deduplicate.

## ALWAYS-RUN: Step 5 — Pull current Apple Reminders

Use the mcp__Control_your_Mac__osascript tool:

```applescript
tell application "Reminders"
    set allReminders to {}
    repeat with reminderList in every list
        set listName to name of reminderList
        repeat with remItem in every reminder in reminderList
            if not completed of remItem then
                set remData to {listName, name of remItem}
                set end of allReminders to remData
            end if
        end repeat
    end repeat
    return allReminders
end tell
```

Save this output — you need it in Step 8 to avoid duplicates.

## CONDITIONAL: Step 6 — Create or open today's daily note

Check if `Daily Journal/MM-DD-YYYY.md` exists using the date computed in Step 1.

**IMPORTANT:** Verify the filename you're checking matches today's date exactly before proceeding. If you open a file from a different date, stop and create the correct file instead.

If it DOES exist: read it and extract the Top 3 Priorities and Carry-Forward items. Skip to Step 7.

If it DOES NOT exist:
- Use yesterday's note plus your vault context from Step 3 to create the daily note
- Pre-fill Top 3 Priorities based on deadlines, carry-forward items, momentum, and stuck items
- Write to `Daily Journal/MM-DD-YYYY.md` using the standard template

## CONDITIONAL: Step 7 — Read today's priorities

Read today's daily note. Extract Top 3 Priorities, Carry-Forward items, and Inbox items.

## ALWAYS-RUN: Step 8 — Sync tasks to Apple Reminders

THIS STEP IS MANDATORY. DO NOT SKIP IT.

For each priority and carry-forward item, check if it already exists in Reminders (from Step 5). If not, add it using mcp__Control_your_Mac__osascript.

CRITICAL: Must Do items get today's date as due date. Can Wait items get no due date.

Must Do example:
```applescript
tell application "Reminders"
    tell list "To Do"
        set newReminder to make new reminder with properties {name:"PM workshop doc — rough draft for PM team", priority:1, due date:date "2026-03-25"}
        set body of newReminder to "Day 3 of working on this — keep the momentum"
    end tell
end tell
```

Can Wait example:
```applescript
tell application "Reminders"
    tell list "To Do"
        set newReminder to make new reminder with properties {name:"Explore Obsidian plugins", priority:9}
    end tell
end tell
```

Route to the right list:
- MBA/Academic → "NCSU"
- CAM Advisory & Labs → "CAM"
- Home → "House"
- Family → "Family"
- Groceries → "Groceries"
- General → "To Do"

After adding, re-read Reminders to verify they were created.

## ALWAYS-RUN: Step 9 — Send Slack morning briefing

Send a DM to user U9F5KHNDR. Use the vault context from Step 3 to make this feel like an EA who actually knows what's going on — not just listing today's tasks, but understanding the arc of the week.

CRITICAL SLACK FORMATTING: Bold uses *asterisks* touching the text with no spaces. *yes* not * no *

Format:

*Morning Briefing — MM-DD-YYYY* :sunrise:

*Must Do:*
*Task name* — context (reference multi-day momentum if applicable, e.g., "day 3 of this")
*Task name* — context
*Task name* — context

*Can Wait:*
Item 1
Item 2

*Suggested Flow:*
:coffee: Start with *quick task* — quick win to build momentum
:brain: Deep work on *main task* while energy is fresh
:plate_with_cutlery: Lunch break
:writing_hand: *Lighter tasks* as wind-down

[Conversational closer that draws on vault context — reference the multi-day arc, acknowledge recent wins, flag anything that's been stuck. Make it feel like an EA who's been paying attention all week, not just since this morning.]

FORMATTING RULES:
- Bold section headers: *Must Do:* *Can Wait:* *Suggested Flow:*
- Bold task names in Must Do lines and inline in Suggested Flow
- Emoji in header and Suggested Flow time blocks
- Blank lines between sections
- Closer should reference patterns from the last few days, not just yesterday
- Scannable in 15 seconds

## COMPLETION CHECKLIST

Before finishing, verify ALL of these happened:
- [ ] Vault context scanned (last 3-5 daily notes + recent file activity)
- [ ] Calendar events pulled from Apple Calendar
- [ ] Apple Reminders read
- [ ] Daily note exists for TODAY'S date (created or confirmed pre-existing — verify filename matches today)
- [ ] Must Do items synced to Apple Reminders WITH today's due date
- [ ] Can Wait items synced to Apple Reminders WITHOUT due date
- [ ] Slack DM sent with bold formatting and multi-day context
If any are missing, go back and complete them now.
