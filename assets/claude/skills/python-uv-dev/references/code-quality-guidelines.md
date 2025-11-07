# Code Quality and Refactoring Guidelines

Guidelines for maintaining high code quality in Python projects using `uv`.

## Tool Execution

This package is managed using `uv`.

Development tools defined in `pyproject.toml` must be executed as subcommand of
`uv run`. For example:

- Use `uv run ruff check file.py` instead of `ruff check file.py`
- Use `uv run pytest` instead of `pytest`

This ensures the project's defined tool versions are used rather than any
globally installed ones.

## Code Quality and Refactoring

When implementing new features or fixing issues, prioritize clean architecture and maintainable solutions:

### Architecture Over Implementation
- **Look for reusable components** instead of duplicating logic across modules
- **Extract shared functionality** into common utilities rather than copy-pasting
- **Consider the broader codebase** - how can this change improve the overall system?

### Use Library-Provided Types
- **Prefer proper library types** over generic dictionaries for better type safety
- **Use existing SDK types** (e.g., `anthropic.types.ToolParam`) instead of manual mapping
- **Leverage type annotations** to catch errors early and improve IDE support

### Refactor Existing Code
- **When solving problems, improve the broader codebase architecture** - don't just add new code
- **Update related functions** to use new shared components
- **Add proper exports** (`__all__`) to maintain clean public APIs

### Commitment to the Change
- **Accept the consequences of a good change** after thinking it through thoroughly - upgrade and remove old code paths rather than leaving them in hybrid states
- **Make changes completely from a former pattern to the new pattern** - don't add complexity to handle backward compatible cases for logic we are removing
- **Add information, not complications** - choose a new pattern that solves the known usages with powerful concepts
- **Sacrifice unnecessary code** - Take every opportunity to remove leftover content and extraneous code

### DRY Principle Applied Correctly
- **Identify duplicate functionality** across modules and consolidate it
- **Create single sources of truth** for shared data structures and configurations
- **Ensure changes only need to happen in one place**

### Keep Related Code Together
- **Group related functionality** in logical modules to maintain cohesion
- **Co-locate functions** that work with the same data structures
- **Organize imports** to reflect module relationships

### Prefer Simple Solutions
- **Use inline comprehensions** over separate functions when transformation is simple
- **Avoid over-engineering** - sometimes the straightforward approach is best
- **Thinking aloud, double-check all branching logic** for necessity: most of the time, branching logic is a sign of unnecessary complication
- **Question complexity** - can this be done more simply?

### Always Aim to Be Correct Rather Than Defensive

- **Be scientific and exact in pursuing resolutions to issues** - when you have an idea of a root cause to a problem, think out loud what other ramifications of that hypothesis would be, and validate it in a principled fashion before committing to a fix
- **Fail fast, don't use fallbacks** - If no model is present or assumptions aren't met, the system should fail immediately with a clear error rather than trying fallback options
- **Never use hasattr** - Instead of checking if an attribute exists, look up the correct API and write code that's intended to work with the known interface
- **Avoid spurious try/catch** - Don't wrap code in try/catch blocks defensively. Write code that's intended to work correctly, and only catch specific, expected exceptions when there's a clear recovery strategy
- **Look up APIs instead of guessing** - When you need to use a method or property, research the actual API documentation or ask for clarification rather than assuming the method exists
- **Write declarative, production-ready code** - Code should be clear about its intentions and assumptions, mature in its error handling, and ready for production use
- **Don't break existing functionality** - When refactoring, ensure that the system continues to work for users who are actively using it

## Style

### No Sycophancy
- **Provide technical analysis only** - Simply provide technical analysis unless requested for an opinion explicitly
- **No verbal agreement or disagreement** - Do not agree or disagree verbally with instructions/commands
- **Ask for clarification when needed** - If the instruction is likely to be ill-considered, ask for clarification rather than assuming
