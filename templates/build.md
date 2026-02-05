---
build_id: "build-YYYY-MM-DD-HHMM"
started: "YYYY-MM-DD HH:MM"
status: "in_progress"
last_updated: "YYYY-MM-DD HH:MM"
---

# Build: [Brief Description]

**⚠️ IMPORTANT:** If this file exists, read it first. It tracks pending work and recovery points.

---

## Status
- **Current Phase**: [planning|in_progress|completed|interrupted]
- **Started**: [timestamp]
- **Last Updated**: [timestamp]
- **Git Tag**: `build-start-YYYY-MM-DD-HHMM`

---

## Progress Summary
- **Completed**: N of M tasks
- **In Progress**: Task X
- **Remaining**: N tasks

---

## Task List

### Completed ✅
- [x] Task 1: [Description] [completed: YYYY-MM-DD HH:MM]
- [x] Task 2: [Description] [completed: YYYY-MM-DD HH:MM]

### In Progress 🔄
- [ ] Task 3: [Description] [started: YYYY-MM-DD HH:MM]

### Pending ⏳
- [ ] Task 4: [Description]
- [ ] Task 5: [Description]

---

## Recovery Notes

### Last Completed Action
[Description of what was last done before any interruption]

### Context to Remember
[Any important context needed to resume]

### Files Modified
[List of files that have been changed]

---

## Workflow Reference

### Starting a New Build
```
1. Read existing BUILD.md (check for interrupted builds)
2. Create new BUILD.md with task list
3. Commit: "Started: [build description]"
4. Git tag: `build-start-YYYY-MM-DD-HHMM`
```

### During Build
```
1. Mark task as "in progress" before starting
2. Complete task, mark as done with timestamp
3. Commit after each task
4. Update progress summary
```

### Completing a Build
```
1. Mark status as "completed"
2. Git tag: `build-complete-YYYY-MM-DD-HHMM`
3. Commit: "Completed: [build description]"
4. Move to archive/builds/
```

### After Crash/Interruption
```
1. Read BUILD.md
2. Check status to determine phase
3. Review completed tasks (marked with [x])
4. Identify in-progress task
5. Assess state and resume
```

---

**Template Version**: 1.0
**Last Updated**: YYYY-MM-DD HH:MM
