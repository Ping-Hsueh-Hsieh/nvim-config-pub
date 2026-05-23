-- 📂lua/📂configs/🌑tresitter.lua

local status, ts = pcall(require, "nvim-treesitter")
if not status then
	return
end

ts.install({
    'python'
})
