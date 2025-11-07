# UV Commands Reference

Comprehensive reference for `uv` commands and usage patterns.

## Project Management

### Initialization

```bash
# Create a new project with structure
uv init my-project

# Initialize in existing directory
uv init

# Initialize with specific Python version
echo "3.12" > .python-version
uv init
```

### Dependency Installation

```bash
# Install dependencies from pyproject.toml
uv sync

# Install with all optional groups
uv sync --all-extras

# Install without development dependencies
uv sync --no-dev

# Force reinstall all dependencies
uv sync --reinstall
```

## Dependency Management

### Adding Dependencies

```bash
# Add runtime dependency
uv add requests

# Add multiple dependencies
uv add requests httpx pydantic

# Add with version constraint
uv add "fastapi>=0.100.0"
uv add "django>=4.0,<5.0"

# Add development dependency
uv add --dev pytest ruff mypy

# Add optional dependency to specific group
uv add --optional docs sphinx sphinx-rtd-theme
```

### Removing Dependencies

```bash
# Remove a dependency
uv remove requests

# Remove development dependency
uv remove --dev pytest
```

### Updating Dependencies

```bash
# Update all dependencies
uv lock --upgrade

# Update specific package
uv lock --upgrade-package requests

# Update and sync
uv lock --upgrade && uv sync
```

## Running Commands

### Execute with Project Environment

```bash
# Run Python script
uv run python script.py

# Run module
uv run -m module_name

# Run with arguments
uv run python script.py --arg value
```

### Development Tools

```bash
# Testing
uv run pytest
uv run pytest tests/
uv run pytest -v -k test_name

# Linting
uv run ruff check
uv run ruff check --fix
uv run ruff check src/

# Formatting
uv run ruff format
uv run ruff format src/

# Type checking
uv run mypy src/
```

### One-off Tool Execution (uvx)

```bash
# Run tool without installing
uvx ruff check .
uvx mypy src/
uvx pytest

# Run specific version
uvx ruff@0.1.0 check

# Run from git
uvx --from git+https://github.com/user/tool tool-command
```

## Lock File Management

```bash
# Generate/update lock file
uv lock

# Update all dependencies
uv lock --upgrade

# Update specific package
uv lock --upgrade-package package-name

# Check if lock file is up to date
uv lock --check
```

## Virtual Environment Management

```bash
# Create virtual environment
uv venv

# Create with specific Python version
uv venv --python 3.12

# Remove and recreate
rm -rf .venv && uv venv && uv sync
```

## Package Information

```bash
# Show dependency tree
uv pip tree

# Show installed packages
uv pip list

# Show package information
uv pip show package-name

# Check for outdated packages
uv pip list --outdated
```

## Building and Publishing

```bash
# Build package
uv build

# Build wheel only
uv build --wheel

# Build source distribution only
uv build --sdist

# Publish to PyPI
uv publish

# Publish to test PyPI
uv publish --publish-url https://test.pypi.org/legacy/
```

## Cache Management

```bash
# Clear all cache
uv cache clean

# Clear cache for specific package
uv cache clean package-name

# Show cache directory
uv cache dir
```

## Python Version Management

```bash
# List available Python versions
uv python list

# Install specific Python version
uv python install 3.12

# Install multiple versions
uv python install 3.11 3.12

# Find installed Python versions
uv python find
```

## Workspace/Monorepo Commands

```bash
# Sync all workspace members
uv sync

# Run command in workspace root
uv run pytest

# Build all workspace packages
uv build --all

# Add dependency to workspace member
cd packages/mylib && uv add requests
```

## Advanced Usage

### Environment Variables

```bash
# Use specific Python version
UV_PYTHON=3.12 uv sync

# Custom cache directory
UV_CACHE_DIR=/custom/cache uv sync

# Offline mode
UV_OFFLINE=1 uv sync
```

### Configuration

```bash
# Show configuration
uv config show

# Set configuration value
uv config set key value

# Unset configuration value
uv config unset key
```

## Common Workflows

### New Project Setup

```bash
uv init my-project
cd my-project
echo "3.12" > .python-version
uv add --dev pytest ruff mypy pre-commit
uv run pre-commit install
git init
```

### Update All Dependencies

```bash
uv lock --upgrade
uv sync
uv run pytest  # Verify tests still pass
```

### Clean Slate

```bash
rm -rf .venv uv.lock
uv sync
```

### Add Git Dependency

Edit `pyproject.toml`:
```toml
[tool.uv.sources]
mylib = { git = "https://github.com/user/mylib", branch = "main" }
```

Then:
```bash
uv add mylib
```

### Platform-Specific Dependencies

In `pyproject.toml`:
```toml
[project]
dependencies = [
    "jax; sys_platform == 'darwin'",
    "jax[cuda]; sys_platform == 'linux'",
]
```

## Performance Tips

- Use `uv sync` instead of `uv pip install` for better performance
- Keep `uv.lock` committed for reproducible builds
- Use `uvx` for one-off commands instead of global installs
- Run `uv cache clean` periodically to free up disk space
- Use `uv run` instead of activating virtual environment manually

## Troubleshooting

### Dependency Resolution Failures

```bash
# Try with different resolver strategy
uv sync --resolution lowest

# Check for conflicts
uv lock --check
```

### Environment Issues

```bash
# Recreate environment
rm -rf .venv
uv sync

# Clear cache and retry
uv cache clean
uv sync
```

### Version Conflicts

```bash
# See what's installed
uv pip list

# Check dependency tree
uv pip tree

# Force specific version
uv add "package==1.2.3" --upgrade
```
