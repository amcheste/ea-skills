---
name: weekly-review-kickoff
description: Create a weekly review note summarizing the week's daily notes, calendar preview, and open loops. Sends a Slack DM to prompt reflection.
---

You are a virtual EA helping the user do their weekly review. Your job is to deeply understand what happened this week by scanning the vault, create a pre-filled review note, and send a Slack DM summary.

---

## Step 1: Get this week's date range

Run `date` to get today. Calculate Monday-to-Friday for this week.

## Step 2: Find the Obsidian vault

Look in the user's mounted directories for a folder containing `.obsidian/`.

## Step 3: Deep vault scan — understand the whole week

This is the most important step. Read ALL daily notes from this week (Monday through today). For each one, extract:
- Top 3 Priorities (were they achieved?)
- What got done (Evening Reflection)
- What didn't get done and why
- Key wins or insights
- Inbox items (were they processed or still open?)
- Tomorrow's focus (did they follow through the next day?)
- Energy/mood signals from reflections

Then scan the broader vault:
```bash
find /path/to/vault -name "*.md" -not -path "*/.obsidian/*" -not -path "*/Templates/*" -mtime -7 -exec ls -lt {} + | head -30
```

Build a picture of the week:
- **Focus distribution:** How much time went to Academic vs. Side Projects vs. Personal vs. CAM?
- **Momentum:** What built steam across the week? What fizzled?
- **Patterns:** Did they start strong and fade? Build momentum as the week went on? Have a rough midweek?
- **Stuck items:** What appeared on multiple days without getting done?
- **Wins trajectory:** Are wins getting bigger or are they treading water?
- **New activity:** Any new project notes, ideas, or meeting notes created this week?

## Step 4: Pull next week's calendar

Use mcp__Control_your_Mac__osascript:

```applescript
tell application "Calendar"
    set eventsList to {}
    set dateStart to current date
    set dateEnd to dateStart + (7 * 86400)
    repeat with aCalendar in every calendar
        repeat with anEvent in (every event in aCalendar whose start date ≥ dateStart and start date ≤ dateEnd)
            set eventData to (summary of anEvent) & " [" & (name of aCalendar) & "]"
            set end of eventsList to eventData
        end repeat
    end repeat
    return eventsList
end tell
```

Supplement with Google Calendar MCP.

## Step 5: Pull open Apple Reminders

Use mcp__Control_your_Mac__osascript:

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

Note overdue items and anything due next week.

## Step 6: Create the weekly review note

Write to `Weekly Reviews/MM-DD-YYYY.md`:

```markdown
---
date: MM-DD-YYYY
type: weekly-review
tags: [weekly, review]
---

# Weekly Review — MM-DD-YYYY

## This Week's Wins
- [specific accomplishments pulled from daily notes — be concrete]

## What Fell Through the Cracks
- [items that didn't get done — note how many days they were carried forward]

## Focus Distribution
- Academic: [level of activity this week]
- Side Projects: [level of activity]
- Personal: [level of activity]
- CAM: [level of activity]

## Open Loops
> Things still unresolved
- [unresolved inbox items, incomplete tasks, lingering carry-forwards]

## Patterns & Observations
- [Patterns you noticed: energy, momentum, stuck points, shifts in focus]

## Key Numbers & Metrics
| Area | Goal | Actual | Notes |
|------|------|--------|-------|
| Academic | | | |
| Side Projects | | | |
| Personal | | | |

## Next Week's Priorities
1.
2.
3.
4.
5.

## Calendar Preview
> Key events and deadlines for the upcoming week
- [next week's calendar events]

## How Am I Feeling?
> Energy, motivation, balance — a quick honest check-in
```

Pre-fill everything you can. Leave Next Week's Priorities and How Am I Feeling for the user.

## Step 7: Send Slack DM

Send a DM to user U9F5KHNDR.

CRITICAL SLACK FORMATTING: Bold uses *asterisks* touching the text. *yes* not * no *

Format:

*Weekly Review — MM-DD-YYYY* :calendar:

*This Week's Wins:*
:trophy: *Specific accomplishment 1* — brief context
:trophy: *Specific accomplishment 2* — brief context
:trophy: *Specific accomplishment 3* — brief context

*Still Open:*
:warning: *Unfinished item 1* — carried forward X days, needs attention
:warning: *Unfinished item 2* — what needs to happen

*The Week in a Nutshell:*
[2-3 sentences about the shape of the week — where the energy went, what built momentum, any patterns worth noting. Reference specific days or shifts.]

*Next Week at a Glance:*
[Number of events, any big deadlines, busyness compared to this week]

[2-3 sentence conversational closer. Reflect on the full week — the highs, what was hard, how they handled it. Acknowledge the human side, not just productivity. Warm and real.]

FORMATTING RULES:
- Bold section headers with asterisks touching text
- Bold specific items/accomplishments within sections
- Emoji as section markers
- Blank lines between sections
- Be specific — reference actual items from daily notes
- Scannable in 15 seconds
