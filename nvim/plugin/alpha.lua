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
    require('alpha.widgets.button').btn('  Find File', 'Telescope find_files', { position = 'center', width = 38 }),
    { type = 'padding', val = 1 },
    require('alpha.widgets.button').btn('  New File', 'ene | startinsert', { position = 'center', width = 38 }),
    { type = 'padding', val = 1 },
    require('alpha.widgets.button').btn(
      '󰈚  Recent Files',
      'Telescope oldfiles',
      { position = 'center', width = 38 }
    ),
    { type = 'padding', val = 1 },
    require('alpha.widgets.button').btn('󰈭  Find Word', 'Telescope live_grep', { position = 'center', width = 38 }),
    { type = 'padding', val = 1 },
    require('alpha.widgets.button').btn(
      '  Restore Session',
      "lua require('persistence').load()",
      { position = 'center', width = 38 }
    ),
    { type = 'padding', val = 1 },
    require('alpha.widgets.button').btn('  Quit Neovim', 'qa', { position = 'center', width = 38 }),
  },
}

require('alpha').setup(opts)
