--[[
  Pie Chart

  Uses the arc() function to generate a pie chart from the data
  stored in an array.
]]

local angles = {30, 10, 45, 35, 60, 38, 75, 67}

function setup()
  size(640, 360)
  noStroke()
  noLoop()  -- Run once and stop
end

function draw()
  background(100)
  pieChart(300, angles)
end

function pieChart(diameter, data)
  local lastAngle = 0
  for i = 0, #data - 1 do
    local gray = map(i, 0, #data, 0, 255)
    fill(gray)
    arc(width / 2, height / 2, diameter, diameter, lastAngle, lastAngle + radians(data[i + 1]))
    lastAngle = lastAngle + radians(data[i + 1])
  end
end
