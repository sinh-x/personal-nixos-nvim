if vim.g.did_load_rnvim_plugin then
  return
end
vim.g.did_load_rnvim_plugin = true

local rnvim = require('r')
rnvim.setup {
  R_args = { '--no-save', '--no-restore' },
  hook = {
    on_filetype = function()
      -- This function will be called at the FileType event
      -- of files supported by R.nvim. This is an
      -- opportunity to create mappings local to buffers.
      vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
      vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
    end,
  },
  nvimpager = 'split_h',
  min_editor_width = 1000,
}
