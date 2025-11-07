#!/usr/bin/env python3
"""
Display BTB workflow status for the current repository.

Shows:
- Current phase/status from PROGRESS.md
- Document coverage (which BTB documents exist)
- Recent commits by author type (HUMAN vs Claude)
- Next recommended actions
"""

import sys
from pathlib import Path
import subprocess
import re
from datetime import datetime


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
        return "unknown"


def get_recent_commits(limit: int = 10) -> list[dict]:
    """Get recent commits with author and message."""
    try:
        result = subprocess.run(
            ["git", "log", f"-{limit}", "--format=%h|%an|%s"],
            capture_output=True,
            text=True,
            check=True,
        )
        commits = []
        for line in result.stdout.strip().split("\n"):
            if "|" in line:
                hash_, author, message = line.split("|", 2)
                commits.append({"hash": hash_, "author": author, "message": message})
        return commits
    except subprocess.CalledProcessError:
        return []


def extract_phase_from_progress(content: str) -> str:
    """Extract current phase from PROGRESS.md."""
    phase_pattern = r"\*\*Current Phase\*\*:\s*(.+)"
    match = re.search(phase_pattern, content)
    if match:
        return match.group(1).strip()
    return "Unknown"


def extract_date_from_progress(content: str) -> str:
    """Extract report date from PROGRESS.md."""
    date_pattern = r"\*\*Report Date\*\*:\s*(.+)"
    match = re.search(date_pattern, content)
    if match:
        return match.group(1).strip()
    return "Unknown"


def check_documents(specs_dir: Path) -> dict[str, bool]:
    """Check which BTB documents exist."""
    return {
        "README.md": (specs_dir / "README.md").exists(),
        "PROGRESS.md": (specs_dir / "PROGRESS.md").exists(),
        "DESIGN": any(specs_dir.glob("*Design*.md"))
        or any(specs_dir.glob("*DESIGN*.md")),
        "MVP": any(specs_dir.glob("MVP*.md")) or any(specs_dir.glob("mvp*.md")),
    }


def main():
    """Display BTB status."""
    repo_root = find_repo_root()
    specs_dir = repo_root / "SPECS"
    branch = get_current_branch()

    print("📊 BTB Workflow Status")
    print("=" * 60)

    # Repository info
    print(f"\n📁 Repository: {repo_root.name}")
    print(f"🌿 Branch: {branch}")

    # Document coverage
    print("\n📚 Documentation Coverage:")
    if not specs_dir.exists():
        print("   ❌ SPECS/ directory not found")
        print("\n💡 Recommendation: Initialize BTB workflow")
        print("   Create SPECS/ directory and add README.md as entrypoint")
        sys.exit(0)

    docs = check_documents(specs_dir)
    for doc_name, exists in docs.items():
        status = "✅" if exists else "❌"
        print(f"   {status} {doc_name}")

    # Progress report info
    progress_path = specs_dir / "PROGRESS.md"
    if progress_path.exists():
        content = progress_path.read_text()
        phase = extract_phase_from_progress(content)
        date = extract_date_from_progress(content)

        print(f"\n📈 Current Status:")
        print(f"   Phase: {phase}")
        print(f"   Last Updated: {date}")

        # Check if update needed
        today = datetime.now().strftime("%B %d, %Y")
        if date != today:
            print(f"   ⚠️  PROGRESS.md needs update (today is {today})")

    # Recent commit analysis
    print("\n📝 Recent Commit History:")
    commits = get_recent_commits(10)

    human_commits = [c for c in commits if "HUMAN" in c["message"]]
    claude_commits = [c for c in commits if c["author"] == "Claude"]
    other_commits = [
        c for c in commits if c not in human_commits and c not in claude_commits
    ]

    print(f"   HUMAN commits: {len(human_commits)} (design/requirements)")
    print(f"   Claude commits: {len(claude_commits)} (implementation)")
    print(f"   Other commits: {len(other_commits)}")

    if commits:
        print("\n   Last 5 commits:")
        for commit in commits[:5]:
            author_type = (
                "👤 HUMAN"
                if "HUMAN" in commit["message"]
                else "🤖 Claude" if commit["author"] == "Claude" else "👥 Other"
            )
            print(f"   {commit['hash']} {author_type}: {commit['message'][:60]}")

    # Recommendations
    print("\n💡 Recommendations:")

    if not docs["README.md"]:
        print("   1. Create SPECS/README.md as navigation entrypoint")
    if not docs["PROGRESS.md"]:
        print("   2. Create SPECS/PROGRESS.md to track implementation status")
    if not docs["DESIGN"] and not docs["MVP"]:
        print("   3. Add DESIGN document or MVP specification")

    if all([docs["README.md"], docs["PROGRESS.md"]]):
        print("   ✅ Core BTB structure is in place")
        if progress_path.exists():
            content = progress_path.read_text()
            date = extract_date_from_progress(content)
            today = datetime.now().strftime("%B %d, %Y")
            if date != today:
                print("   ⚠️  Update PROGRESS.md before next commit")

    print("\n" + "=" * 60)


if __name__ == "__main__":
    main()
