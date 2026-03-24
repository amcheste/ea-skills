# EA Skills

A collection of Claude skills that turn AI into a virtual executive assistant (EA), built around an Obsidian vault as the central knowledge base.

These skills are designed for use with [Claude](https://claude.ai) in Cowork mode or Claude Code. They teach Claude how to manage your daily workflow — planning your mornings, capturing action items, running weekly reviews, and keeping everything organized in your Obsidian vault.

## What's Included

### Skills

| Skill | Description | Status |
|-------|-------------|--------|
| [Daily Note](skills/obsidian-daily-note/) | Creates and manages daily journal notes with morning planning, calendar integration, carry-forward from yesterday, and evening reflection | Done |
| [Quick Capture](skills/quick-capture/) | Zero-friction note capture — just say what's on your mind and it gets filed in the right place | Done |
| [Weekly Review](skills/weekly-review/) | Generates weekly review notes, summarizes daily notes, previews next week's calendar | Done |
| [Inbox Processing](skills/inbox-processing/) | Scans Gmail and Slack for action items, surfaces them in your daily note | Done |
| [Project Setup](skills/project-setup/) | Creates project notes from templates with proper linking and task breakdown | Done |
| [Meeting Notes](skills/meeting-notes/) | Creates meeting notes with prep mode, capture mode, and action item tracking | Done |
| [Task Manager](skills/task-manager/) | Apple Reminders integration with Eisenhower matrix prioritization, synced to vault | Done |

### Templates

Obsidian-compatible markdown templates in the `templates/` folder:

- **daily-note.md** — Morning planning + evening reflection
- **weekly-review.md** — End-of-week check-in with metrics and priorities
- **meeting-notes.md** — Agenda, notes, decisions, and action items
- **project.md** — Project overview with goals, milestones, and tasks

## Getting Started

### 1. Set Up Your Obsidian Vault

Create the following folder structure in your vault (or customize to fit your life):

```
Your Vault/
├── Daily Journal/
├── Weekly Reviews/
├── Meetings/
├── Ideas/
├── People/
├── Templates/
├── Resources/
├── Archive/
└── Home.md
```

Copy the templates from the `templates/` folder into your vault's `Templates/` folder.

### 2. Install a Skill

To use a skill in Claude Cowork or Claude Code, copy the skill folder into your skills directory. The exact location depends on your setup, but the skill just needs to be accessible to Claude as a mounted folder.

### 3. Customize the Log Categories

The daily note template comes with generic "Work" and "Personal" log sections. Customize these to match your life areas. For example:

- Academic, Side Projects, Health
- Client Work, Internal, Learning
- Day Job, Creative, Family

Edit both the template and the skill's SKILL.md to match your categories.

### 4. Optional: Apple Reminders Integration

The task manager skill uses the `Control_your_Mac osascript` MCP tool to read and write Apple Reminders via inline AppleScript. The default list routing is:

- **To Do** — general tasks
- **NCSU** — academic work (customize to your school)
- **CAM** — work/business tasks (customize to your company)
- **House** — home projects
- **Family** — family-related tasks
- **Groceries** — shopping lists

Customize the list names in the task-manager SKILL.md to match your own Reminders lists.

### 5. Optional: Apple Calendar Integration

The skills read Apple Calendar via the `Control_your_Mac osascript` MCP tool, which covers ALL accounts you've added to the Calendar app (work Exchange/Outlook, iCloud, Google, etc.). This is the preferred calendar source since it aggregates everything in one place. No extra setup needed — just add your accounts in System Settings → Internet Accounts.

### 6. Optional: Google Calendar Integration

The skills can also pull events from Google Calendar MCP as a supplement. This is useful if you don't have the `Control_your_Mac osascript` MCP available (e.g., running in a sandboxed environment). Set up the Google Calendar MCP connector in Claude to enable it.

## Philosophy

The idea is simple: your Obsidian vault is the single source of truth for your life, and Claude acts as your EA — helping you stay on top of things without you having to maintain the system yourself.

A good EA doesn't just follow instructions. They notice when you're overloaded and suggest prioritization. They carry forward what you forgot. They brief you in the morning and check in at the end of the day. These skills are designed to enable that kind of proactive, human-feeling assistance.

## Contributing

If you build additional EA skills or improve the existing ones, contributions are welcome. The main things to keep in mind:

- Skills should be generic enough to work for anyone (no hardcoded personal info)
- Templates should use Obsidian's `{{date}}` syntax for compatibility
- Keep the EA tone — conversational, proactive, not robotic

## License

MIT
