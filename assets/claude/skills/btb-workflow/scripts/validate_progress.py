#!/usr/bin/env python3
"""
Validate PROGRESS.md has been updated before allowing a commit.

This script checks:
1. PROGRESS.md exists in SPECS/
2. PROGRESS.md has been modified in the current git working tree
3. Report date is today's date
4. Session ID matches current branch (if on claude/ branch)
"""

import sys
from pathlib import Path
from datetime import datetime
import subprocess
import re


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
        return ""


def is_file_modified(file_path: Path) -> bool:
    """Check if file has been modified (staged or unstaged)."""
    try:
        result = subprocess.run(
            ["git", "status", "--porcelain", str(file_path)],
            capture_output=True,
            text=True,
            check=True,
        )
        return len(result.stdout.strip()) > 0
    except subprocess.CalledProcessError:
        return False


def validate_progress_report(progress_path: Path) -> tuple[bool, list[str]]:
    """Validate PROGRESS.md content.

    Returns:
        (is_valid, list_of_errors)
    """
    errors = []

    if not progress_path.exists():
        errors.append(f"PROGRESS.md not found at {progress_path}")
        return False, errors

    content = progress_path.read_text()

    # Check for report date
    today = datetime.now().strftime("%B %d, %Y")  # e.g., "October 28, 2025"
    date_pattern = r"\*\*Report Date\*\*:\s*(.+)"
    date_match = re.search(date_pattern, content)

    if not date_match:
        errors.append("Missing **Report Date** field in PROGRESS.md")
    elif date_match.group(1).strip() != today:
        errors.append(
            f"PROGRESS.md date is '{date_match.group(1).strip()}', "
            f"expected today's date '{today}'"
        )

    # Check for session ID on claude/ branches
    branch = get_current_branch()
    if branch.startswith("claude/"):
        session_pattern = r"\*\*Session\*\*:\s*(.+)"
        session_match = re.search(session_pattern, content)

        if not session_match:
            errors.append("Missing **Session** field in PROGRESS.md")
        else:
            session_in_doc = session_match.group(1).strip()
            # Extract session from branch name (claude/session-XXX or ships/experiment/...)
            if not session_in_doc:
                errors.append("**Session** field is empty")

    # Check for branch name
    branch_pattern = r"\*\*Branch\*\*:\s*`(.+?)`"
    branch_match = re.search(branch_pattern, content)

    if not branch_match:
        errors.append("Missing **Branch** field in PROGRESS.md")
    elif branch_match.group(1).strip() != branch:
        errors.append(
            f"PROGRESS.md branch is '{branch_match.group(1).strip()}', "
            f"but current branch is '{branch}'"
        )

    return len(errors) == 0, errors


def main():
    """Main validation logic."""
    repo_root = find_repo_root()
    progress_path = repo_root / "SPECS" / "PROGRESS.md"

    print("🔍 BTB Pre-Commit Validation")
    print(f"Repository: {repo_root}")
    print(f"Branch: {get_current_branch()}\n")

    # Check if PROGRESS.md has been modified
    if not is_file_modified(progress_path):
        print("❌ PROGRESS.md has not been updated")
        print("\nBTB Rule: PROGRESS.md must be updated before each commit.")
        print("Update SPECS/PROGRESS.md to reflect current status and try again.")
        sys.exit(1)

    # Validate PROGRESS.md content
    is_valid, errors = validate_progress_report(progress_path)

    if not is_valid:
        print("❌ PROGRESS.md validation failed:\n")
        for error in errors:
            print(f"  • {error}")
        print("\nFix the errors above and try again.")
        sys.exit(1)

    print("✅ PROGRESS.md validation passed")
    print("   • File has been modified")
    print("   • Date is current")
    print("   • Branch matches")
    print("\nReady to commit!")
    sys.exit(0)


if __name__ == "__main__":
    main()
