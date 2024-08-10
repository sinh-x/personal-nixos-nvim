if vim.g.did_load_persistence_plugin then
  return
end
vim.g.did_load_persistence_plugin = true

require('persistence').setup {
  event_handlers = {
    {
      event = 'BufReadPre',
      handler = function()
        require('persistence').load()
      end,
    },
    {
      event = 'VimLeavePre',
      handler = function()
        require('persistence').save()
      end,
    },
  },
}
