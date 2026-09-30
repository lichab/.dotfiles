-- Project helpers: the "project" is the git repo of the current buffer, not Neovim's cwd,
-- so pickers and tools work when Neovim was started in a folder that holds several repos.
local M = {}

--- Directory of the current buffer (the listed dir for Oil buffers).
function M.buffer_dir()
    if vim.bo.filetype == 'oil' then
        local ok, oil = pcall(require, 'oil')
        local dir = ok and oil.get_current_dir()
        if dir then
            return dir
        end
    end
    local name = vim.api.nvim_buf_get_name(0)
    if name == '' or vim.bo.buftype ~= '' then
        return vim.uv.cwd()
    end
    return vim.fs.dirname(name)
end

--- Git root of the current buffer, or nil when it's not inside a repo.
function M.git_root()
    return vim.fs.root(M.buffer_dir(), '.git')
end

--- Git root of the current buffer, falling back to Neovim's cwd.
function M.root()
    return M.git_root() or vim.uv.cwd()
end

return M
