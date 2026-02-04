# AI Agent Instructions - Knowledge Base System

## ⚠️ SESSION CHECKLIST

**Before starting work, confirm:**
- [ ] You have loaded this AGENTS.md file
- [ ] You understand the self-annealing mandate (see below)
- [ ] You have scanned the folder structure

**If this is a fresh session, say:** *"Initializing memory bank session. Loading knowledge-base/AGENTS.md and scanning folder structure."*

---

## Quick Start

### For AI Assistants
1. **Load this file first** on every new session
2. **Scan the folder structure** to understand current state
3. **Check relevant folders** based on user's query:
   - `clients/` - People profiles, interviews, CVs
   - `ideas/` - App concepts, business ideas
   - `research/` - Technical findings, market research
   - `projects/` - Active work, status tracking
   - `contexts/` - Conversation summaries
   - `templates/` - Reusable file templates
4. **Follow token management** rules (see below)
5. **Commit changes** after any file edits
6. **Propose improvements** when you detect friction

### Standard Search Patterns
```
# Find client profiles
grep -r "client_name" clients/

# Find by tag
grep -r "tag_name" --include="*.md"

# Find recent updates
grep -r "last_updated.*$(date +%Y-%m)" --include="*.md"
```

---

## File Conventions (Rules)

### REQUIRED: YAML Frontmatter Schema
Every markdown file MUST include at minimum:
```yaml
---
title: "string"           # REQUIRED: Brief, descriptive title
created: "YYYY-MM-DD"     # REQUIRED: Creation date
last_updated: "YYYY-MM-DD" # REQUIRED: Update date
status: "string"          # REQUIRED: See folder-specific statuses
tags: []                  # REQUIRED: Array of relevant tags
---
```

### REQUIRED: File Naming Conventions
- Use lowercase with hyphens: `client-name.md`, `project-update.md`
- Be descriptive but concise
- Avoid dates in filenames (use frontmatter instead)

