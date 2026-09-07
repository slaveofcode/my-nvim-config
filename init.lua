-- Silence deprecation notices emitted by pinned plugins (e.g. lsp-zero calling
-- vim.lsp.with() on Neovim 0.12). These are plugin-internal, not our config;
-- run ":checkhealth vim.deprecated" any time to see the full list.
vim.deprecate = function() end

require("kresna.basic")
require("kresna.lazy")
