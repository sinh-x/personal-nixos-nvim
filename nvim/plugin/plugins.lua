if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs
local ob = require('obsidian-bridge')
ob.setup {
  obsidian_server_address = 'http://localhost:27123',
}

