#!/usr/bin/env lua
-- this is just a command to play background music
-- when I try to use Love2d sample code to play a track of music,
-- it uses around 20%% of the cpu, while with ffplay here around 5%%,
-- eventually, when I have time, I will investigate this, but
-- for the moment, this is good enough
--
-- the two percent characters in the lua comment section seem to 
-- be needed in order to avoid to confuse locco

s = 'ffplay -hide_banner -nodisp -loop 0 chant.ogg 2>/dev/null'
os.execute(s)

-- this script assume that ffplay is installed in your system
--
-- chant.ogg is gregorian chant of the Ave Maria
