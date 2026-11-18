--[[
  Brightness
  by Rusty Robison.

  Brightness is the relative lightness or darkness of a color.
  Move the cursor vertically over each bar to alter its brightness.
]]

local barWidth = 20
local lastBar = -1

function setup()
  size(640, 360)
  colorMode(HSB, width, 100, height)
  noStroke()
  background(0)
end

function draw()
  local whichBar = mouseX // barWidth
  if whichBar ~= lastBar then
    local barX = whichBar * barWidth
    fill(barX, 100, mouseY)
    rect(barX, 0, barWidth, height)
    lastBar = whichBar
  end
end
