return {
  {
    'mini.files',
    keys = {
      {
        '<leader>e',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (Directory of Current File)',
      },
      {
        '<leader>E',
        function()
          require('mini.files').open(vim.uv.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
      },
    },
    opts = function(_, opts)
      opts.options.use_as_default_explorer = true
      opts.mappings = {
        go_in = '',
        go_out = '',
        go_in_plus = 'l',
        go_out_plus = 'h',
        synchronize = '<Return>',
      }

      opts.content = {
        filter = function(fs_entry)
          local hidden_folders = {
            '.git',
            'node_modules',
            'build',
            'dist',
            '.next',
          }
          for _, folder_name in ipairs(hidden_folders) do
            if fs_entry.name == folder_name then
              return false
            end
          end
          return true
        end,
      }

      -- Set multiple keymaps for the same action in mini.files
      local miniFiles = require('mini.files')
      local set = vim.keymap.set

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local function keyMapOpts(desc)
            return { desc = desc, buffer = args.data.buf_id }
          end

          -- Exit mini.files with <Esc>
          set('n', '<Esc>', miniFiles.close, keyMapOpts('MiniFiles: Exit'))
        end,
      })
    end,
  },
  {
    'neo-tree.nvim',
    opts = {
      close_if_last_window = true,
      window = {
        width = 27,
        mappings = {
          ['o'] = 'open',
          ['oc'] = 'none',
          ['od'] = 'none',
          ['og'] = 'none',
          ['om'] = 'none',
          ['on'] = 'none',
          ['os'] = 'none',
          ['ot'] = 'none',
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          -- hide_by_name = {
          --   "node_modules",
          -- },
          never_show = {
            '.git',
            'node_modules',
          },
        },
      },
    },
  },
  {
    'flash.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, false },
      { 'S', mode = { 'n', 'x', 'o' }, false },
      {
        '<m-f>',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        '<m-F>',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
    opts = function(_, opts)
      opts.jump = {
        autojump = true,
        nohlsearch = true,
      }

      opts.modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      }
    end,
  },
}
