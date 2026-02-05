<!-- AI: Load knowledge-base/AGENTS.md for system instructions -->

# AI Memory Bank - Quick Start Guide

## What This Is
A personal knowledge management system for AI interactions. Store ideas, client information, research, and context for future AI conversations.

---

## 🚀 AI Quick Start

**For AI Assistants: Start every session by saying:**
```
Initializing memory bank session. Loading knowledge-base/AGENTS.md and scanning folder structure.
```

**Important Files to Load:**
1. `knowledge-base/AGENTS.md` - System instructions and rules
2. `knowledge-base/projects/ai-memory-bank.md` - Project status
3. Relevant folders based on user query

**The AI is mandated to:**
- Propose system improvements when friction is detected
- Commit changes after edits
- Run periodic health checks
- Follow token management rules

---

## Your Next Steps (In Order)

### Step 1: Verify Git Repository
```bash
cd knowledge-base
git status
```

### Step 2: Start Using It
Begin storing memories by telling the AI to save information. Example:
- "Save this client profile to memory bank"
- "Add this research finding to my knowledge base"
- "Update my project status in ai-memory-bank.md"

## Folder Structure
```
knowledge-base/
├── AGENTS.md         # AI system instructions (START HERE)
├── clients/          # Client profiles, CVs, interviews
├── ideas/            # App ideas, concepts
├── research/         # Research notes, findings
├── contexts/         # AI conversation summaries
├── projects/         # Active projects (like this one)
└── templates/        # Reusable markdown templates
```

## Important Files
- **AGENTS.md** - AI system instructions (load this first!)
- **README.md** - This file (overview and getting started)
- **projects/ai-memory-bank.md** - Main project tracking file
- **templates/** - All templates available (client-profile, idea-template, research-notes, meeting-notes, daily-log, project-update)

## How to Access in Future Chats

### Option 1: Initialize AI Session (Recommended)
Tell the AI: **"Load AGENTS.md from knowledge-base/"**

The AI will then automatically:
- Load system instructions
- Scan folder structure
- Identify active projects
- Ask what you want to work on

### Option 2: Specific Context
"Load my memory bank context from `knowledge-base/projects/ai-memory-bank.md`"

### Option 3: Search
"Search my knowledge base for anything related to [topic]"

### Option 4: Project Reference
"I'm working on the AI Memory Bank project. Load the latest context."

## Git Workflow
For detailed setup, see [SETUP.md](SETUP.md).

```bash
# After making changes
git add .
git commit -m "Added: [Brief description]"
git push origin main
```

## System Features

### Self-Annealing System
The AI is configured to:
- **Propose improvements** when friction is detected (missing templates, workflow issues, etc.)
- **Run health checks** every 10 files edited or 3 sessions
- **Suggest optimizations** based on actual usage patterns

### Templates Available
- **client-profile.md** - People profiles, CVs, interviews
- **idea-template.md** - App ideas, concepts
- **research-notes.md** - Technical findings, analysis
- **meeting-notes.md** - Interview transcripts, meeting summaries
- **daily-log.md** - Quick daily notes, progress tracking
- **project-update.md** - Sprint/phase updates

### Token Management
- Budget: 2000 tokens per query
- Chunk size: 500 tokens
- Large files (>1000 tokens) summarized before inclusion

## Need Help?
Tell the AI: "Help me with my memory bank project. Load the context and guide me through [specific task]."

---
**Status**: AGENTS.md created, self-annealing system active, all templates ready  
**Last Updated**: 2026-02-04  
**Next Milestone**: Create first real client profile and test self-annealing in action