### REQUIRED: Status Values by Folder
- **clients/**: `active`, `completed`, `archived`
- **ideas/**: `idea`, `planning`, `in_progress`, `on_hold`, `completed`, `abandoned`
- **research/**: `draft`, `in_review`, `published`, `archived`
- **projects/**: `not_started`, `in_progress`, `completed`, `on_hold`, `archived`
- **contexts/**: `active`, `completed`, `reference`

### REQUIRED: Tag Conventions
- Use lowercase
- Use hyphens for multi-word: `ai-development`, `market-research`
- Be consistent: prefer `meeting` over `meetings`, `interview` over `interviews`
- Minimum 1 tag per file, ideally 3-5

---

## Token Management (Rules)

### REQUIRED: Token Budgets
- **Per query**: Maximum 2000 tokens context
- **Per file**: Maximum 500 tokens when including
- **Large files**: Summarize if >1000 tokens before including

### REQUIRED: Context Inclusion Strategy
1. **Always include** AGENTS.md (this file)
2. **Include relevant project files** based on user query
3. **Summarize older content** - full text only for recent/active items
4. **Use grep/search first** to find relevant files, don't load everything
5. **Track session imports** - avoid re-loading same files

### RECOMMENDED: Content Chunking
- Split large files at logical boundaries (sections, topics)
- Use clear headers for easy navigation
- Cross-reference related content instead of duplicating

---

## Workflows (Rules)

### REQUIRED: Creating New Files
1. **Check templates/** folder first - use appropriate template
2. **If no template exists**, create file following conventions above
3. **Suggest new template** if you find yourself creating similar files manually
4. **Add relevant tags** during creation
5. **Commit immediately** after creation

### REQUIRED: Updating Files
1. **Update `last_updated`** field in frontmatter
2. **Update `status`** if progress has changed
3. **Append to Progress Log** section if it exists
4. **Commit after edits** with descriptive message

### REQUIRED: Git Workflow
```bash
# After any file changes:
git add .
git commit -m "[Action]: [Brief description]

- Detail 1
- Detail 2"

# Action prefixes:
# Added: - New file created
# Updated: - Existing file modified
# Fixed: - Bug fix or correction
# Refactored: - Restructured without content change
```

### REQUIRED: Cross-Referencing
- Link to related files: `[Related: Client Profile](clients/client-name.md)`
- Use consistent link format: relative paths from knowledge-base/
- Update links if files are moved or renamed

---

## Self-Annealing System (CRITICAL - Rules)

### MANDATE: Continuous Improvement
**You MUST actively look for opportunities to improve this knowledge base system. This is not optional. When you detect friction, inefficiency, or gaps, you MUST propose improvements to the user.**

### REQUIRED: Friction Detection Checklist
After each session, evaluate:

#### Template Gaps
- [ ] Did I create any files WITHOUT using a template?
- [ ] Did I manually recreate similar file structures multiple times?
- [ ] Were any template sections consistently unused or empty?

**If YES → Propose new or modified template**

#### Workflow Inefficiencies
- [ ] Did I search multiple folders to find related information?
- [ ] Were status fields consistently outdated or inaccurate?
- [ ] Did I struggle to decide where to save information?
- [ ] Were git commit messages unclear or inconsistent?

**If YES → Propose workflow or structural improvements**

#### Data Quality Issues
- [ ] Are there duplicate or conflicting entries?
- [ ] Are tags inconsistent (e.g., both `meeting` and `meetings`)?
- [ ] Are there orphan files (no tags, no links, no clear purpose)?
- [ ] Are status fields >30 days old without updates?

**If YES → Propose cleanup or quality improvement**

#### Performance Concerns
- [ ] Are files becoming too large (>5000 tokens)?
- [ ] Is grep/search becoming slow (100+ files)?
- [ ] Is cross-referencing becoming difficult to maintain?

**If YES → Propose architectural improvements**

### REQUIRED: Improvement Proposal Template
When proposing improvements, use this format:

```markdown
## 🚨 IMPROVEMENT PROPOSED: [Title]

### Issue Detected
[Clear description of the friction/gap/inefficiency]

### Evidence
- [Specific example 1]
- [Specific example 2]

### Proposed Solution
[Specific, actionable recommendation]

### Implementation Steps
1. [Step 1]
2. [Step 2]
3. [Step 3]

### Impact
- **Effort**: [Low/Medium/High]
- **Benefit**: [Minimal/Moderate/Significant]
- **Urgency**: [Now/This week/When convenient]

### Prevention
[How to avoid this issue in the future]
```

### REQUIRED: Periodic Health Checks
**Every 10 files edited OR every 3 sessions** (whichever comes first), perform:

```markdown
## Health Check Report

### Tag Consistency Scan
- [ ] Identified inconsistent tags: [list]
- [ ] Proposed standardization: [recommendation]

### Duplicate Detection
- [ ] Potential duplicates found: [list]
- [ ] Merge or deduplication needed: [yes/no]

### Large File Warning
- [ ] Files >5000 tokens: [list]
- [ ] Chunking recommended: [yes/no]

### Status Staleness
- [ ] Files with status >30 days old: [list]
- [ ] Updates or archival needed: [yes/no]

### Orphan Files
- [ ] Files with no tags or cross-references: [list]
- [ ] Action needed: [yes/no]
```

---

## Multi-AI Compatibility (Guidelines)

### Design Principles
- Use **standard Markdown** - no AI-specific syntax
- Use **clear file paths** - any AI should navigate easily
- Avoid **tool-specific features** - no OpenCode-only conventions
- Maintain **consistent structure** - predictable patterns

### For Non-OpenCode AIs
If using Claude, ChatGPT, Gemini, or other AI assistants:
1. Provide this AGENTS.md file
2. Direct them to load from `knowledge-base/AGENTS.md`
3. The structure should be self-explanatory without tool dependencies

---

## Session Management (Guidelines)

### Starting a Session
1. **Load AGENTS.md** (this file)
2. **Scan folder structure** to understand current state
3. **Identify active projects** (check status fields)
4. **Ask user**: "What would you like to work on?"

### During a Session
1. **Include relevant context** - load files related to the task
2. **Track what you've loaded** - avoid redundant includes
3. **Update files as you go** - don't wait until the end
4. **Commit regularly** - after each logical change
5. **Watch for friction** - note any system issues

### Ending a Session
1. **Commit all pending changes**
2. **Update any status fields** that changed
3. **Run friction detection checklist**
4. **Report any proposed improvements**
5. **Summarize what was accomplished**

---

## Common Tasks (Guidelines)

### Adding a New Client
1. Copy `templates/client-profile.md` to `clients/[client-name].md`
2. Fill in all sections
3. Set status to `active`
4. Add relevant tags (industry, role type, etc.)
5. Commit: `Added: Client profile for [name]`

### Logging a Meeting
1. Copy `templates/meeting-notes.md` to `contexts/meeting-[date]-[topic].md`
2. Record attendees, key points, action items
3. Link to relevant client/project files
4. Set status to `completed` (if done) or `active` (if follow-ups needed)
5. Commit: `Added: Meeting notes for [topic]`

### Tracking Research
1. Copy `templates/research-notes.md` to `research/[topic]-[date].md`
2. Document findings, sources, key insights
3. Tag with research type: `market-research`, `technical-analysis`, etc.
4. Link to related ideas or projects
5. Commit: `Added: Research on [topic]`

### Updating Project Status
1. Open relevant project file in `projects/`
2. Update `last_updated` field
3. Add entry to Progress Log
4. Update status if phase changed
5. Update Next Steps
6. Commit: `Updated: [Project] - [what changed]`

---

## Troubleshooting (Guidelines)

### Common Issues

**"Can't find information"**
- Check all relevant folders systematically
- Use grep to search for keywords
- Ask user for clarification on where it might be

**"Not sure where to save this"**
- Review folder structure in this file
- Check similar existing files for patterns
- Ask user: "Should this go in [folder] or [folder]?"

**"File is too large"**
- Summarize old content
- Split into logical sections
- Move completed sections to archive

**"Status fields are confusing"**
- Check REQUIRED status values above
- Propose clarification if conventions unclear
- Update AGENTS.md if needed

---

## System Evolution Log

Track major system changes here:

| Date | Change | Reason |
|------|--------|--------|
| 2026-02-04 | Initial AGENTS.md created | Establish self-annealing system |

---

## Questions or Issues?

If you encounter problems with this system:
1. Check this file for guidance
2. Look at existing files for examples
3. Propose improvements using the template above
4. Ask the user for clarification when needed

**Remember: This system evolves through use. Your observations and proposals make it better.**

---

**Last Updated**: 2026-02-04  
**Version**: 1.0  
**Status**: Active
