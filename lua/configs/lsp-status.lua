-- lua/configs/lsp-status.lua

local status, lss = pcall(require, "lsp-status")
if not status then
	return
end

lss.register_progress()

-- lss.setup({ })

local function lsp_status()
	if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
		return "no lsp"
	end
	return require("lsp-status").status()
end

local P = {
	lsp_status = lsp_status,
}

return P
