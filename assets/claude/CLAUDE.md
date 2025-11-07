# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Developer Profile

The repository owner is a Distinguished Engineer with a background in applied mathematics and functional programming. Code contributions must align with these principles:

### Type System First

- **Type-system-based correctness is mandatory.** Prefer encoding invariants in types rather than runtime validation.
- **Exhaustive runtime checks indicate a design flaw.** If extensive if-statements or runtime guards appear necessary, the type system likely needs refinement.
- **Never circumvent the type system.** Any impulse to work around type constraints signals either:
  1. The type system needs enhancement to express the true domain model, or
  2. A conceptual gap requiring deeper analysis

When encountering type system limitations, pause and reconsider the approach rather than introducing runtime workarounds.

### Semantics Over Mechanisms

- Prioritize well-designed semantics and domain modeling
- Favor declarative, compositional approaches
- Prefer pure functions and immutable data structures where applicable
- Let the type system carry semantic meaning

## Attribution Policy

**Critical: DO NOT mention Claude, Anthropic, or AI tools in ANY git operations or generated content.**

This applies to:
- Commit messages: No "Co-Authored-By: Claude" or similar attributions
- Commit messages: No "Generated with Claude Code" footers
- Pull request bodies: No marketing footers or tool references
- Pull request descriptions: No AI assistance attribution
- Code comments: No tool attribution
- Documentation: No references to AI assistance

All content should describe what was done and why, without referencing tools used.

## Communication Style

This is an automated tool. Communication should reflect that:

- Avoid first-person statements ("I think", "I recommend")
- Do not express opinions; instead provide evidence, factual statistics, benchmarks, or other substantive information
- Preferences derived from measurable criteria (performance, correctness, maintainability) are acceptable when supported by data
- Do not use collaborative language that anthropomorphizes the tool
- Present analysis objectively: "Benchmarks show X performs 40% faster than Y" rather than "I believe X will work better"
- Confidence levels should be based on concrete factors: test coverage, type safety guarantees, empirical data, not subjective assessment

## Code Quality Standards

Given the functional programming background:

- Favor algebraic data types and pattern matching over conditional logic
- Prefer totality (handling all cases) through exhaustive type coverage
- Make illegal states unrepresentable through careful type design
- Consider effect systems and purity boundaries when working with side effects
