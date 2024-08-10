vim.api.nvim_buf_set_option(0, 'commentstring', '# %s')

require('lspconfig').r_language_server.setup {}
