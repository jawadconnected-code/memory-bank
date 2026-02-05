---
title: "Search Guide - Knowledge Base"
created: "2026-02-05"
last_updated: "2026-02-05"
status: "active"
tags: ["search", "grep", "guide"]
---

# SEARCH.md - Knowledge Base Search Guide

**Note:** Grep-based search is sufficient for files < 500. When threshold is reached, reassess to vector semantic search.

---

## Quick Search Patterns

### Find by Content
```bash
# Basic keyword search
rg "keyword" knowledge-base/

# Case-insensitive
rg -i "keyword" knowledge-base/

# Exact phrase
rg '"exact phrase"' knowledge-base/
```

### Find by Tag
```bash
# Find files with specific tag
rg -l 'tags: \["?[^"\]]*keyword' knowledge-base/
```

### Find by Status
```bash
# Find active items
rg 'status: "active"' knowledge-base/

# Find in_progress items
rg 'status: "in_progress"' knowledge-base/
```

### Find by File Type
```bash
# Client profiles
rg -l "clients/" --include="*.md"

# Project updates
rg -l "projects/" --include="*.md"

# Research notes
rg -l "research/" --include="*.md"
```

---

## Advanced Patterns

### Find Recently Updated
```bash
# Files updated this month
rg 'last_updated: "2026-02"' knowledge-base/
```

### Find Action Items
```bash
# Find all action items
rg '\- \[ \]' knowledge-base/

# Find completed items
rg '\- \[x\]' knowledge-base/
```

### Find by Frontmatter
```bash
# Find files with specific title
rg -l 'title: ".*keyword' knowledge-base/
```

---

## Navigation Helpers

### List All Files by Type
```bash
# List all clients
ls knowledge-base/clients/

# List all projects
ls knowledge-base/projects/

# List all templates
ls knowledge-base/templates/
```

### Check File Count
```bash
# Total markdown files
find knowledge-base -name "*.md" | wc -l

# By folder
find knowledge-base/clients -name "*.md" | wc -l
```

---

## Search Workflow

### 1. Identify Context
- What folder does it belong to?
- What tags might it have?

### 2. Search Broadly
```bash
rg "keyword" knowledge-base/ --md
```

### 3. Narrow Down
```bash
# Specific folder
rg "keyword" knowledge-base/clients/ --md

# Specific tag pattern
rg -l 'tags: \["[^"\]]*keyword' knowledge-base/
```

### 4. Read Relevant Files
- Load files identified in search
- Cross-reference related content

---

## Common Searches

| Purpose | Command |
|---------|---------|
| Find client | `rg "Client Name" knowledge-base/` |
| Find project status | `rg "project-name" knowledge-base/projects/` |
| Find active items | `rg 'status: "active"' knowledge-base/` |
| Find decisions | `rg "Decision" knowledge-base/` |
| Find action items | `rg '\- \[ \]' knowledge-base/` |
| Find by date | `rg "2026-02" knowledge-base/` |

---

## Performance Notes

- **< 100 files**: Instant grep response
- **100-500 files**: Sub-second response
- **> 500 files**: Consider vector search upgrade

**Current Status**: 12 files (well within grep capability)

---

**Last Updated**: 2026-02-05
**Next Review**: When file count reaches 400
