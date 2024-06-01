local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


ls.add_snippets("javascript", {
	s("asaf", fmt(
	[[
	async {}() => {{
		{}
	}}
	]], { c(1, {t("func"), t("")}), i(2) })),

	s("desc", fmt(
	[[
	describe("{}", () => {{
		{}
	}})
	]], { i(1, "Description"), i(2) })),

	s("it", fmt(
	[[
	it("{}", {}() => {{
		{}
	}})
	]], { 
		i(1, "Description"),
		c(2, {t("async "), t("")}),
		i(3) 
		})
	)
})
