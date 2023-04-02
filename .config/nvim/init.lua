require("theNeovim")

local has = function (x)
    return vim.fn.has(x)
end

local is_linux = has "unix"

if is_linux then
	require('linux')
end
