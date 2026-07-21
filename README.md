# tree-sitter-mvl

[Tree-sitter](https://tree-sitter.github.io) grammar for **MVL** (Minimum Verification Language) — a Rust-family refinement-typed language with compile-time verification of eleven safety-critical requirements.

- **Language surface:** LL(1), ~15 features contracted from Rust + Koka + Liquid Haskell + Pony.
- **MVL project:** [`mvl-lang/mvl`](https://github.com/mvl-lang/mvl) (compiler), [`mvl-lang/mvl-spec`](https://github.com/mvl-lang/mvl-spec) (formal spec, EBNF grammar).
- **Bindings:** Node.js, Rust, Python, Swift.
- **License:** Apache-2.0.

## Status

- Grammar version: 0.1.0
- Test corpus: 38 parses across 6 categories (literals, types, expressions, statements, declarations, full programs), 100% passing.
- Editor extensions using this grammar:
  - **Zed** — [`mvl-spec/editors/zed`](https://github.com/mvl-lang/mvl-spec/tree/main/editors/zed)
  - **VS Code** — [`mvl-spec/editors/vscode`](https://github.com/mvl-lang/mvl-spec/tree/main/editors/vscode)
  - **Neovim** — [`mvl-spec/editors/nvim`](https://github.com/mvl-lang/mvl-spec/tree/main/editors/nvim)

## Development

```bash
# Regenerate parser after editing grammar.js
tree-sitter generate

# Run the corpus tests
tree-sitter test

# Parse a single MVL file
tree-sitter parse path/to/file.mvl

# Highlight a file with the queries/ directory rules
tree-sitter highlight path/to/file.mvl
```

## Grammar structure

`grammar.js` sits at the repository root. Derived from the EBNF specification at [`mvl-spec/grammar/grammar.ebnf`](https://github.com/mvl-lang/mvl-spec/blob/main/grammar/grammar.ebnf); LL(1) with no parsing ambiguities.

**Precedence levels** (higher number = tighter binding):

| Level | Category | Operators |
|---|---|---|
| 1  | OR       | `\|\|` |
| 2  | AND      | `&&` |
| 3  | BITOR    | `\|` |
| 4  | BITXOR   | `^` |
| 5  | BITAND   | `&` (binary) |
| 6  | COMPARE  | `==` `!=` `<` `>` `<=` `>=` |
| 7  | SHIFT    | `<<` `>>` |
| 8  | ADD      | `+` `-` |
| 9  | MUL      | `*` `/` `%` |
| 10 | UNARY    | `!` `~` `-` `move` `consume` (right-assoc) |
| 11 | CALL     | `.` `()` (left-assoc — method/field access) |

**Ambiguity notes.** `<` only appears in type position in MVL. To avoid the classic generic-vs-comparison ambiguity for the syntax highlighter, explicit type args at call sites are parsed via separate `_typed_call` forms rather than `identifier < type_list > ( args )`.

## Query files

Under `queries/`:

- `highlights.scm` — syntax highlighting rules.
- `indents.scm` — indentation rules.
- `locals.scm` — local variable resolution.

## Relationship to `mvl-spec`

`mvl-spec` contains the canonical EBNF grammar at `grammar/grammar.ebnf`. This repository contains the tree-sitter implementation of that grammar. When the EBNF changes, `grammar.js` here is updated to match; the corpus tests are the ground truth that both stay aligned.

Tree-sitter grammars need to sit at the root of their own repository for downstream tools (Zed, GitHub Linguist, Neovim, VS Code) to consume them cleanly. That is why this grammar lives as its own repo rather than as a subdirectory of `mvl-spec/tools/`.

## Publish path

- **npm.** `tree-sitter-mvl` package. Not yet published; run `tree-sitter build` before `npm publish`.
- **crates.io.** `tree-sitter-mvl` Rust crate. Not yet published.
- **PyPI.** `tree-sitter-mvl` Python package. Not yet published.

## Contributing

Edit `grammar.js`, run `tree-sitter generate`, run `tree-sitter test`, add corpus entries under `test/corpus/` for any new syntax. PRs against `main`.

---

Part of the MVL project. See [`mvl-lang/mvl`](https://github.com/mvl-lang/mvl) for the compiler and language reference.
