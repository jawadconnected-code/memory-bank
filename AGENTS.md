# AI Agent Instructions - Knowledge Base System

## ⚠️ SESSION CHECKLIST

**Before starting work, confirm:**
- [ ] You have loaded this AGENTS.md file
- [ ] You understand the self-annealing mandate (see below)
- [ ] You have scanned the folder structure
- [ ] You have read workspace foundation files (if new session)

**Foundation Files (read on fresh session):**
- `SOUL.md` - KB assistant personality and operating principles
- `USER.md` - User preferences, projects, and context
- `TOOLS.md` - Search tools, citation preferences, workflow shortcuts
- `BOOTSTRAP.md` - Setup guide and recovery procedures (optional reference)

**If this is a fresh session, say:** *"Initializing memory bank session. Loading knowledge-base/AGENTS.md and scanning folder structure."*

---

## Quick Start

### For AI Assistants
1. **Load this file first** on every new session
2. **Load workspace foundation files** (fresh session only):
   - `SOUL.md` - KB assistant personality and operating principles
   - `USER.md` - User preferences, projects, and context
   - `TOOLS.md` - Search tools, citation preferences, workflow shortcuts
3. **Scan the folder structure** to understand current state
4. **Check for active build**:
   - `BUILD.md` - If exists, read it first (crash recovery)
5. **Check relevant folders** based on user's query:
   - `clients/` - People profiles, interviews, CVs
   - `ideas/` - App concepts, business ideas
   - `research/` - Technical findings, market research
   - `projects/` - Active work, status tracking
   - `contexts/` - Conversation summaries
   - `memory/` - Daily logs (YYYY-MM-DD.md)
   - `templates/` - Reusable file templates
6. **Check memory files** on session start:
   - `MEMORY.md` - Curated long-term memory (direct context only)
   - `memory/YYYY-MM-DD.md` - Today's and yesterday's daily logs
   - `HEARTBEAT.md` - Proactive reminders checklist
7. **Follow token management** rules (see below)
8. **Commit changes** after any file edits
9. **Propose improvements** when you detect friction

### Standard Search Patterns
```
# Find client profiles
grep -r "client_name" clients/

# Find by tag
grep -r "tag_name" --include="*.md"

# Find recent updates
grep -r "last_updated.*$(date +%Y-%m)" --include="*.md"

# Search guide - see SEARCH.md for full patterns
```

---

## Workspace Foundation Files

The knowledge base has core files that define its operation:

| File | Purpose | When to Read |
|------|---------|--------------|
| **SOUL.md** | KB assistant personality and operating principles | When behavior matters |
| **USER.md** | User preferences, projects, and context | When personalization matters |
| **TOOLS.md** | Search tools, citations, workflow shortcuts | When working with content |
| **AGENTS.md** | Operational rules and workflows | Always |
| **MEMORY.md** | Curated decisions and preferences | When relevant to task |
| **HEARTBEAT.md** | Proactive reminders | Active sessions |
| **BOOTSTRAP.md** | Setup guide and recovery procedures | Initial setup or recovery |

### SOUL.md
Defines who the KB assistant is:
- Core truths (helpfulness, opinions, resourcefulness)
- Boundaries and safety rules
- Operating principles
- Communication style and vibe

### USER.md
Documents the user:
- Name, pronouns, timezone
- Current projects and goals
- Organization preferences
- Pet peeves and what makes them happy

### TOOLS.md
Documents the toolchain:
- Preferred search methods and patterns
- Citation preferences
- Export formats
- Workflow shortcuts and aliases

### BOOTSTRAP.md
Complete lifecycle guide:
- Initial setup procedures
- Daily workflow reference
- Recovery procedures for crashes
- Common tasks quick reference

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

## Template Validation (Rules)

### REQUIRED: When Creating Files from Templates
1. **Always use template files** from `templates/` folder
2. **Delete the validation checklist** after creating the file
3. **Verify frontmatter fields** match the REQUIRED schema exactly:
   - Must use `title` field (not `client_name`, `project_name`, etc.)
   - All 5 required fields must be present
   - No duplicate fields
4. **Remove redundant metadata** - frontmatter already contains dates and status
5. **Use validation checklist** at bottom of templates when available

### Common Template Violations to Avoid
- ❌ Using `client_name` instead of `title`
- ❌ Leaving `YYYY-MM-DD` placeholder dates
- ❌ Duplicate `tags` arrays
- ❌ Copying template footer metadata (redundant with frontmatter)
- ❌ Forgetting to delete the validation checklist comment

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

### Scalability Trigger
- **Current file count**: 12 markdown files
- **Reassessment threshold**: 500 files
- **When triggered**: Evaluate semantic search (vector embeddings) vs grep-based search
- **Trigger action**: Self-annealing health check will flag when file count reaches 400
- **Search guide**: See `SEARCH.md` for current grep patterns

---

## Memory System (Rules)

### Memory Files Overview
- `MEMORY.md` - Curated long-term memory (decisions, preferences, constraints)
- `memory/YYYY-MM-DD.md` - Daily logs for running context
- `HEARTBEAT.md` - Proactive reminders and check-in guidelines

