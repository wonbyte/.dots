vim.filetype.add({
  extension = {
    h = function(path, bufnr)
      -- Treat .h as C unless the file looks like C++
      local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 50, false), "\n")
      if content:match("class%s") or content:match("namespace%s") or content:match("template%s*<") then
        return "cpp"
      end
      return "c"
    end,
  },
})
