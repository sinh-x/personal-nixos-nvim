if vim.g.did_load_notify_plugin then
  return
end
vim.g.did_load_notify_plugin = true

local notify = require('notify')
notify.setup {
  stages = 'fade_in_slide_out',
  timeout = 3000,
  background_colour = '#1E1E1E',
  icons = {
    ERROR = '',
    WARN = '',
    INFO = '',
    DEBUG = '',
    TRACE = '✎',
  },
  action_callback = function(action)
    print(vim.inspect(action))
  end,
}

vim.keymap.set(
  'n',
  '<Leader>un',
  ':lua require("notify").dismiss({ silent = true, pending = true })<CR>',
  { silent = true, desc = 'Dismiss All Notifications' }
)

local filtered_message = { 'No information available' }

-- Override notify function to filter out messages
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(message, level, opts)
  local merged_opts = vim.tbl_extend('force', {
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    end,
  }, opts or {})

  for _, msg in ipairs(filtered_message) do
    if message == msg then
      return
    end
  end
  return notify(message, level, merged_opts)
end
