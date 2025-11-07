# Pyproject.toml Patterns

Common patterns and configurations for `pyproject.toml` in `uv` projects.

## Basic Project Structure

```toml
[project]
name = "my-package"
version = "0.1.0"
description = "A short description"
authors = [
    {name = "Your Name", email = "you@example.com"},
]
readme = "README.md"
requires-python = ">=3.12"
dependencies = [
    "requests>=2.31.0",
    "pydantic>=2.0.0",
]

[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "ruff>=0.8.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

## Dependency Groups (Modern Syntax)

Use `[dependency-groups]` instead of `[project.optional-dependencies]`:

```toml
[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "pytest-cov>=5.0.0",
    "ruff>=0.8.0",
    "mypy>=1.0.0",
]

test = [
    "pytest>=8.0.0",
    "pytest-asyncio>=0.24.0",
    "pytest-xdist>=3.5.0",
]

docs = [
    "sphinx>=7.0.0",
    "sphinx-rtd-theme>=2.0.0",
]
```

## Git Dependencies

```toml
[project]
dependencies = [
    "mylib",
    "another-package",
]

[tool.uv.sources]
mylib = { git = "https://github.com/user/mylib", branch = "main" }
another-package = { git = "https://github.com/user/another", tag = "v1.0.0" }
private-repo = { git = "ssh://git@github.com/org/private", branch = "develop" }
```

## Workspace/Monorepo Configuration

**Root pyproject.toml:**
```toml
[project]
name = "my-monorepo"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "shared-lib",
    "api-client",
]

[tool.uv.workspace]
members = [
    "packages/*",
]

[tool.uv.sources]
shared-lib = { workspace = true }
api-client = { workspace = true }
external-dep = { git = "https://github.com/user/repo", branch = "main" }

[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "ruff>=0.8.0",
]
```

**Package pyproject.toml (packages/shared-lib/pyproject.toml):**
```toml
[project]
name = "shared-lib"
version = "0.1.0"
dependencies = [
    "pydantic>=2.0.0",
]

[tool.uv.sources]
# Can reference other workspace packages
api-client = { workspace = true }
```

## Platform-Specific Dependencies

```toml
[project]
dependencies = [
    # macOS gets standard jax
    "jax; sys_platform == 'darwin'",

    # Linux gets CUDA-enabled jax
    "jax[cuda]; sys_platform == 'linux'",

    # Windows-specific package
    "pywin32; sys_platform == 'win32'",

    # Python version specific
    "tomli; python_version < '3.11'",
]
```

## Script Entrypoints

```toml
[project.scripts]
my-cli = "mypackage.cli:main"
process-data = "mypackage.scripts:process_main"
admin-tool = "mypackage.admin:cli_entrypoint"
```

Usage:
```bash
uv run my-cli --help
uv run process-data input.json
```

## Ruff Configuration

```toml
[tool.ruff]
line-length = 100
target-version = "py312"
src = ["src"]

[tool.ruff.lint]
select = [
    "E",   # pycodestyle errors
    "F",   # pyflakes
    "I",   # isort
    "N",   # pep8-naming
    "W",   # pycodestyle warnings
    "UP",  # pyupgrade
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
]
ignore = [
    "E501",  # line too long (handled by formatter)
]

[tool.ruff.lint.per-file-ignores]
"tests/**/*.py" = ["S101"]  # Allow assert in tests

[tool.ruff.lint.isort]
known-first-party = ["mypackage"]
```

## Pytest Configuration

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = [
    "--strict-markers",
    "--strict-config",
    "-ra",
    "--cov=src",
    "--cov-report=term-missing",
]
markers = [
    "slow: marks tests as slow",
    "integration: marks tests as integration tests",
]
```

## Coverage Configuration

```toml
[tool.coverage.run]
source = ["src"]
branch = true
omit = [
    "*/tests/*",
    "*/__pycache__/*",
]

[tool.coverage.report]
show_missing = true
skip_covered = false
precision = 2
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
    "if __name__ == .__main__.:",
    "if TYPE_CHECKING:",
]
```

## MyPy Configuration

```toml
[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
disallow_incomplete_defs = true
check_untyped_defs = true
no_implicit_optional = true
warn_redundant_casts = true
warn_unused_ignores = true
warn_no_return = true
strict_equality = true

[[tool.mypy.overrides]]
module = "tests.*"
disallow_untyped_defs = false
```

## Build System Configurations

### Hatchling (Recommended)

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["src/mypackage"]
```

### Setuptools

```toml
[build-system]
requires = ["setuptools>=68.0.0", "wheel"]
build-backend = "setuptools.build_meta"

[tool.setuptools.packages.find]
where = ["src"]
```

### PDM-Backend

```toml
[build-system]
requires = ["pdm-backend"]
build-backend = "pdm.backend"
```

## Project Metadata

```toml
[project]
name = "my-package"
version = "0.1.0"
description = "A comprehensive description"
readme = "README.md"
requires-python = ">=3.12"
license = {text = "MIT"}
keywords = ["keyword1", "keyword2"]
authors = [
    {name = "Your Name", email = "you@example.com"},
]
maintainers = [
    {name = "Maintainer", email = "maintainer@example.com"},
]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.12",
]

[project.urls]
Homepage = "https://github.com/user/project"
Documentation = "https://project.readthedocs.io"
Repository = "https://github.com/user/project"
Changelog = "https://github.com/user/project/blob/main/CHANGELOG.md"
```

## Dynamic Versioning

```toml
[project]
name = "my-package"
dynamic = ["version"]

[tool.hatch.version]
path = "src/mypackage/__init__.py"
```

In `src/mypackage/__init__.py`:
```python
__version__ = "0.1.0"
```

## Environment-Specific Configuration

```toml
[tool.uv]
dev-dependencies = [
    "pytest>=8.0.0",
]

[tool.uv.pip]
# Use this index for all packages
index-url = "https://pypi.org/simple"

# Additional indexes
extra-index-url = [
    "https://my-private-pypi.example.com/simple",
]
```

## Complete Example: Production Project

```toml
[project]
name = "production-app"
version = "1.0.0"
description = "A production-ready Python application"
authors = [
    {name = "Team", email = "team@example.com"},
]
readme = "README.md"
requires-python = ">=3.12"
license = {text = "MIT"}
dependencies = [
    "fastapi>=0.115.0",
    "pydantic>=2.11.0",
    "pydantic-settings>=2.6.0",
    "httpx>=0.28.0",
    "jax; sys_platform == 'darwin'",
    "jax[cuda]; sys_platform == 'linux'",
]

[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "pytest-asyncio>=0.24.0",
    "pytest-cov>=5.0.0",
    "pytest-xdist>=3.5.0",
    "ruff>=0.8.0",
    "mypy>=1.0.0",
    "pre-commit>=4.0.0",
]

[project.scripts]
serve = "production_app.main:serve"
migrate = "production_app.db:migrate"

[tool.uv.sources]
internal-lib = { git = "https://github.com/org/internal-lib", branch = "main" }

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["src/production_app"]

[tool.ruff]
line-length = 100
target-version = "py312"
src = ["src"]

[tool.ruff.lint]
select = ["E", "F", "I", "N", "W", "UP", "B", "C4"]
ignore = ["E501"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = [
    "--strict-markers",
    "--strict-config",
    "-ra",
    "--cov=src",
]

[tool.coverage.run]
source = ["src"]
branch = true

[tool.coverage.report]
show_missing = true
precision = 2

[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
```
