return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local set = vim.keymap.set
    set('n', '<leader>G', '<Cmd>Neogit<CR>', { desc = '[G]it status' })
  end,
}
