return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = { enabled = false },
        kotlin_lsp = {
          mason = false,
          cmd = { "kotlin-lsp", "--stdio" },
        },
      },
    },
  },
}
