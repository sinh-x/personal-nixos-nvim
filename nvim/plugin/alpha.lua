if vim.g.did_load_alpha_plugin then
  return
end
vim.g.did_load_alpha_plugin = true

require('alpha').setup(require('alpha.themes.dashboard').opts)

local opts = {
  layout = {
    { type = 'padding', val = 3 },
    {
      type = 'text',
      val = {
        ' ███████╗██╗███╗   ██╗██╗  ██╗     ██╗  ██╗ ',
        ' ██╔════╝██║████╗  ██║██║  ██║     ╚██╗██╔╝ ',
        ' ███████╗██║██╔██╗ ██║███████║█████╗╚███╔╝  ',
        ' ╚════██║██║██║╚██╗██║██╔══██║╚════╝██╔██╗  ',
        ' ███████║██║██║ ╚████║██║  ██║     ██╔╝ ██╗ ',
        ' ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝     ╚═╝  ╚═╝ ',
        '                                            ',
        '              git@github.com:sinh-x         ',
      },
      opts = { position = 'center', hl = 'AlphaHeader' },
    },
    { type = 'padding', val = 2 },
    {
      type = 'button',
      val = '  Find File',
      on_press = 'Telescope find_files',
      opts = {
        keymap = { 'n', 'f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true, nowait = true } },
        shortcut = 'f',
        position = 'center',
        cursor = 3,
        width = 38,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
      },
    },
    { type = 'padding', val = 2 },
    {
      type = 'button',
      val = '  New File',
      on_press = 'ene | startinsert',
      opts = {
        keymap = { 'n', 'n', '<cmd>ene<CR><cmd>startinsert<CR>', { noremap = true, silent = true, nowait = true } },
        shortcut = 'n',
        position = 'center',
        cursor = 3,
        width = 38,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
      },
    },
    { type = 'padding', val = 1 },
    {
      type = 'button',
      val = '󰈚  Recent Files',
      on_press = 'Telescope oldfiles',
      opts = {
        keymap = { 'n', 'r', '<cmd>Telescope oldfiles<CR>', { noremap = true, silent = true, nowait = true } },
        shortcut = 'r',
        position = 'center',
        cursor = 3,
        width = 38,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
      },
    },
    { type = 'padding', val = 1 },
    {
      type = 'button',
      val = '󰈭  Find Word',
      on_press = 'Telescope live_grep',
      opts = {
        keymap = { 'n', 'g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true, nowait = true } },
        shortcut = 'g',
        position = 'center',
        cursor = 3,
        width = 38,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
      },
    },
    { type = 'padding', val = 1 },
    {
      type = 'button',
      val = '  Restore Session',
      on_press = "lua require('persistence').load()",
      opts = {
        keymap = {
          'n',
          's',
          "<cmd>lua require('persistence').load()<CR>",
          { noremap = true, silent = true, nowait = true },
        },
        shortcut = 's',
        position = 'center',
        cursor = 3,
        width = 38,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
      },
    },
    { type = 'padding', val = 1 },
    {
      type = 'button',
      val = '  Quit Neovim',
      on_press = 'qa',
      opts = {
        keymap = { 'n', 'q', '<cmd>qa<CR>', { noremap = true, silent = true, nowait = true } },
        shortcut = 'q',
        position = 'center',
        cursor = 3,
        width = 38,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
      },
    },
  },
}

require('alpha').setup(opts)
