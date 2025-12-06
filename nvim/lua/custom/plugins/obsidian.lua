return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  enabled = false,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/ObsidianVault',
      },
    },
    note_id_func = function(title)
      return title
    end,
    mappings = {
      -- Default mappings
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      -- Custom mapping to just toggle checkboxes between done and not done
      ['<leader>ct'] = {
        action = function()
          local line_num = unpack(vim.api.nvim_win_get_cursor(0))
          local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

          local checkbox_pattern = '^%s*- %[.] '
          local checkboxes = { ' ', '/', 'x' }

          -- If the current line is not a checkbox, make it one
          if not string.match(line, checkbox_pattern) then
            local unordered_list_pattern = '^(%s*)[-*+] (.*)'
            if string.match(line, unordered_list_pattern) then
              line = string.gsub(line, unordered_list_pattern, '%1- [ ] %2')
            else
              line = string.gsub(line, '^(%s*)', '%1- [ ] ')
            end
          else
            -- Otherwise toggle the checkbox
            for i, check_char in require('obsidian.itertools').enumerate(checkboxes) do
              if string.match(line, '^%s*- %[' .. require('obsidian').util.escape_magic_characters(check_char) .. '%].*') then
                -- Set i to 0 if i is currently the length of checkboxes
                if i == #checkboxes then
                  i = 0
                end
                -- Skip the partial ('/') if the current checkbox is not done
                if check_char == ' ' then
                  line = require('obsidian').util.string_replace(line, '- [' .. check_char .. ']', '- [x]', 1)
                  break
                end
                line = require('obsidian').util.string_replace(line, '- [' .. check_char .. ']', '- [' .. checkboxes[i + 1] .. ']', 1)
                break
              end
            end
          end
          -- 0-indexed
          vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, { line })
        end,
        opts = { buffer = true, desc = '[C]hecbox [T]oggle' },
      },
    },
    ui = {
      checkboxes = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        -- Custom checkbox icons and colours
        ['-'] = { char = '󰜺', hl_group = 'ObsidianCancelled' },
        ['i'] = { char = '󰋼', hl_group = 'ObsidianInfo' },
        ['/'] = { char = '󰡖', hl_group = 'ObsidianPartial' },
        ['*'] = { char = '', hl_group = 'ObsidianStar' },
        ['?'] = { char = '', hl_group = 'ObsidianQuestion' },
        ['p'] = { char = '', hl_group = 'ObsidianPro' },
        ['c'] = { char = '', hl_group = 'ObsidianCon' },
        ['f'] = { char = '󰈸', hl_group = 'ObsidianFire' },
        ['I'] = { char = '󰛨', hl_group = 'ObsidianIdea' },
      },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = '#f78c6c' },
        ObsidianDone = { bold = true, fg = '#89ddff' },
        ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianImportant = { bold = true, fg = '#d73128' },
        ObsidianBullet = { bold = true, fg = '#89ddff' },
        ObsidianRefText = { underline = true, fg = '#c792ea' },
        ObsidianExtLinkIcon = { fg = '#c792ea' },
        ObsidianTag = { italic = true, fg = '#89ddff' },
        ObsidianBlockID = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
        -- Custom checkbox icon colours
        ObsidianCancelled = { fg = '#7a6f65' },
        ObsidianInfo = { fg = '#4689cc' },
        ObsidianPartial = { fg = '#f78c6c' },
        ObsidianStar = { fg = '#ce9c3e' },
        ObsidianQuestion = { fg = '#ae8b2d' },
        ObsidianPro = { fg = '#adc27c' },
        ObsidianCon = { fg = '#c87b4b' },
        ObsidianFire = { fg = '#c04d58' },
        ObsidianIdea = { fg = '#deb773' },
      },
    },
  },
}
