if vim.g.did_load_bufferline_plugin then
  return
end
vim.g.did_load_bufferline_plugin = true

require('bufferline').setup {
  options = {
    numbers = 'ordinal',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    separator_style = 'thick',
    always_show_bufferline = true,
    offsets = {
      {
        filetype = 'neo-tree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'left',
      },
    },
  },
}
