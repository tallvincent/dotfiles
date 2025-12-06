return {
  'otavioschwanck/arrow.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    show_icons = true,
    leader_key = ';', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
    save_key = 'git_root',
  },
  config = function(_, opts)
    require('arrow').setup(opts)
    vim.keymap.set('n', '<C-p>', require('arrow.persist').previous, { desc = 'Arrow previous' })
    vim.keymap.set('n', '<C-n>', require('arrow.persist').next, { desc = 'Arrow next' })
  end,
}
