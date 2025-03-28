local __opts__ = { expr = false }
return {
  -- {
  --   meth = "textDocument/references",
  --   mapp = "<leader>lc",
  --   mode = { "n" },
  --   exec = vim.lsp.buf.clear_references,
  --   desc = "Clear references using LSP provider",
  --   opts = __opts__,
  -- },
  {
    meth = "textDocument/codeAction",
    mapp = "<C-.>",
    mode = { "n", "i", "v" },
    exec = vim.lsp.buf.code_action,
    desc = "Get code actions using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/declaration",
    mapp = "<leader>ld",
    mode = { "n" },
    exec = vim.lsp.buf.declaration,
    desc = "Jump to declaration using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/definition",
    mapp = "F",
    mode = { "n" },
    exec = vim.lsp.buf.definition,
    desc = "Jump to definition using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/references",
    mapp = "<leader>lH",
    mode = { "n" },
    exec = vim.lsp.buf.document_highlight,
    desc = "Highlight references in the document using LSP provider",
    opts = __opts__,
  },
  -- {
  --   meth = "textDocument/documentSymbol",
  --   mapp = "<leader>ls",
  --   mode = { "n" },
  --   exec = vim.lsp.buf.document_symbol,
  --   desc = "Get document symbols using LSP provider",
  --   opts = __opts__,
  -- },
  -- {
  --   mapp = "<leader>le",
  --   mode = { "n" },
  --   exec = vim.lsp.buf.execute_command,
  --   desc = "Execute command using LSP provider",
  --   opts = __opts__,
  -- },
  {
    meth = "textDocument/formatting",
    mapp = "<leader>lf",
    mode = { "n" },
    exec = function() vim.lsp.buf.format({ async = true }) end,
    desc = "Format code using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/hover",
    mapp = "<leader>lh",
    mode = { "n" },
    exec = vim.lsp.buf.hover,
    desc = "Show hover information using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/implementation",
    mapp = "<leader>li",
    mode = { "n" },
    exec = vim.lsp.buf.implementation,
    desc = "Jump to implementation using LSP provider",
    opts = __opts__,
  },
  {
    meth = "callHierarchy/incomingCalls",
    mapp = "<leader>lI",
    mode = { "n" },
    exec = vim.lsp.buf.incoming_calls,
    desc = "Show incoming calls using LSP provider",
    opts = __opts__,
  },
  -- {
  --   mapp = "<leader>lw",
  --   mode = { "n" },
  --   exec = vim.lsp.buf.list_workspace_folders,
  --   desc = "List workspace folders using LSP provider",
  --   opts = __opts__,
  -- },
  {
    meth = "callHierarchy/outgoingCalls",
    mapp = "<leader>lo",
    mode = { "n" },
    exec = vim.lsp.buf.outgoing_calls,
    desc = "Show outgoing calls using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/references",
    mapp = "<leader>lR",
    mode = { "n" },
    exec = vim.lsp.buf.references,
    desc = "Show symbol references using LSP provider",
    opts = __opts__,
  },
  {
    mapp = "<leader>lW",
    mode = { "n" },
    exec = vim.lsp.buf.remove_workspace_folder,
    desc = "Remove a folder from workspace using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/rename",
    mapp = "<F2>",
    mode = { "n", "i" },
    exec = vim.lsp.buf.rename,
    desc = "Rename using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/rename",
    mapp = "<leader>lr",
    mode = { "n" },
    exec = vim.lsp.buf.rename,
    desc = "Rename using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/signatureHelp",
    mapp = "<leader>lsh",
    mode = { "n" },
    exec = vim.lsp.buf.signature_help,
    desc = "Show signature help using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/typeDefinition",
    mapp = "<leader>lt",
    mode = { "n" },
    exec = vim.lsp.buf.type_definition,
    desc = "Jump to type definition using LSP provider",
    opts = __opts__,
  },
  {
    meth = "textDocument/typeDefinition",
    mapp = "<leader>dl",
    mode = { "n" },
    exec = vim.diagnostic.setloclist,
    desc = "Open LSP provider diagnostic link window",
    opts = __opts__,
  },
  -- {
  --   meth = "workspace/symbol",
  --   mapp = "<leader>lS",
  --   mode = { "n" },
  --   exec = vim.lsp.buf.workspace_symbol,
  --   desc = "Get workspace symbols using LSP provider",
  --   opts = __opts__,
  -- },
}
