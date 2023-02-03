-- debug.traceback=nil

function pt (table)
  for k,v in pairs(table) do print(k, v) end
end

function cat(fn)
  for l in io.lines(fn) do print(l) end
end

sh = os.execute

function ldoc() 
  sh("w3m /home/daniel/doc/lua/lua54/doc/contents.html")
end
