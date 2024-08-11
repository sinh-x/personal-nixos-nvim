if vim.g.did_load_autopair_plugin then
  return
end
vim.g.did_load_autopair_plugin = true

require('ultimate-autopair').setup {}
