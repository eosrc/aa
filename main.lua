tmd = require "src/tmd"

function love.load()
  tmd.load()
end

function love.update(dt)
  tmd.slowdown(dt)
end

function love.draw()
  tmd.drawPage()
end

function love.mousepressed(x,y)
  tmd.clicked(x,y)
end
