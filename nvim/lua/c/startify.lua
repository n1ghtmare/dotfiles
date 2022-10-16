local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
    return
end

vim.g.startify_session_persistence = 1

vim.g.startify_custom_header = {
    '   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    '   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
    '   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
    '   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    '   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
    '   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
}

vim.g.startify_bookmarks = {'~/Dev-Config/dotfiles'}


function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return nvim_web_devicons.get_icon(filename, extension, { default = true })
end

vim.cmd([[
function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
]])
