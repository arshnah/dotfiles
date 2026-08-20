-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Shrink this kitty window's padding while nvim is running, restore it on
-- exit. Only affects the window nvim is in (via KITTY_WINDOW_ID over the
-- per-window socket kitty already exports as KITTY_LISTEN_ON), not
-- kitty's padding globally for plain shell use.
if vim.env.KITTY_WINDOW_ID and vim.env.KITTY_LISTEN_ON then
  local kitty_padding_group = vim.api.nvim_create_augroup("kitty_padding", { clear = true })
  local function set_kitty_padding(padding)
    vim.fn.jobstart({
      "kitty",
      "@",
      "--to",
      vim.env.KITTY_LISTEN_ON,
      "set-spacing",
      "--match",
      "id:" .. vim.env.KITTY_WINDOW_ID,
      "padding=" .. padding,
    }, { detach = true })
  end
  vim.api.nvim_create_autocmd("VimEnter", {
    group = kitty_padding_group,
    callback = function()
      set_kitty_padding(7)
    end,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = kitty_padding_group,
    callback = function()
      set_kitty_padding(25)
    end,
  })
end
