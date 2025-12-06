return {
  'romgrk/barbar.nvim',
  enabled = false,
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  config = function()
    vim.g.barbar_auto_setup = false
    local set = vim.keymap.set
    set('n', '<M-p>', '<Cmd>BufferPrevious<CR>')
    set('n', '<M-n>', '<Cmd>BufferNext<CR>')
    set('n', '<leader>bd', '<Cmd>BufferDelete<CR>', { desc = '[B]uffer [D]elete' })
    set('n', '<leader>br', '<Cmd>BufferRestore<CR>', { desc = '[B]uffer [R]estore' })
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
