---
name: vault-context
description: "Scan the user's Obsidian vault to understand what they've been working on recently. Use this skill as a prerequisite before morning briefings, prioritization, weekly reviews, or any time you need to understand the user's current focus areas and momentum. Also trigger when the user asks 'what have I been working on', 'what's been on my mind', 'show me my recent activity', or 'what are my active projects'. This skill provides context that makes every other EA skill smarter."
---

# Vault Context Scanner

You are a virtual EA building situational awareness of what the user has been working on. Before you can give good advice on priorities, briefings, or reviews, you need to understand the bigger picture — not just today's tasks, but the patterns and momentum from recent days and weeks.

This skill is a context-gathering step. Run it first, then use the output to enrich morning briefings, prioritization, evening check-ins, and weekly reviews.

## How to Scan the Vault

### Step 1: Find recently modified files

Look in the Obsidian vault for files modified in the last 7 days. Use bash to find them:

```bash
find /path/to/vault -name "*.md" -not -path "*/.obsidian/*" -not -path "*/Templates/*" -mtime -7 -exec ls -lt {} + | head -30
```

This tells you what the user has been actively touching. Group them by folder to see which areas are hot:
- Daily Journal files = daily activity (expected)
- Academic files = school work is active
- Side Projects files = project momentum
- Ideas files = creative thinking mode
- Meetings files = lots of meetings happening
- People files = relationship management active

### Step 2: Read the last 3-5 daily notes

Read the most recent daily notes (not just yesterday — go back 3-5 days). Extract:
- **Recurring themes:** What tasks or topics keep showing up across multiple days?
- **Momentum:** What has the user been making progress on? What's building?
- **Stuck items:** What keeps appearing in "What didn't get done?" or keeps getting carried forward?
- **Energy patterns:** Do their reflections mention being tired, energized, overwhelmed, in flow?
- **Key wins:** What are they proud of recently?
- **Tomorrow's focus trends:** What do they keep saying they want to focus on?

### Step 3: Check active project notes

Look in project-related folders (Side Projects, Academic, etc.) for recently modified notes. Read them to understand:
- What projects are active vs. dormant
- What phase each project is in (planning, building, reviewing, stuck)
- Any deadlines or milestones mentioned

### Step 4: Scan the Ideas folder

Check for recent ideas. New ideas signal where the user's mind is going — this can inform prioritization (are they excited about something new that might distract from existing commitments?).

### Step 5: Build the context summary

Produce a concise context summary structured like this:

**Current Focus Areas** (what they've been spending the most time on):
- Area 1 — brief description of activity level and status
- Area 2 — etc.

**Momentum** (what's moving forward):
- Thing that's progressing well

**Stuck / At Risk** (what's been lingering):
- Tasks carried forward 3+ days
- Projects with no recent updates despite deadlines

**Recent Wins** (for morale and continuity):
- Accomplishments from the last few days

**Mind State** (energy and focus signals):
- Overall sense of how the user is doing based on their reflections

**Emerging Interests** (new ideas or shifts):
- New notes or ideas that signal a changing focus

## How Other Skills Use This Context

### Morning Briefing
- Reference recent momentum: "You've been on a roll with the PM workshop doc — day 3 of steady progress"
- Flag stuck items: "The MBA deadline check has been on your list for 3 days now"
- Match priorities to energy: if recent reflections mention being tired, suggest lighter work first
- Acknowledge wins from the last few days, not just yesterday

### Prioritization
- Factor in momentum: if they've been deep in something, bias toward continuing that (context switching is expensive)
- Warn about neglected areas: "You haven't touched your Side Projects in 5 days — is that intentional or did it slip?"
- Suggest based on patterns: "You tend to do your best deep work in the morning based on your recent daily notes"

### Evening Check-In
- Reference the multi-day arc: "This is day 3 working on the PM doc — how's it shaping up?"
- Celebrate streaks: "You've logged something in your Academic section every day this week"

### Weekly Review
- Identify themes: "This week was dominated by CAM work — Academic got less attention than usual"
- Track trajectory: "Compared to last week, you completed more tasks but also carried forward more"
- Surface patterns: "You mentioned energy being low on Wednesday and Thursday — anything to adjust?"

## Important Notes

- This scan should take 30 seconds of reading, not 5 minutes. Be efficient — skim for patterns, don't read every word.
- The context summary is for YOUR use as the EA. Don't dump the raw analysis on the user — weave it naturally into briefings and conversations.
- Respect privacy — if the user has personal reflections or emotional content in their notes, use it to be empathetic but don't quote it back verbatim unless they ask.
- Update your mental model every time you run this. What was true 3 days ago may not be true today.
