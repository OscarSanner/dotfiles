local status_ok, nonels = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = nonels.builtins.formatting
local diagnostics =  nonels.builtins.diagnostics

nonels.setup({
 debug = false,
 sources = {
  formatting.stylua,
  formatting.prettier,
  formatting.black,
  -- formatting.prettier.with {
  --   extra_filetypes = { "toml" },
  --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
  -- },
  -- formatting.eslint,
  diagnostics.flake8,
  -- diagnostics.flake8,
  nonels.builtins.completion.spell,
 }
})
