#!/usr/bin/env lua

function sendfile(fn, host, portnb)
  tmp = os.tmpname()
  os.execute('netcat 2> '..tmp)
  local s = io.open(tmp):read('a')
  if s:find('usage') == nil then 
    print('it seems netcat is not installed\n')
    os.execute('rm '..tmp)
    os.exit(-1)
  end
  local ret = os.execute('netcat -N '..host..' '..portnb..' < '..fn)
  os.execute('rm '..tmp)
  return ret
end

if #arg ~= 3 then 
  print 'usage: sendfile <filename> <host> <port number>\n'
  os.exit()
end
if sendfile(arg[1], arg[2], arg[3]) == true then
  print 'file sent\n'
end
