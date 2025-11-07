#!/usr/bin/env python3
"""Validate pyproject.toml structure and configuration for uv projects.

This script checks:
- Required fields are present
- Dependency groups use modern syntax
- Build system is configured
- Common configuration issues
"""

import argparse
import sys
from pathlib import Path

try:
    import tomli
except ImportError:
    # Fallback for Python 3.11+
    import tomllib as tomli


def load_pyproject(path: Path) -> dict:
    """Load and parse pyproject.toml."""
    with open(path, "rb") as f:
        return tomli.load(f)


def validate_project_section(data: dict) -> list[str]:
    """Validate [project] section."""
    errors = []

    if "project" not in data:
        errors.append("Missing [project] section")
        return errors

    project = data["project"]
    required_fields = ["name", "version", "requires-python"]

    for field in required_fields:
        if field not in project:
            errors.append(f"Missing required field: [project].{field}")

    # Check for old-style dev dependencies
    if "optional-dependencies" in project and "dev" in project["optional-dependencies"]:
        errors.append(
            "Using deprecated [project.optional-dependencies] for dev dependencies. "
            "Use [dependency-groups] instead."
        )

    return errors


def validate_dependency_groups(data: dict) -> list[str]:
    """Validate [dependency-groups] section."""
    warnings = []

    if "dependency-groups" not in data:
        warnings.append("No [dependency-groups] section found. Consider adding dev dependencies.")
    else:
        groups = data["dependency-groups"]
        if "dev" not in groups:
            warnings.append("No 'dev' dependency group found. Consider adding pytest, ruff, etc.")

    return warnings


def validate_build_system(data: dict) -> list[str]:
    """Validate [build-system] section."""
    errors = []

    if "build-system" not in data:
        errors.append("Missing [build-system] section")
        return errors

    build_system = data["build-system"]

    if "requires" not in build_system:
        errors.append("Missing [build-system].requires")

    if "build-backend" not in build_system:
        errors.append("Missing [build-system].build-backend")

    return errors


def validate_uv_sources(data: dict) -> list[str]:
    """Validate [tool.uv.sources] section."""
    warnings = []

    if "tool" in data and "uv" in data["tool"] and "sources" in data["tool"]["uv"]:
        sources = data["tool"]["uv"]["sources"]

        # Check if project dependencies reference sources
        if "project" in data and "dependencies" in data["project"]:
            deps = data["project"]["dependencies"]
            for dep_spec in deps:
                # Extract package name (before any version specifiers)
                dep_name = dep_spec.split(";")[0].split("[")[0].split("=")[0].split(">")[0].split("<")[0].strip()

                if dep_name in sources:
                    source = sources[dep_name]
                    if isinstance(source, dict) and "git" in source and "branch" in source:
                        if source["branch"] == "main" or source["branch"] == "master":
                            warnings.append(
                                f"Git dependency '{dep_name}' uses branch '{source['branch']}'. "
                                "Consider using tags for reproducible builds."
                            )

    return warnings


def validate_ruff_config(data: dict) -> list[str]:
    """Validate ruff configuration."""
    warnings = []

    if "tool" not in data or "ruff" not in data["tool"]:
        warnings.append("No ruff configuration found. Consider adding [tool.ruff] section.")
        return warnings

    ruff = data["tool"]["ruff"]

    if "lint" in ruff and "select" in ruff["lint"]:
        select = ruff["lint"]["select"]
        recommended = {"E", "F", "I", "W"}
        missing = recommended - set(select)
        if missing:
            warnings.append(f"Ruff configuration missing recommended rules: {missing}")

    return warnings


def validate_pytest_config(data: dict) -> list[str]:
    """Validate pytest configuration."""
    warnings = []

    if "tool" not in data or "pytest" not in data["tool"]:
        # Check if pytest is in dev dependencies
        has_pytest = False
        if "dependency-groups" in data and "dev" in data["dependency-groups"]:
            has_pytest = any("pytest" in dep for dep in data["dependency-groups"]["dev"])

        if has_pytest:
            warnings.append("pytest is a dependency but no [tool.pytest.ini_options] configuration found.")

    return warnings


def validate_pyproject(path: Path) -> tuple[list[str], list[str]]:
    """Validate pyproject.toml and return errors and warnings."""
    try:
        data = load_pyproject(path)
    except Exception as e:
        return [f"Failed to parse pyproject.toml: {e}"], []

    errors = []
    warnings = []

    errors.extend(validate_project_section(data))
    errors.extend(validate_build_system(data))

    warnings.extend(validate_dependency_groups(data))
    warnings.extend(validate_uv_sources(data))
    warnings.extend(validate_ruff_config(data))
    warnings.extend(validate_pytest_config(data))

    return errors, warnings


def main():
    parser = argparse.ArgumentParser(description="Validate pyproject.toml for uv projects")
    parser.add_argument("path", nargs="?", default="pyproject.toml", help="Path to pyproject.toml (default: pyproject.toml)")
    parser.add_argument("--strict", action="store_true", help="Treat warnings as errors")

    args = parser.parse_args()
    path = Path(args.path)

    if not path.exists():
        print(f"❌ Error: {path} not found", file=sys.stderr)
        sys.exit(1)

    errors, warnings = validate_pyproject(path)

    if errors:
        print(f"\n❌ {len(errors)} error(s) found:")
        for error in errors:
            print(f"  - {error}")

    if warnings:
        print(f"\n⚠️  {len(warnings)} warning(s):")
        for warning in warnings:
            print(f"  - {warning}")

    if not errors and not warnings:
        print("✅ pyproject.toml is valid!")
        sys.exit(0)
    elif errors or (args.strict and warnings):
        sys.exit(1)
    else:
        sys.exit(0)


if __name__ == "__main__":
    main()