### REQUIRED: Session Start Memory Loading
1. **Always load** AGENTS.md
2. **Load MEMORY.md** if in direct context (not group/shared contexts)
3. **Load today's and yesterday's daily logs** from `memory/`
4. **Load HEARTBEAT.md** for proactive contribution guidelines

### MEMORY.md Rules
- **SECURITY**: Only load in direct context, never in group/shared contexts
- **Content**: Decisions, preferences, constraints, open loops
- **Maintenance**: Update during health checks (consolidate from daily logs)
- **Format**: See MEMORY.md template for structure

### Daily Log Rules
- **Location**: `memory/YYYY-MM-DD.md`
- **When to write**: After significant work sessions
- **Content**: Key activities, decisions, learnings, open loops
- **Template**: Use `templates/daily-log.md`

### HEARTBEAT.md Usage
- **When to check**: 2-4 times per day during active sessions
- **What to check**: KB updates, project status, context freshness, self-annealing
- **Proactive actions**: Allowed without asking (read, update, commit, search)
- **Boundaries**: Follow quiet time rules (HEARTBEAT_OK)

### Memory Hygiene
- Consolidate daily log insights into MEMORY.md weekly
- Remove outdated decisions from MEMORY.md during health checks
- Keep daily logs as raw logs, MEMORY.md as curated content

---

## Build Tracking (Rules)

### When to Use BUILD.md
Create a BUILD.md file when:
- Working on multi-file implementations
- Implementing features that span multiple files
- Need to track progress across several tasks
- Want crash recovery capability

### BUILD.md Workflow

**Starting a Build:**
```
1. Check if BUILD.md already exists (interrupted build?)
2. Create new BUILD.md from template
3. List all tasks with descriptions
4. Commit: "Started: [build description]"
5. Git tag: `build-start-YYYY-MM-DD-HHMM`
```

**During Build:**
```
1. Mark task as "in progress" with timestamp
2. Complete task work
3. Mark task as done with [x] and timestamp
4. Commit: "[Action]: [task description]"
5. Update progress summary
```

**Completing a Build:**
```
1. Mark all tasks complete
2. Update status to "completed"
3. Commit: "Completed: [build description]"
4. Git tag: `build-complete-YYYY-MM-DD-HHMM`
5. Move BUILD.md to archive/builds/
```

### Crash Recovery
```
1. Read BUILD.md
2. Check status and completed tasks
3. Identify in-progress task
4. Check git log for context
5. Resume from first incomplete item
```

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

#### Memory Hygiene
- [ ] Daily logs written for active work periods?
- [ ] MEMORY.md updated with recent decisions/facts?
- [ ] Old daily logs consolidated into MEMORY.md?
- [ ] HEARTBEAT checklist reviewed and current?

**If YES → Memory maintenance needed**

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

### Memory System Health
- [ ] Daily logs present for last 7 days: [yes/no]
- [ ] MEMORY.md last updated: [date]
- [ ] Decisions captured in MEMORY.md: [count]
- [ ] HEARTBEAT.md last reviewed: [date]
- [ ] Memory maintenance performed: [date]

### Scalability Check
- [ ] Current file count: [X]
- [ ] Reassessment threshold (500) approaching: [yes/no]
- [ ] Search performance acceptable: [yes/no]
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
3. **Load memory files**:
   - Read `MEMORY.md` (direct context only)
   - Read today's and yesterday's daily logs from `memory/`
   - Check `HEARTBEAT.md` for proactive reminders
4. **Identify active projects** (check status fields)
5. **Ask user**: "What would you like to work on?"

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

### Creating a Daily Log
1. Copy `templates/daily-log.md` to `memory/YYYY-MM-DD.md`
2. Fill in key activities, decisions, learnings
3. Update `last_updated` field
4. Add any open loops or tomorrow's priorities
5. Commit: `Added: Daily log for YYYY-MM-DD`

### Consolidating Memory
1. Read recent daily logs from `memory/`
2. Identify decisions, preferences, constraints
3. Add to `MEMORY.md` with proper structure
4. Remove outdated entries from MEMORY.md
5. Commit: `Updated: MEMORY.md consolidated`

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
| 2026-02-04 | Added Template Validation section + updated client-profile template | Fix schema violations (client_name→title, duplicates, redundant metadata) |
| 2026-02-05 | Added Memory System (daily logs, MEMORY.md, HEARTBEAT.md) | Adopt OpenClaw patterns for session memory |
| 2026-02-05 | Added SEARCH.md + scalability trigger at 500 files | Grep-based search with upgrade path to vector search |
| 2026-02-05 | Integrated memory hygiene into self-annealing + health checks | Automated memory maintenance |
| 2026-02-05 | Added workspace foundation files (SOUL.md, USER.md, TOOLS.md, BOOTSTRAP.md) | Define assistant personality and user context |
| 2026-02-05 | Added BUILD.md template + build tracking workflow | Multi-file build management with crash recovery |

---

## Questions or Issues?

If you encounter problems with this system:
1. Check this file for guidance
2. Look at existing files for examples
3. Propose improvements using the template above
4. Ask the user for clarification when needed

**Remember: This system evolves through use. Your observations and proposals make it better.**

---

**Last Updated**: 2026-02-05  
**Version**: 1.2  
**Status**: Active
