vim.bo.comments = '# '

local r_ls_cmd = 'R --slave languageserver::run()'

-- Check if R language server is available
if vim.fn.executable(r_ls_cmd) ~= 1 then
  return
end

local root_files = {
  '.Rprofile',
  '.Renviron',
  '.git',
}

vim.lsp.start {
  name = 'r_language_server',
  cmd = { r_ls_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    R = {
      runtime = {
        version = 'R',
      },
      diagnostics = {
        -- Get the language server to recognize the `R` global, etc.
        globals = {
          'R',
        },
      },
    },
  },
}
