-- debug.traceback=nil

function pt (table)
  for k,v in pairs(table) do print(k, v) end
end

function cat(fn)
  for l in io.lines(fn) do print(l) end
end

function sh(s) os.execute(s) end

function ldoc() 
  os.execute("w3m /home/daniel/doc/lua/lua54/doc/contents.html")
end
