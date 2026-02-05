# BOOTSTRAP.md - Knowledge Base Setup Guide

*Welcome to your knowledge base. This guide covers setup, daily workflow, and recovery procedures.*

---

## Table of Contents

1. [Initial Setup](#initial-setup) - Follow once
2. [Daily Workflow](#daily-workflow) - Follow each session
3. [Recovery Procedures](#recovery-procedures) - Use when things break
4. [Common Tasks](#common-tasks) - Quick reference

---

## Initial Setup

*Follow these steps once when setting up a new knowledge base.*

### Step 1: Read the Foundation Files
```
1. Read SOUL.md - Who the KB assistant is
2. Read USER.md - Who you are and your preferences
3. Read TOOLS.md - Search tools and configurations
4. Read AGENTS.md - Operational rules
```

### Step 2: Customize for Your Needs
```
1. Update USER.md with your projects and preferences
2. Customize TOOLS.md with your search methods
3. Adjust SOUL.md if you want different assistant personality
4. Set up initial folder structure if needed
```

### Step 3: Verify the System
```bash
# Check git status
git status

# Run health check (if available)
kb health

# Verify templates exist
ls templates/
```

### Step 4: You're Ready
Delete this BOOTSTRAP.md section when done, or keep for reference.

---

## Daily Workflow

*Follow these steps at the start of each session.*

### Start of Session
```
1. Read AGENTS.md (this file references others)
2. Read SOUL.md (if KB assistant behavior matters for this session)
3. Check BUILD.md (if active build exists)
4. Read today's and yesterday's daily logs from memory/
5. Check MEMORY.md for relevant decisions/preferences
```

### During Session
```
1. Use templates from templates/ for new files
2. Update last_updated and status fields on edits
3. Commit after logical changes (per AGENTS.md rules)
4. Update daily log in memory/ for significant work
5. Mark progress in BUILD.md if building something
```

### End of Session
```
1. Commit all pending changes
2. Update status fields that changed
3. Run friction detection checklist (AGENTS.md)
4. Report any proposed improvements
5. Summarize accomplishments
```

---

## Recovery Procedures

*Use these when things break — crash, lost work, or corrupted files.*

### Scenario 1: Crash Mid-Build

**Symptoms:**
- AI stopped responding mid-task
- BUILD.md exists with in-progress tasks

**Recovery Steps:**
```
1. Read BUILD.md
2. Check status and task list
3. Review completed tasks (marked [x])
4. Identify in-progress task
5. Check git log for last commit
6. Resume from first incomplete item
```

**Example:**
```bash
# Check git log
git log --oneline -5

# Check BUILD.md
cat BUILD.md

# Resume work
# [Continue from identified point]
```

### Scenario 2: Lost Edits

**Symptoms:**
- Made edits but they weren't committed
- File is in previous state

**Recovery Steps:**
```
1. Check git status
2. Check git reflog (full history including resets)
3. Find lost commits
4. Restore if needed
```

**Example:**
```bash
# Check reflog
git reflog

# Restore lost commit
git checkout <commit-hash>
# Or
git reset --hard <commit-hash>
```

### Scenario 3: Corrupted File

**Symptoms:**
- File won't open or is garbled
- Frontmatter is broken

**Recovery Steps:**
```
1. Check git history for last good version
2. Restore from previous commit
3. Re-apply any lost changes
```

**Example:**
```bash
# View file history
git log --follow -p -- path/to/file.md

# Restore previous version
git checkout HEAD~1 -- path/to/file.md
```

### Scenario 4: Repository in Bad State

**Symptoms:**
- Git shows merge conflicts
- Branch is ahead/behind unexpectedly
- Unclear what happened

**Recovery Steps:**
```
1. Don't panic
2. Check git status
3. Review recent commits
4. Assess if clean reset is safe
```

**Example:**
```bash
# Check status
git status

# See what's changed
git diff

# View recent history
git log --oneline -10

# If safe to reset (no uncommitted work you need)
git reset --hard origin/main

# If unsafe, seek help
```

---

## Common Tasks

### Creating a New Entry
```bash
1. Copy template from templates/
2. Fill in the content
3. Set frontmatter (title, created, status, tags)
4. Commit: "Added: [entry name]"
```

### Searching the Knowledge Base
```bash
# By content
rg "keyword" knowledge-base/

# By tag
rg 'tags: \["?tag-name' knowledge-base/

# By status
rg 'status: "active"' knowledge-base/

# See TOOLS.md for more patterns
```

### Running Health Checks
```bash
1. Read AGENTS.md
2. Run friction detection checklist
3. Check for template violations
4. Review for improvements
```

### Backing Up
```bash
# Manual backup
git add .
git commit -m "Backup: $(date)"
git tag "backup-$(date +%Y-%m-%d)"
```

---

## File Reference

| File | Purpose | When to Read |
|------|--------|--------------|
| SOUL.md | KB assistant personality | When behavior matters |
| USER.md | Your preferences and context | When personalization matters |
| TOOLS.md | Search tools, citations | When working with content |
| AGENTS.md | Operational rules | Always |
| MEMORY.md | Curated decisions/preferences | When relevant to task |
| memory/YYYY-MM-DD.md | Daily logs | Every session |
| BUILD.md | Active tasks | When building something |

---

## Getting Help

If something breaks and this guide doesn't help:

1. Check git history for context
2. Review recent commits
3. Ask for clarification if unsure
4. Propose improvements to this guide

---

_Remember: Git is your safety net. Commit often, and you can always roll back._
