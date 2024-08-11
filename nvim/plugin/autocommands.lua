if vim.g.did_load_autocommands_plugin then
  return
end
vim.g.did_load_autocommands_plugin = true

local api = vim.api

-- autosave when lose focus
api.nvim_create_autocmd('focuslost', {
  callback = function()
    if vim.api.nvim_get_mode().mode == 'i' then
      vim.cmd([[stopinsert]])
    end
    vim.cmd([[wa!]])
  end,
})

api.nvim_create_autocmd('bufwritepre', {
  callback = function()
    require('conform').format {
      lsp_format = 'fallback',
      timeout_ms = 500,
    }
  end,
})

local tempdirgroup = api.nvim_create_augroup('tempdir', { clear = true })
-- do not set undofile for files in /tmp
api.nvim_create_autocmd('bufwritepre', {
  pattern = '/tmp/*',
  group = tempdirgroup,
  callback = function()
    vim.cmd.setlocal('noundofile')
  end,
})

-- disable spell checking in terminal buffers
local nospell_group = api.nvim_create_augroup('nospell', { clear = true })
api.nvim_create_autocmd('termopen', {
  group = nospell_group,
  callback = function()
    vim.wo[0].spell = false
  end,
})

-- lsp
local keymap = vim.keymap

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  local buf, _ = vim.lsp.util.preview_location(result[1])
  if buf then
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = vim.bo[cur_buf].filetype
  end
end

local function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textdocument/definition', params, preview_location_callback)
end

local function peek_type_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textdocument/typedefinition', params, preview_location_callback)
end

--- don't create a comment string when hitting <enter> on a comment line
vim.api.nvim_create_autocmd('bufenter', {
  group = vim.api.nvim_create_augroup('disablenewlineautocommentstring', {}),
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

local function set_keymaps(bufnr, client)
  local function desc(description)
    return { noremap = true, silent = true, buffer = bufnr, desc = description }
  end

  local keymap_settings = {
    { 'n', 'gD', vim.lsp.buf.declaration, desc('lsp [g]o to [D]eclaration') },
    { 'n', 'gd', vim.lsp.buf.definition, desc('lsp [g]o to [d]efinition') },
    { 'n', '<space>gt', vim.lsp.buf.type_definition, desc('lsp [g]o to [t]ype definition') },
    { 'n', 'K', vim.lsp.buf.hover, desc('[lsp] hover') },
    { 'n', '<space>pd', peek_definition, desc('lsp [p]eek [d]efinition') },
    { 'n', '<space>pt', peek_type_definition, desc('lsp [p]eek [t]ype definition') },
    { 'n', 'gi', vim.lsp.buf.implementation, desc('lsp [g]o to [i]mplementation') },
    { 'n', '<C-k>', vim.lsp.buf.signature_help, desc('[lsp] signature help') },
    { 'n', '<space>wa', vim.lsp.buf.add_workspace_folder, desc('lsp add [w]orksp[a]ce folder') },
    { 'n', '<space>wr', vim.lsp.buf.remove_workspace_folder, desc('lsp [w]orkspace folder [r]emove') },
    {
      'n',
      '<space>wl',
      function()
        vim.print(vim.lsp.buf.list_workspace_folders())
      end,
      desc('[lsp] [w]orkspace folders [l]ist'),
    },
    { 'n', '<space>rn', vim.lsp.buf.rename, desc('lsp [r]e[n]ame') },
    { 'n', '<space>wq', vim.lsp.buf.workspace_symbol, desc('lsp [w]orkspace symbol [q]') },
    { 'n', '<space>dd', vim.lsp.buf.document_symbol, desc('lsp [dd]ocument symbol') },
    { 'n', '<M-CR>', vim.lsp.buf.code_action, desc('[lsp] code action') },
    { 'n', '<M-l>', vim.lsp.codelens.run, desc('[lsp] run code lens') },
    { 'n', '<space>cr', vim.lsp.codelens.refresh, desc('lsp [c]ode lenses [r]efresh') },
    { 'n', 'gr', vim.lsp.buf.references, desc('lsp [g]et [r]eferences') },
    -- Add the rest of your keymaps here
  }

  for _, setting in ipairs(keymap_settings) do
    keymap.set(unpack(setting))
  end

  if client and client.server_capabilities.inlayHintProvider then
    keymap.set('n', '<space>h', function()
      local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
      vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
    end, desc('[lsp] toggle inlay hints'))
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- -- Attach plugins
    -- -- require('nvim-navic').attach(client, bufnr)

    vim.cmd.setlocal('signcolumn=yes')

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    set_keymaps(bufnr, client)

    -- Auto-refresh code lenses
    if not client then
      return
    end
    local group = api.nvim_create_augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
    if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
        group = group,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end,
        buffer = bufnr,
      })
      vim.lsp.codelens.refresh { bufnr = bufnr }
    end
  end,
})

api.nvim_create_autocmd('filetype', {
  pattern = 'r',
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '# %s')
  end,
})

-- more examples, disabled by default

-- toggle between relative/absolute line numbers
-- show relative line numbers in the current buffer,
-- absolute line numbers in inactive buffers
-- local numbertoggle = api.nvim_create_augroup('numbertoggle', { clear = true })
-- api.nvim_create_autocmd({ 'bufenter', 'focusgained', 'insertleave', 'cmdlineleave', 'winenter' }, {
--   pattern = '*',
--   group = numbertoggle,
--   callback = function()
--     if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
--       vim.opt.relativenumber = true
--     end
--   end,
-- })
-- api.nvim_create_autocmd({ 'bufleave', 'focuslost', 'insertenter', 'cmdlineenter', 'winleave' }, {
--   pattern = '*',
--   group = numbertoggle,
--   callback = function()
--     if vim.o.nu then
--       vim.opt.relativenumber = false
--       vim.cmd.redraw()
--     end
--   end,
-- })
