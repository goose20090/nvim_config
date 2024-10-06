return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim', 'ThePrimeagen/harpoon' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '//', builtin.find_files, {})
      vim.keymap.set('n', '<space>g', builtin.live_grep, {})

      -- Harpoon setup
      local harpoon = require('harpoon')
      harpoon:setup({})

      -- Enhanced toggle_telescope function with file removal
      local function toggle_telescope(harpoon_files)
          local finder = function()
              local paths = {}
              for _, item in ipairs(harpoon_files.items) do
                  table.insert(paths, item.value)
              end

              return require("telescope.finders").new_table({
                  results = paths,
              })
          end

          local conf = require("telescope.config").values
          require("telescope.pickers").new({}, {
              prompt_title = "Harpoon",
              finder = finder(),
              previewer = conf.file_previewer({}),
              sorter = require("telescope.config").values.generic_sorter({}),
              layout_config = {
                  height = 0.4,
                  width = 0.5,
                  prompt_position = "top",
                  preview_cutoff = 120,
              },
              attach_mappings = function(prompt_bufnr, map)
                  map("i", "<C-d>", function()
                      local state = require("telescope.actions.state")
                      local selected_entry = state.get_selected_entry()
                      local current_picker = state.get_current_picker(prompt_bufnr)

                      -- Remove the selected item from Harpoon
                      table.remove(harpoon_files.items, selected_entry.index)
                      current_picker:refresh(finder())
                  end)
                  return true
              end,
          }):find()
      end

      -- Key mapping for opening Harpoon with Telescope
      vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}
