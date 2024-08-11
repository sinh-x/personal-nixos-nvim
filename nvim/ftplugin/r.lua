local lspconfig = require('lspconfig')

-- Configure the r_language_server
lspconfig.r_language_server.setup {
  on_attach = function(client, bufnr)
    -- Set up your keymaps, etc. here

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Auto-refresh code lenses
    if client.server_capabilities.codeLensProvider then
      local group = api.nvim_create_augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
      vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
        group = group,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end,
        buffer = bufnr,
      })
      vim.lsp.codelens.refresh { bufnr = bufnr }
    end
  end,
  filetypes = { 'r', 'R' },
}

-- Set the comment string for R files
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'r',
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '# %s')
  end,
})
