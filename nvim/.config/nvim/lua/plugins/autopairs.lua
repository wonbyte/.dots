return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opt = function()
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')
      local cond = require('nvim-autopairs.conds')

      -- you can exclude filetypes
      npairs.add_rule(
        Rule("$$", "$$")
        :with_pair(cond.not_filetypes({ "ocaml" }))
      )
    end
  },
}
