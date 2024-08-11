if vim.g.did_load_lspsaga_plugin then
  return
end
vim.g.did_load_lspsaga_plugin = true
local lspsaga = require('lspsaga').setup {
  auto_preview = true,
  auto_fold = true,
}
