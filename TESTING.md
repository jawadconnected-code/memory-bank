# TESTING.md - Knowledge Base Testing Guide

This document describes the testing infrastructure for the knowledge base system.

---

## Table of Contents

1. [Overview](#overview)
2. [Running Tests](#running-tests)
3. [Test Suite](#test-suite)
4. [Test Categories](#test-categories)
5. [Pre-commit Hook](#pre-commit-hook)
6. [CI/CD Integration](#cicd-integration)
7. [Troubleshooting](#troubleshooting)

---

## Overview

The knowledge base includes an automated test suite to ensure:

- **Foundation files** are present and accessible
- **Schema compliance** (frontmatter, tags, dates)
- **Git integration** is working correctly
- **Build tracking** enables crash recovery
- **Memory system** is properly configured
- **Self-annealing** mechanisms are documented

---

## Running Tests

### Quick Start

```bash
# Run all tests (verbose output)
./testing/scripts/kb-test.sh

# Run tests in quiet mode (CI/CD)
./testing/scripts/kb-test.sh --quiet

# Show help
./testing/scripts/kb-test.sh --help
```

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All tests passed |
| 1 | One or more tests failed |

---

## Test Suite

### Foundation Files

Tests that all required foundation files exist:

| File | Purpose |
|------|---------|
| `SOUL.md` | KB assistant personality |
| `USER.md` | User preferences |
| `TOOLS.md` | Search tools and shortcuts |
| `AGENTS.md` | Operational rules |
| `MEMORY.md` | Curated long-term memory |
| `HEARTBEAT.md` | Proactive reminders |
| `BOOTSTRAP.md` | Setup and recovery guide |
| `SEARCH.md` | Search patterns |

### Folder Structure

Tests that required folders exist:

```bash
clients/
ideas/
research/
projects/
contexts/
memory/
templates/
archive/builds/
testing/scripts/
```

### Templates

Tests that all templates exist:

| Template | Purpose |
|----------|---------|
| `build.md` | Multi-file build tracking |
| `client-profile.md` | Client intake |
| `daily-log.md` | Daily logging |
| `meeting-notes.md` | Meeting documentation |
| `project-update.md` | Project status |
| `research-notes.md` | Research documentation |

### Frontmatter Schema

Tests that all markdown files have valid frontmatter:

```yaml
---
title: "string"           # REQUIRED
created: "YYYY-MM-DD"     # REQUIRED
last_updated: "YYYY-MM-DD" # REQUIRED
status: "string"          # REQUIRED
tags: []                  # REQUIRED
---
```

### Git Integration

Tests git repository health:

- Repository exists
- Working tree status
- Build tags exist

### Build Tracking

Tests BUILD.md functionality:

- Template exists with required fields
- Active BUILD.md is parseable
- Archive folder exists

### Memory System

Tests memory configuration:

- MEMORY.md exists with sections
- memory/ folder exists

### Self-Annealing

Tests AGENTS.md sections:

- Self-Annealing section exists
- Friction Detection checklist exists
- Health Check section exists

---

## Test Categories

### Critical Tests (Must Pass)

| Test | Description |
|------|-------------|
| Foundation files | All 8 files exist |
| Templates | All 6 templates exist |
| Frontmatter | All files have valid schema |
| Folder structure | All required folders exist |

### Important Tests (Should Pass)

| Test | Description |
|------|-------------|
| Git integration | Repository is healthy |
| Build tracking | BUILD.md system works |
| Memory system | MEMORY.md configured |
| Self-Annealing | Mechanisms documented |

### Advisory Tests (Warnings)

| Test | Description |
|------|-------------|
| Stale files | Files >30 days old |
| File count | Approaching 500 threshold |
| Tags | Inconsistent tagging |

---

## Pre-commit Hook

The test suite can run automatically before commits to catch issues early.

### Setup

```bash
# Create pre-commit hook
cp testing/scripts/pre-commit.sh .git/hooks/pre-commit

# Make executable
chmod +x .git/hooks/pre-commit
```

### Pre-commit Hook Contents

```bash
#!/bin/bash
# Pre-commit hook - runs tests before commit

echo "Running knowledge base tests..."
./testing/scripts/kb-test.sh --quiet

if [[ $? -ne 0 ]]; then
    echo ""
    echo "Tests failed. Fix issues before committing."
    echo "Run './testing/scripts/kb-test.sh' for details."
    exit 1
fi

echo "Tests passed. Proceeding with commit."
exit 0
```

### Skip Pre-commit (Emergency)

```bash
# Skip pre-commit checks
git commit --no-verify -m "Emergency commit"
```

---

## CI/CD Integration

### GitHub Actions Example

```yaml
# .github/workflows/kb-tests.yml
name: Knowledge Base Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run KB Tests
        run: |
          chmod +x testing/scripts/kb-test.sh
          ./testing/scripts/kb-test.sh --quiet
```

### GitLab CI Example

```yaml
# .gitlab-ci.yml
kb-test:
  image: bash:latest
  script:
    - chmod +x testing/scripts/kb-test.sh
    - ./testing/scripts/kb-test.sh --quiet
  allow_failure: false
```

---

## Troubleshooting

### Tests Failing After Adding New Files

**Problem:** Tests fail when adding new files.

**Solution:** Ensure new files have valid frontmatter:

```yaml
---
title: "Your Title"
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
status: "active"
tags: ["tag1", "tag2"]
---
```

### Frontmatter Validation Fails

**Problem:** Frontmatter schema test fails.

**Solution:** Check that all 5 required fields are present:

```yaml
---
title: "required"           # ✅ Present
created: "required"          # ✅ Present
last_updated: "required"     # ✅ Present
status: "required"           # ✅ Present
tags: ["required"]           # ✅ Present
---
```

### Git Working Tree Not Clean

**Problem:** Warning about uncommitted changes.

**Solution:** Commit or stash changes:

```bash
# Option 1: Commit
git add .
git commit -m "Work in progress"

# Option 2: Stash
git stash
```

### Stale Files Warning

**Problem:** Files older than 30 days detected.

**Solution:** Review and update or archive:

```bash
# Find stale files
find . -name "*.md" -mtime +30

# Update status or archive
# Edit file to update last_updated
```

### File Count Approaching 500

**Problem:** Warning about scalability threshold.

**Solution:** Plan for semantic search upgrade:

1. Review SEARCH.md
2. Evaluate vector search options
3. Plan migration if needed

---

## Adding New Tests

### Test Function Template

```bash
test_new_feature() {
    log_section "New Feature"
    
    if [[ -f "$KB_DIR/new-file.md" ]]; then
        log_pass "New feature file exists"
    else
        log_fail "New feature file missing"
    fi
}
```

### Adding to Main Function

```bash
main() {
    # ... existing tests ...
    
    test_new_feature  # Add here
    
    # ... summary ...
}
```

---

## Test Output Examples

### Verbose Mode

```
=======================================
  Knowledge Base Test Suite
=======================================

[INFO] Test directory: /path/to/knowledge-base
[INFO] Date: 2026-02-05

=== Foundation Files ===
[PASS] Foundation file exists: SOUL.md
[PASS] Foundation file exists: USER.md
[FAIL] Foundation file missing: NEW_FILE.md
...

=== Test Summary ===

[PASS]   20
[FAIL]   1
[WARN]   2
[TOTAL]  21

❌ TESTS FAILED
```

### Quiet Mode

```
FAIL
```

---

## Best Practices

1. **Run tests before commits** using pre-commit hook
2. **Run tests after crashes** to verify system integrity
3. **Review warnings** even if tests pass
4. **Update tests** when adding new features
5. **Document test failures** for future reference

---

## See Also

- [AGENTS.md](AGENTS.md) - Operational rules
- [BOOTSTRAP.md](BOOTSTRAP.md) - Setup and recovery
- [templates/build.md](templates/build.md) - Build tracking template

---

**Last Updated**: 2026-02-05  
**Version**: 1.0
