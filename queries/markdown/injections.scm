; Override nvim-treesitter's markdown injections query.
;
; nvim-treesitter's (master branch) version uses the custom directive
; (#set-lang-from-info-string!), whose handler reads match[id] as a single
; TSNode. Neovim 0.12 changed query matches to a LIST of nodes per capture, so
; that handler calls :range() on a table and crashes highlighting/previews with
;   "attempt to call method 'range' (a nil value)"
;
; This mirrors Neovim's own bundled query, capturing the fence language directly
; as @injection.language (no custom directive), which is 0.12-compatible.

(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
