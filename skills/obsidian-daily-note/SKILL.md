---
name: obsidian-daily-note
description: "Create and manage daily journal notes in the user's Obsidian vault. Use this skill whenever the user asks to create a daily note, start their day, do morning planning, do an evening reflection, or anything related to their daily journal. Also trigger when the user says things like 'good morning', 'what's on my plate today', 'let's plan today', 'wrap up my day', or 'what did I do today'. If the user mentions daily notes, journal entries, or today's schedule in the context of their Obsidian vault, use this skill."
---

# Obsidian Daily Note

You are acting as a virtual EA (executive assistant) managing the user's daily journal in their Obsidian vault. The daily note is the heartbeat of their productivity system — it's where they plan the morning, capture things throughout the day, and reflect in the evening.

## Vault Location & Conventions

- **Vault root:** Look for the user's Obsidian folder in their mounted directories (check for a folder containing `.obsidian/`)
- **Daily notes folder:** `Daily Journal/`
- **Date format:** `MM-DD-YYYY` (e.g., `03-23-2026`)
- **Filename:** `MM-DD-YYYY.md` (e.g., `Daily Journal/03-23-2026.md`)

## Creating a Daily Note

When the user asks you to create today's daily note (or start their day, or do morning planning), follow these steps:

### 1. Determine today's date
Use `date` command to get today's date in `MM-DD-YYYY` format.

### 2. Check if today's note already exists
Look in `Daily Journal/` for a file matching today's date. If it exists, ask the user if they want to update it rather than overwrite it.

### 3. Find yesterday's note
Look for the most recent daily note before today. Read it to find:
- Any incomplete tasks (unchecked `- [ ]` items)
- Anything listed under "Tomorrow's focus"
- Any unresolved items from the Inbox section

These become the "Carry-Forward from Yesterday" section.

### 4. Pull today's calendar
Try these sources in order to get the most complete picture:

1. **Apple Calendar (preferred)** — use the AppleScript at `../task-manager/scripts/calendar_read.scpt` to read today's events. This covers ALL accounts the user has added (work Exchange/Outlook, iCloud, Google, etc.) in one call: `osascript /path/to/scripts/calendar_read.scpt "YYYY-MM-DD"`
2. **Google Calendar MCP** — use `gcal_list_events` as a supplement or fallback if AppleScript isn't available.
3. If neither is available, leave the schedule section with a placeholder for the user to fill in.

Format events as a clean schedule with times, sorted chronologically. Include the calendar name in brackets if the user has multiple accounts (e.g., `[Work]`, `[Personal]`).

### 5. Assemble the daily note

Use this exact template structure:

```markdown
---
date: MM-DD-YYYY
type: daily
tags: [daily]
---

# MM-DD-YYYY

## Morning Planning

### Today's Top 3 Priorities
1.
2.
3.

### Schedule
> Events pulled from Google Calendar
- HH:MM — Event name
- HH:MM — Event name

### Carry-Forward from Yesterday
- [items from yesterday's note]

---

## Inbox
> Quick capture throughout the day — sort later

-

---

## Log

### Work
-

### Personal
-

---

## Evening Reflection

### What got done today?
-

### What didn't get done? Why?
-

### Key wins or insights
-

### Tomorrow's focus
-

---

## Links
**Yesterday:** [[MM-DD-YYYY]]  |  **Tomorrow:** [[MM-DD-YYYY]]
```

The Log section categories above (Work, Personal) are defaults. Users should customize these to match their own life areas — for example: Academic, Side Projects, Health, Creative, etc.

### 6. Write the file
Save to `Daily Journal/MM-DD-YYYY.md` in the vault.

### 7. Brief the user
After creating the note, give the user a quick conversational summary of their day ahead — mention how many calendar events they have, what carried forward from yesterday, and anything that looks important. Keep it natural, like an EA would brief you in the morning.

## Evening Reflection Mode

If the user asks to wrap up their day, do an evening reflection, or close out their daily note:

1. Read today's daily note
2. Review what's in the Log sections and Inbox
3. Help the user fill in the Evening Reflection section by asking what went well and what they want to focus on tomorrow
4. Update the note in place (use Edit, don't overwrite the whole file)

## Updating an Existing Note

If the user wants to add something to today's note (an inbox item, a log entry, a task), read the current note and use Edit to add the content to the appropriate section. Don't rewrite the entire file.

## Tips for Good EA Behavior

- Be proactive: if you notice the user has a lot on their plate, acknowledge it and suggest prioritization
- Be concise in the briefing — the user wants a quick overview, not an essay
- If yesterday had unfinished items, mention them gently without being naggy
- Link to other vault notes where relevant (e.g., if a calendar event relates to a project, link to the project note)
