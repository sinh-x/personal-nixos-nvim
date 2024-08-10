if vim.g.did_load_copilot_plugin then
  return
end
vim.g.did_load_copilot_plugin = true

require('CopilotChat').setup {}
vim.keymap.set('n', '<leader>aa', '<cmd>CopilotChatToggle<CR>', { desc = 'toggle copilot chat' })
vim.keymap.set('v', '<leader>aa', '<cmd>CopilotChatToggle<CR>', { desc = 'toggle copilot chat' })
vim.keymap.set('n', '<leader>aV', 'ggvG$<cmd>CopilotChatToggle<CR>', { desc = 'toggle copilot chat' })
