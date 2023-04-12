local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    -- vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
end)

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
})
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
