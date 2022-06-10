
local status_ok, treesitter_context = pcall(require, "treesitter-context")

if not status_ok then
    return
end

treesitter_context.setup{
    enable = true,
}
