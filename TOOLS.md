# TOOLS.md - Knowledge Base Tools

*Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your knowledge base setup.*

---

## What Goes Here

Things like:

- Preferred search tools and aliases
- Citation preferences
- Export formats you use
- Integration preferences
- Anything specific to your workflow

---

## Search Tools

### Preferred Search Method
- **Primary**: [ripgrep, find, custom script, etc.]
- **Command**: [your preferred command]
- **Aliases**: [any aliases you use]

### Search Patterns You Use Often
```bash
# Find by tag
rg 'tags: \["?[^"\]]*tag-name' knowledge-base/

# Find recent updates
rg 'last_updated: "2026-' knowledge-base/

# Find active items
rg 'status: "active"|status: "in_progress"' knowledge-base/
```

---

## Citation Preferences

### Citation Style
- **Format**: [APA, MLA, Chicago, custom, etc.]
- **Include**: [author, date, title, URL, all of the above]
- **Placement**: [inline, footnotes, endnotes]

### Source Tracking
- How to mark external sources: [method]
- How to mark internal references: [method]
- Verification status: [draft, verified, needs review]

---

## Export Formats

When exporting knowledge base content, prefer:

- **Primary format**: [markdown, html, pdf, etc.]
- **For sharing**: [format]
- **For archiving**: [format]
- **For printing**: [format]

---

## Integration Preferences

### External Tools Connected
- [Tool 1]: [how it connects]
- [Tool 2]: [how it connects]

### Data Flows
- How data enters the KB: [method]
- How data leaves the KB: [method]
- Sync frequency: [daily, on-change, manual]

---

## Workflow Shortcuts

### Common Tasks
```bash
# Quick status check
[command]

# Health check
[command]

# New entry from template
[command]
```

### Aliases You Use
- [alias]: [what it does]
- [alias]: [what it does]

---

## Notes

*Add whatever helps you work with this knowledge base. This is your cheat sheet.*

-

---

_Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share patterns without leaking your infrastructure._
