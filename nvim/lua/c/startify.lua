vim.g.startify_session_persistence = 1

vim.g.startify_custom_header = {
    '   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    '   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
    '   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
    '   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    '   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
    '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
}


function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end

vim.cmd([[
function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
]])
