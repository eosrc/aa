-- this is a simple script that tests how to use love2D as
-- a lua module, it assumes that you have a copy or a link
-- to liblove-{version nb}.so in the same directory as this
-- file; the copy or link should be (re)named love.so 
--
-- you can get the liblove...so file, if you built love2d
-- or by entering the command: 
-- love-{version nb}-x86_64.AppImage --appimage-extract
-- the file is found in the ...root/usr/lib dir
--
-- you can run this program with: lua5.1 simplvlib.lua
-- or luajit simplvlib.lua
--
-- when running it, you'll get a black borderless window
-- that you can close by cliking on the upper left white box
--
-- notice that there is no function love.load, love.update
-- or love.draw
--

require 'love'
require 'love.window'
require 'love.graphics'
require 'love.timer'
require 'love.event'
require 'love.mouse'

wi, gr, ti = love.window, love.graphics, love.timer
ev, mo = love.event, love.mouse --some shorthand vars

wi.setMode(800, 600, {borderless = true})

while true do
  ev.pump()
  gr.clear()
  gr.rectangle("line", 780, 0, 20, 20) 
  gr.rectangle("line", 784, 4, 12, 12) 
  gr.present()
  ti.sleep(1/8)
  if mo.isDown(1) and mo.getX() > 780 and mo.getY() < 20 
  then 
    os.exit() 
  end
end
