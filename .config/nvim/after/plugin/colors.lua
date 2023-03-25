function ColorMyPencil(color)
    color = color or "gruvbox8_hard"
    vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Float", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

ColorMyPencil()

require("colorizer").setup{  }
