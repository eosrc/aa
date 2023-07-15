#!/usr/bin/env lua

function recvfile( fn, portnb)
  local tmp = os.tmpname()
  os.execute('netcat 2> '..tmp)
  local s = io.open(tmp):read('a')
  if s:find('usage') == nil then 
    print('it seems netcat is not installed\n')
    os.execute('rm '..tmp)
    os.exit(-1)
  end
  local ret = os.execute('netcat -l '..portnb..' > '..fn)
  os.execute( 'rm '..tmp)
  return ret
end

if #arg ~= 2 then
  print 'usage: recvfile <filename> <port number>\n'
  os.exit()
end
if recvfile(arg[1], arg[2]) == true then 
  print 'file received\n'
end 
