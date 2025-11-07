# Pre-Commit Hygiene Checklist

This checklist defines code and documentation hygiene standards for commits. Apply these checks to all files in the current changeset.

## Code Hygiene

### Debug Statements
**Remove** debug/logging statements added during development:
- JavaScript/TypeScript: `console.log()`, `console.debug()`, `debugger`
- Python: `print()` statements (unless part of CLI/script output)
- Ruby: `puts`, `p`, `pp` (debug usage)
- Java: `System.out.println()` (debug usage)
- Go: `fmt.Println()` (debug usage)

**Keep** intentional logging:
- Production logging (logger.info, logger.error, etc.)
- CLI output that's part of the interface
- Test output assertions

### Commented Code
**Remove** commented-out code blocks:
```python
# Old implementation - no longer needed
# def old_function():
#     return "deprecated"
```

**Keep** explanatory comments that add value:
```python
# Use binary search here because dataset can exceed 10M records
# Linear search would timeout on production workloads
```

### Temporary Comments
**Remove** temporal TODO/FIXME comments:
- ❌ `# TODO: Fix this after the refactor`
- ❌ `// FIXME: Temporary hack for the new API`
- ❌ `# NOTE: This is for the current sprint`

**Keep** or **convert to issues**:
- ✓ `// TODO: Implement caching (tracked in PERF-123)`
- ✓ `# FIXME: Race condition in concurrent writes (Issue #456)`
- Better: Create issue, remove comment

### Temporal Language
**Remove** time-relative references in code comments:
- ❌ "This is the new authentication system"
- ❌ "Updated from the old implementation"
- ❌ "Current API version"
- ❌ "Recently added feature"

**Rewrite** to be timeless:
- ✓ "OAuth2-based authentication system"
- ✓ "Replaces password-only auth"
- ✓ "API v2"
- ✓ "Supports feature X"

### Test Artifacts
**Remove** temporary test files/data (if not gitignored):
- Test databases, fixtures created during development
- Temporary output files from test runs
- Debug screenshots or logs
- Local-only test configurations

**Keep** intentional test fixtures:
- Committed test data in `fixtures/` or `test/data/`
- Snapshot files for snapshot testing
- Reference outputs for comparison tests

### Dead Code
**Remove** unreachable or unused code:
- Unused imports
- Unused variables/functions
- Unreachable branches
- Code protected by permanent `if false` conditions

## Documentation Hygiene

### Reference Documentation
**Remove** reference docs created during exploration unless:
- Part of an intentional multi-stage workflow
- Core architectural documentation (ADRs, design docs)
- Public API documentation
- Team onboarding materials

**Common culprits to remove:**
- "Notes on implementation.md" created during debugging
- "API research.md" from spike work
- Temporary meeting notes or brainstorming docs

### README Updates
**Verify** README accuracy:
- Installation instructions still correct?
- API examples still work?
- Feature list reflects current state?
- Links not broken?

**Remove** temporal language:
- ❌ "Recently added feature X"
- ❌ "New in this version"
- ❌ "Coming soon: feature Y"

### Code Comments
**Evaluate** comment quality:
- Does it explain *why* not *what*?
- Would a staff engineer find it insightful?
- Does it add non-obvious context?

**Remove** obvious comments:
```python
# Bad: Obvious
# Increment the counter
counter += 1

# Good: Adds context
# Counter tracks API retries; max 3 prevents infinite loops
counter += 1
```

## Process Hygiene

### Scope Boundary
- ✓ **Apply hygiene to**: Files in the current changeset
- ✓ **Note but don't fix**: Extensive hygiene issues outside changeset
- ✓ **Communicate**: "Noticed hygiene issues in X, Y, Z - recommend cleanup as separate task"

### Test Requirements
**Before commit**, run full test suite:
1. Unit tests
2. Integration tests
3. E2E tests (if applicable)

**If tests fail**:
- ❌ Do NOT remove tests to make green
- ❌ Do NOT skip failing tests
- ✓ Fix the failures
- ✓ Ask permission to proceed if WIP state justifies partial failures

**If tests don't exist**:
- Note the gap but don't block commit
- Consider adding tests if trivial

## Examples

### Before Hygiene Pass

```python
# New user authentication module
# TODO: Add rate limiting later

import os
import sys
import logging  # unused

def authenticate(username, password):
    # Debug the auth flow
    print(f"Authenticating {username}")

    # Old implementation - keeping for reference
    # if username == "admin":
    #     return True

    # This is the new OAuth implementation
    result = oauth.verify(username, password)
    print(f"Result: {result}")  # debug
    return result
```

### After Hygiene Pass

```python
"""OAuth2-based authentication module.

Replaces password-only auth with token-based system.
Rate limiting handled by API gateway upstream.
"""

import logging

def authenticate(username, password):
    """Verify credentials via OAuth2 provider.

    Returns token on success, raises AuthError on failure.
    """
    return oauth.verify(username, password)
```

## Hygiene Workflow

1. **Read** entire changeset
2. **Identify** hygiene issues using checklist
3. **Fix** issues in changed files
4. **Note** issues outside scope for future cleanup
5. **Run** test suite
6. **Verify** tests pass
7. **Proceed** with commit
