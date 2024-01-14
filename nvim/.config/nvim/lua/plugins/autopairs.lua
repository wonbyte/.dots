return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')
      local cond = require('nvim-autopairs.conds')

      npairs.setup({})

      -- exclude filetypes
      npairs.add_rule(
        Rule("$$", "$$")
        :with_pair(cond.not_filetypes({ "ocaml" }))
      )
    end
  },
}
