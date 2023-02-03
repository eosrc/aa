require "src/lautils"
require "src/lvutils"

local tmd = {}

local pageNb = 1
local nbpcr = 0 -- nb of pages created

local scinfo = { clicked = false, nb =  0, time = 0} -- star clicked info
local quotes = {}

local pages = {}
local w, h

function tmd.loadquotes(fn)
  local i = 1
  local allquote = ""
  for l in love.filesystem.lines(fn) do
    if l == "" then 
      do 
        quotes[i] = allquote
        i = i + 1
        allquote = ""
      end
    else
      allquote = allquote.."\n"..l
    end   
  end
  quotes.len = i
end

function tmd.load()
  gr.setFont(gr.newFont("data/font.otf", 20))
  -- gr.setFont(gr.newFont(16))
  w, h = gr.getWidth(), gr.getHeight()
  tmd.loadquotes("data/qtV1.txt")
  tmd.changePage()
end

function tmd.slowdown(dt) 
  if dt < 0.5 then ti.sleep(0.5-dt) end
end

function tmd.createPage()
  math.randomseed(os.clock())
  local nbs = math.random(3,5)
  pages[pageNb] = { spos = {}, qnbs = {} }
  pages[pageNb].spos.nbs = nbs
  local p = pages[pageNb]
  for i = 1, nbs do
    p.spos[i] = { math.random(100,700), math.random(100, 500), math.random(30, 80)}
    p.qnbs[i] = math.random(1, quotes.len)
  end 
  nbpcr = nbpcr + 1 
end

function tmd.changePage()
  if pageNb > nbpcr and pageNb <= 12 then 
    tmd.createPage() 
  end
end

function tmd.drawPage()
  if pageNb < 1 or pageNb > 12 then return end
  local i = 1
  for i = 1, pages[pageNb].spos.nbs do
    local pos = pages[pageNb].spos[i]
    -- tmd.drawstar(tmd.spos[i][1], tmd.spos[i][2], tmd.spos[i][3])
    tmd.drawstar(pos[1], pos[2], pos[3])
  end
  if scinfo.clicked then
    local qt = quotes[pages[pageNb].qnbs[scinfo.nb]]
    if qt then gr.print(qt, 10, 10) end
    scinfo.time = scinfo.time - 1
    if scinfo.time == 0 then 
      scinfo.clicked = false
      -- tmd.scinfo.nb = 0 
    end
  end
  gr.print("Prev", 5, h-24)
  gr.print("-"..pageNb.."-", w/2-40, h-24)
  gr.print("Next", w-40, h-24)
end

function tmd.neprclicked(x,y) -- next or prev page clicked
  local changed = false
  if x < 100 and y > h-100 then 
    do
      if pageNb == 1 then return end
      pageNb = pageNb - 1
      changed = true
    end
  elseif x > w-100 and y > h-100 then 
    do
      if pageNb == 12 then return end
      pageNb = pageNb + 1
      changed = true
    end
  end
  if changed then tmd.changePage() end
end

function tmd.drawstar(x, y, w)
  local w2 = w/2
  local sp13 = w*0.87 -- sin pi/3
  gr.polygon("fill", x,y, x+w,y, x+w2,y+sp13)
  gr.polygon("fill", x,y+w2, x+w,y+w2, x+w2,y+w2-sp13)
end

function tmd.starclicked(x, y)
  if pageNb < 1 or pageNb > 12 then return end
  for i = 1, pages[pageNb].spos.nbs do
    local sx = pages[pageNb].spos[i][1]
    local sy = pages[pageNb].spos[i][2] 
    local sw = pages[pageNb].spos[i][3]
    if sx <= x and x <= sx+sw and sy <= y and y <= sy+sw then
      scinfo.clicked = true
      scinfo.nb = i
      scinfo.time = 30
    end
  end
end

function tmd.clicked(x, y)
  tmd.neprclicked(x, y)
  tmd.starclicked(x, y)
end

return tmd
