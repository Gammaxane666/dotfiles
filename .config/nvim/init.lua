require("theNeovim.base")
require("theNeovim.remap")
require("theNeovim.plugins")

local has = function (x)
    return vim.fn.has(x)
end

local is_linux = has "unix"

if is_linux then
	require('linux')
end
