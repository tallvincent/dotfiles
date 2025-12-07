return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    require('flutter-tools').setup {
      lsp = {
        color = {
          enabled = true,
        },
        on_attach = function()
          local set = vim.keymap.set
          set('n', '<leader>fR', '<cmd>FlutterRun<CR>', { desc = '[F]lutter [R]un' })
          set('n', '<leader>fr', '<cmd>FlutterRestart<CR>', { desc = '[F]lutter [R]estart' })
          set('n', '<leader>fQ', '<cmd>FlutterQuit<CR>', { desc = '[F]lutter [Q]uit' })
        end,
      },
    }
  end,
}
