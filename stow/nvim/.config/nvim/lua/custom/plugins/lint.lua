return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      javascript = { 'biome' },
      typescript = { 'biome' },
      javascriptreact = { 'biome' },
      typescriptreact = { 'biome' },
      json = { 'biome' },
      css = { 'biome' },
      markdown = { 'prettier' },
      lua = { 'stylua' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
