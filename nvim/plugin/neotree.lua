if vim.g.did_load_neotree_plugin then
  return
end
vim.g.did_load_neotree_plugin = true

local neotree = require('neo-tree')

neotree.setup {
  event_handlers = {
    {
      event = 'neo_tree_buffer_enter',
      handler = function()
        vim.opt_local.relativenumber = true
      end,
    },
    {
      event = 'file_open_requested',
      handler = function()
        -- auto close
        -- vimc.cmd("Neotree close")
        -- OR
        require('neo-tree.command').execute { action = 'close' }
      end,
    },
    {
      event = 'file_opened',
      handler = function(file_path)
        require('neo-tree').close_all()
      end,
    },
  },
  window = {
    position = 'float',
    mappings = {
      ['A'] = {
        'add_directory',
        config = {
          show_path = 'relative', -- "none", "relative", "absolute"
        },
      },
      ['a'] = {
        'add',
        config = {
          show_path = 'relative', -- "none", "relative", "absolute"
        },
      },
      ['m'] = {
        'move',
        config = {
          show_path = 'relative', -- "none", "relative", "absolute"
        },
      },
    },
  },
}

vim.keymap.set('n', '<leader>e', ':Neotree toggle reveal_force_cwd<cr>', { desc = 'Open neotree' })
vim.keymap.set('n', '<leader>E', '<cmd>Neotree toggle<CR>', { silent = true, desc = 'Explorer NeoTree (cwd)' })
vim.keymap.set('n', '<leader>be', ':Neotree buffers<CR>', { silent = true, desc = 'Buffer explorer' })
vim.keymap.set('n', '<leader>ge', ':Neotree git_status<CR>', { silent = true, desc = 'Git explorer' })
