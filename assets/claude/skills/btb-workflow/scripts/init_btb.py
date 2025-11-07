#!/usr/bin/env python3
"""
Initialize BTB workflow structure in a repository.

Creates:
- SPECS/ directory
- SPECS/README.md (navigation entrypoint)
- SPECS/PROGRESS.md (status tracking template)
- Template sections for easy customization
"""

import sys
from pathlib import Path
import subprocess
from datetime import datetime
import argparse


def find_repo_root() -> Path:
    """Find the git repository root."""
    try:
        result = subprocess.run(
            ["git", "rev-parse", "--show-toplevel"],
            capture_output=True,
            text=True,
            check=True,
        )
        return Path(result.stdout.strip())
    except subprocess.CalledProcessError:
        print("Error: Not in a git repository")
        sys.exit(1)


def get_current_branch() -> str:
    """Get the current git branch name."""
    try:
        result = subprocess.run(
            ["git", "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return "main"


def get_repo_name() -> str:
    """Get repository name from git."""
    repo_root = find_repo_root()
    return repo_root.name


def create_readme_template(project_name: str) -> str:
    """Generate README.md template."""
    return f"""# {project_name} - Documentation Guide

**Last Updated**: {datetime.now().strftime("%B %d, %Y")}

---

## 🎯 Quick Start: What to Read First

This guide helps you navigate the documentation and understand the project quickly.

### For Engineers

**Read in this order:**
1. **`PROGRESS.md`** (15 min) - Current status and what's implemented
2. **Design/MVP docs** (30-60 min) - Technical implementation guide
3. **Project README** (if exists) - Setup and development

### For Product Managers / Stakeholders

**Read in this order:**
1. **Design/MVP docs** (30 min) - Understand scope and decisions
2. **`PROGRESS.md`** (10 min) - Current status and what works today

---

## 📚 Document Purposes

### Primary Documents (Must Read)

| Document | Purpose | Audience | Status |
|----------|---------|----------|--------|
| **PROGRESS.md** | Current status, next steps | Everyone | ✅ Active |
| **README.md** (this file) | Documentation navigation guide | New team members | ✅ Current |

### Reference Documents

Add additional documents as needed:
- Design documents for comprehensive vision
- MVP documents for minimal scope definition
- Architecture diagrams
- API specifications

---

## 🔧 Development Workflow

### Running the Application

[TODO: Add setup and run instructions]

### Common Development Tasks

[TODO: Add common tasks specific to this project]

---

## 📞 Getting Help

### Documentation Issues

**Missing info?** → Update the relevant document
**Outdated?** → Check `PROGRESS.md` last updated date
**Confusing?** → Improve clarity via commit

---

**Ready to contribute?** Start with `PROGRESS.md` to see what's next!
"""


def create_progress_template(project_name: str, branch: str) -> str:
    """Generate PROGRESS.md template."""
    today = datetime.now().strftime("%B %d, %Y")

    # Try to detect session ID from branch if on claude/ branch
    session_line = ""
    if branch.startswith("claude/"):
        session_line = f"**Session**: {branch}\n"

    return f"""# {project_name} - Progress Report

**Report Date**: {today}
{session_line}**Branch**: `{branch}`
**Current Phase**: Initial Setup ✅

---

## Executive Summary

[TODO: 2-3 sentences summarizing current state and next steps]

---

## Current Capabilities (What Works Today)

### User Can Do:

[TODO: List what users can actually do right now]

### System Can Do:

[TODO: List what the system capabilities are]

---

## Next Steps

### Goals

[TODO: Describe what you're working toward next]

### Tasks

[TODO: Break down specific tasks with acceptance criteria]

**Acceptance Criteria**:
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

---

## Timeline & Phases

### Phase 1: [Name] (Week 1) [Status]

**Duration**: ~X hours
**Commits**: [list commit hashes]

**Deliverables**:
1. [What was delivered]
2. [What was delivered]

**Test Results**:
```
[Add test output if applicable]
```

**Key Files**:
- [List important files created/modified]

---

## Dependencies & Prerequisites

[TODO: List what needs to be installed/configured]

---

## Known Issues & Technical Debt

### Issues

[TODO: List known issues and their resolution plans]

### Technical Debt

[TODO: List technical debt items]

---

## Success Criteria

[TODO: Define what "done" looks like for this phase/project]

### Functional Requirements

- [ ] Requirement 1
- [ ] Requirement 2

### Technical Requirements

- [ ] All tests passing
- [ ] No console errors
- [ ] Documentation complete

---

**Report Status**: Current as of [commit hash]
**Next Update**: [When this will be updated next]

---

**End of Progress Report**
"""


def main():
    """Initialize BTB structure."""
    parser = argparse.ArgumentParser(
        description="Initialize BTB workflow in repository"
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing files",
    )
    args = parser.parse_args()

    repo_root = find_repo_root()
    specs_dir = repo_root / "SPECS"
    branch = get_current_branch()
    project_name = get_repo_name()

    print(f"🚀 Initializing BTB workflow for: {project_name}")
    print(f"   Repository: {repo_root}")
    print(f"   Branch: {branch}\n")

    # Create SPECS directory
    if not specs_dir.exists():
        specs_dir.mkdir()
        print("✅ Created SPECS/ directory")
    else:
        print("ℹ️  SPECS/ directory already exists")

    # Create README.md
    readme_path = specs_dir / "README.md"
    if readme_path.exists() and not args.force:
        print("⚠️  SPECS/README.md already exists (use --force to overwrite)")
    else:
        readme_path.write_text(create_readme_template(project_name))
        action = "Overwrote" if readme_path.exists() else "Created"
        print(f"✅ {action} SPECS/README.md")

    # Create PROGRESS.md
    progress_path = specs_dir / "PROGRESS.md"
    if progress_path.exists() and not args.force:
        print("⚠️  SPECS/PROGRESS.md already exists (use --force to overwrite)")
    else:
        progress_path.write_text(create_progress_template(project_name, branch))
        action = "Overwrote" if progress_path.exists() else "Created"
        print(f"✅ {action} SPECS/PROGRESS.md")

    print("\n✅ BTB workflow initialized successfully!")
    print("\nNext steps:")
    print("1. Review and customize SPECS/README.md")
    print("2. Update SPECS/PROGRESS.md with current project status")
    print("3. Add design documents (DESIGN.md or MVP.md) as needed")
    print("4. Update PROGRESS.md before each commit")
    print("\nBTB Rule: PROGRESS.md must be updated before every commit!")


if __name__ == "__main__":
    main()
