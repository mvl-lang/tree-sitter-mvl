# tree-sitter-mvl Changelog

## [Unreleased]

## [0.1.3] — 2026-07-22

### Fixed

- **Qualified constructor patterns** — `Enum::Variant(payload)`,
  `Enum::Variant { field: p, ... }`, and bare `Enum::Variant` (no
  payload) now parse.  `constructor_pattern` / `struct_pattern` accept
  a one- or two-segment head; a new `path_pattern` node covers the
  standalone bare-variant form.  Previously the grammar restricted the
  head to a single `IDENT`, throwing every `match` on qualified
  variants into an `ERROR` recovery cascade that broke highlighting for
  the rest of the file.
- **Method-call precedence inside match-arm expressions** — bumped the
  method-call branch of `expr` one precedence level above field-access
  so GLR prefers `foo.bar(...)` over `foo.bar` followed by an outer
  `(...)`.  Prior behaviour let a trailing `.concat(y)` in a match arm
  be misparsed as `field_access + tuple_pattern`, breaking arm parsing.
- **Struct construction / struct patterns** now accept an optional
  trailing comma after the last field, matching the compiler.

### Added

- Corpus tests covering: qualified constructor patterns, nested
  constructor patterns, method-call chains in match-arm RHS, and
  struct construction without a trailing comma.

## [0.1.0] — 2026-07-13

Initial release. Migrated from `mvl-lang/mvl/etc/tree-sitter-mvl/`.

### Added

- Full `grammar.js` derived from `grammar/grammar.ebnf`
- Highlight queries (`queries/highlights.scm`) covering keywords, totality modifiers, security modifiers, capability annotations, security labels, built-in generics, effects, and special forms
- Fold queries (`queries/folds.scm`)
- Test corpus (`test/corpus/`)
- Published under package name `tree-sitter-mvl` (npm)

### Compatibility

Tracks **mvl-spec >= 0.1.0, < 0.5.0**.

---

[Unreleased]: https://github.com/mvl-lang/mvl-spec/compare/tree-sitter-v0.1.0...HEAD
[0.1.0]: https://github.com/mvl-lang/mvl-spec/releases/tag/tree-sitter-v0.1.0
