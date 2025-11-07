#!/usr/bin/env python3
"""Initialize a new uv project with best practices.

This script initializes a new Python project using uv with:
- Basic project structure
- Development dependencies (pytest, ruff, mypy, pre-commit)
- Pre-commit hooks configured
- Git repository initialized
- Python version specified
"""

import argparse
import subprocess
import sys
from pathlib import Path


def run_command(cmd: list[str], cwd: Path | None = None, check: bool = True) -> subprocess.CompletedProcess:
    """Run a command and return the result."""
    print(f"Running: {' '.join(cmd)}")
    return subprocess.run(cmd, cwd=cwd, check=check, capture_output=True, text=True)


def init_project(project_name: str, python_version: str = "3.12", with_git: bool = True) -> None:
    """Initialize a new uv project with best practices."""
    project_path = Path(project_name)

    # Initialize uv project
    print(f"\nInitializing uv project: {project_name}")
    run_command(["uv", "init", project_name])

    # Set Python version
    print(f"\nSetting Python version to {python_version}")
    version_file = project_path / ".python-version"
    version_file.write_text(f"{python_version}\n")

    # Add development dependencies
    print("\nAdding development dependencies...")
    dev_deps = ["pytest", "pytest-cov", "ruff", "mypy", "pre-commit"]
    run_command(["uv", "add", "--dev"] + dev_deps, cwd=project_path)

    # Initialize git if requested
    if with_git:
        print("\nInitializing git repository...")
        run_command(["git", "init"], cwd=project_path)

        # Create .gitignore
        gitignore = project_path / ".gitignore"
        gitignore.write_text("""# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual environments
.venv
venv/
ENV/
env/

# Testing
.coverage
.pytest_cache/
htmlcov/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# UV
uv.lock
""")

    # Copy pre-commit config template
    print("\nSetting up pre-commit hooks...")
    precommit_config = project_path / ".pre-commit-config.yaml"
    precommit_config.write_text("""repos:
  - repo: local
    hooks:
      - id: ruff-import-sorting
        name: ruff import sorting (I)
        entry: uv run ruff check --select I --fix
        language: system
        types_or: [python]

      - id: ruff-lint
        name: ruff lint
        entry: uv run ruff check --fix
        language: system
        types_or: [python]

      - id: ruff-format
        name: ruff format
        entry: uv run ruff format
        language: system
        types_or: [python]

      - id: pytest
        name: pytest
        entry: uv run pytest
        language: system
        pass_filenames: false
        stages: [pre-push]
""")

    # Install pre-commit hooks
    run_command(["uv", "run", "pre-commit", "install", "--hook-type", "pre-commit", "--hook-type", "pre-push"], cwd=project_path)

    # Create basic test directory
    tests_dir = project_path / "tests"
    tests_dir.mkdir(exist_ok=True)
    (tests_dir / "__init__.py").touch()

    # Create a basic test file
    test_file = tests_dir / "test_example.py"
    test_file.write_text("""def test_example():
    \"\"\"Example test.\"\"\"
    assert True
""")

    print(f"\n✅ Project {project_name} initialized successfully!")
    print(f"\nNext steps:")
    print(f"  cd {project_name}")
    print(f"  uv add <dependencies>")
    print(f"  uv run pytest")


def main():
    parser = argparse.ArgumentParser(description="Initialize a new uv project with best practices")
    parser.add_argument("project_name", help="Name of the project to create")
    parser.add_argument("--python-version", default="3.12", help="Python version to use (default: 3.12)")
    parser.add_argument("--no-git", action="store_true", help="Don't initialize git repository")

    args = parser.parse_args()

    try:
        init_project(args.project_name, args.python_version, not args.no_git)
    except subprocess.CalledProcessError as e:
        print(f"\n❌ Error: Command failed: {e.cmd}", file=sys.stderr)
        print(f"Output: {e.stdout}", file=sys.stderr)
        print(f"Error: {e.stderr}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
