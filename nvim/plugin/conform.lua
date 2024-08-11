if vim.g.did_load_conform_plugin then
  return
end
vim.g.did_load_conform_plugin = true

require('conform').setup {
  -- Map of filetype to formatters
  formatters_by_ft = {
    nix = { 'alejandra' },
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    go = { 'goimports', 'gofmt' },
    -- Use a sub-list to run only the first available formatter
    javascript = { { 'prettierd', 'prettier' } },
    -- You can use a function here to determine the formatters dynamically
    python = function(bufnr)
      if require('conform').get_formatter_info('ruff_format', bufnr).available then
        return { 'ruff_format' }
      else
        return { 'isort', 'black' }
      end
    end,
    rust = { 'rustfmt' },
    json = { 'prettierd', 'prettier' },
    r = { 'rprettify' },
    -- Use the "*" filetype to run formatters on all filetypes.
    -- ['*'] = { 'codespell' },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ['_'] = { 'trim_whitespace' },
  },
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 5000, lsp_fallback = true }
  end,
  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = {
    lsp_format = 'fallback',
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Custom formatters and overrides for built-in formatters
  formatters = {
    rprettify = {
      inherit = 'false',
      stdin = false,
      command = 'rprettify',
      args = { '$FILENAME' },
    },
  },
}
