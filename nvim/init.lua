if vim.g.vscode then
  print("Using empty init.lua for VS Code Extension")
else
  -- Set up lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Leader key (Start a key sequence)
  vim.g.mapleader = " "

  require('lazy').setup('plugins')

  require("lsp")
  require("setup")

  -- customize after plugin setup
  require("options")
  require("keymap")
end

