-- Setup how diagnostics should appear in neovim
local function setup_lsp_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    local config = {
        virtual_text = false,
        signs = {
            active = signs,
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
            },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

setup_lsp_diagnostics()

-- Setup Mason (Ensure binaries are installed)
require("mason").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "clangd",
        "clang-format",
        "gopls",
        "lua-language-server",
        "typescript-language-server",
        "css-lsp",
        "tailwindcss-language-server",
        "vue-language-server",
        "bash-language-server",
        "eslint_d",
        "prettierd",
        "stylua",
        "basedpyright",
        "ruff",
    },
})

-- Note: blink.cmp automatically merges into the correct structure
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["*"] = {
    capabilities = capabilities,
}

-- Servers whose formatting is handled by another tool (prettierd, etc.)
local no_formatting = { vue_ls = true, bashls = true, ts_ls = true, tsc = true }

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local bufnr = event.buf

        -- Disable formatting for specific servers to avoid conflicts
        if no_formatting[client.name] then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- Setup keybindings
        require("keybindings").lsp_keybindings_for_buffer(bufnr)

        -- Highlight references of the symbol under the cursor
        if client:supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- 3. Define Server-Specific Configurations
-- You only need to define these if you have custom settings or filetypes

-- Lua
vim.lsp.config["lua_ls"] = {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
        },
    },
}

-- Rust
vim.lsp.config["rust_analyzer"] = {
    settings = {
        ["rust-analyzer"] = {
            check = { command = "clippy" },
            cargo = { allFeatures = true },
        },
    },
}

-- Return the major version of the TypeScript package in the nearest node_modules.
-- Return 0 if the buffer has no local TypeScript.
local function workspace_ts_major(bufnr)
    local root = vim.fs.root(bufnr, "node_modules")
    if not root then
        return 0
    end
    local pkg = vim.fs.joinpath(root, "node_modules/typescript/package.json")
    local ok, data = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(pkg), "\n"))
    end)
    local version = ok and data and vim.version.parse(data.version)
    return version and version.major or 0
end

-- TypeScript 7+ has no tsserver.js, so ts_ls cannot use it.
-- TS 7+ projects get the native server (tsc --lsp); older projects get ts_ls.
local ts_ls_root_dir = vim.lsp.config.ts_ls.root_dir
local tsc_root_dir = vim.lsp.config.tsc.root_dir

vim.lsp.config["tsc"] = {
    root_dir = function(bufnr, on_dir)
        if workspace_ts_major(bufnr) >= 7 then
            tsc_root_dir(bufnr, on_dir)
        end
    end,
}

-- TypeScript (Vue Hybrid Mode)
local vue_language_server_path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")

vim.lsp.config["ts_ls"] = {
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
    root_dir = function(bufnr, on_dir)
        if workspace_ts_major(bufnr) < 7 then
            ts_ls_root_dir(bufnr, on_dir)
        end
    end,
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
            },
        },
    },
    filetypes = {
        "typescript",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "vue",
    },
    single_file_support = false,
}

vim.lsp.config["denols"] = {
    root_markers = { "deno.json", "deno.jsonc" },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local result = vim.fs.root(fname, { "deno.json", "deno.jsonc" })
        if result then
            on_dir(result)
        end
    end,
}

-- 4. Enable Servers
-- This triggers the start logic using the configs defined above (or defaults from nvim-lspconfig)

local servers = {
    "gopls",
    "prismals",
    "eslint",
    "cssls",
    "clangd",
    "tailwindcss",
    "vue_ls",
    "bashls",
    "basedpyright",
    "ruff",
    -- Complex configs
    "lua_ls",
    "rust_analyzer",
    "ts_ls",
    "tsc",
    "denols",
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end
