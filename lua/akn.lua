local M = {}

local function get_aknlink_name(line, col)
  -- get name of the akn link on specified position
  --
  -- Arguments:
  -- line, col - position os screen (as returned by vim.api.nvim_win_get_cursor(0
  --   (that means line numbers starts with 1, columns numbers start from 0)
  --
  -- returns nil if there is no akn link on specified position
  col = col + 1  -- make col number start from 1
  local line_str = vim.fn.getline(line)
  local cur_pos = 1
  while cur_pos do
    local anchor_start, anchor_stop = string.find(line_str, "|[_%w]+>|", cur_pos)
    if not anchor_start or anchor_start > col then return nil end
    if col >= anchor_start and col <= anchor_stop then
      -- cursor is located in akn link
      return string.sub(line_str, anchor_start+1, anchor_stop-2)
    end
    cur_pos = anchor_stop + 1
  end
  return nil
end

function M.FollowAknLink()
  -- follow akn link under cursor
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]  -- starts from 1
  local col = pos[2]   -- starts from 0

  local link_name = get_aknlink_name(line, col)

  if not link_name then
    -- cursor is not in akn link - nowhere to follow
    return
  end

  local anchor = "|>" .. link_name .. "|"

  local tgt_line = vim.fn.search(anchor, 'ws')   -- (in help file builtin.txt)

  if tgt_line == 0 then
    print("target of akn link not found")
  end
end

function M.GoToNextLink()
  -- jump to next akn link
  vim.fn.search("|\\w\\+>|", 'ws')
end

function M.GoToPrevLink()
  -- jump to prev akn link
  vim.fn.search("|\\w\\+>|", 'bws')
end

function M.setup()
  -- set keyboard mappings for akn file type
  if AknPlugin then return end
  AknPlugin = M

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "akn",
    callback = function()
      local opts = { noremap = true, silent = false }
      vim.api.nvim_buf_set_keymap(
        0, 'n', '<return>', '<cmd>lua AknPlugin.FollowAknLink()<CR>', opts)
      vim.api.nvim_buf_set_keymap(
        0, 'n', '<TAB>', '<cmd>lua AknPlugin.GoToNextLink()<CR>', opts)
      vim.api.nvim_buf_set_keymap(
        0, 'n', '<S-TAB>', '<cmd>lua AknPlugin.GoToPrevLink()<CR>', opts)

      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.tabstop = 2
      vim.opt.expandtab = true
    end,
  })
end

return M
