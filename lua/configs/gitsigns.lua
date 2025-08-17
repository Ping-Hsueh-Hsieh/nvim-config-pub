-- lua/configs/gitsigns.lua

local status, ggs = pcall(require, "gitsigns")

if not status then
    return
end

ggs.setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
      end, {
          expr=true,
          desc="next_hunk"
      })

      map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
      end, {
          expr=true,
          desc="prev_hunk"
      })

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc="gs.stage_hunk" })
      map('n', '<leader>hr', gs.reset_hunk, { desc="gs.reset_hunk" })
      map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc="gs.stage_hunk" })
      map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc="gs.reset_hunk" })
      map('n', '<leader>hS', gs.stage_buffer, { desc="gs.stage_buffer" })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc="gs.undo_stage_hunk" })
      map('n', '<leader>hR', gs.reset_buffer, { desc="gs.reset_buffer" })
      map('n', '<leader>hp', gs.preview_hunk, { desc="gs.preview_hunk" })
      map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc="gs.blame_line" })
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc="gs.toggle_current_line_blame" })
      map('n', '<leader>hd', gs.diffthis, { desc="gs.diffthis" })
      map('n', '<leader>hD', function() gs.diffthis('~') end, { desc="gs.diffthis ~" })
      map('n', '<leader>td', gs.toggle_deleted, { desc="gs.toggle_deleted" })

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc="select_hunk" })
  end
})
