--[[
  Star

  The star() function created for this example is capable of drawing a
  wide range of different forms. Try placing different numbers into the
  star() function calls within draw() to explore.
]]

function setup()
  size(640, 360)
end

function draw()
  background(102)

  pushMatrix()
  translate(width * 0.2, height * 0.5)
  rotate(frameCount / 200.0)
  star(0, 0, 5, 70, 3)
  popMatrix()

  pushMatrix()
  translate(width * 0.5, height * 0.5)
  rotate(frameCount / 400.0)
  star(0, 0, 80, 100, 40)
  popMatrix()

  pushMatrix()
  translate(width * 0.8, height * 0.5)
  rotate(frameCount / -100.0)
  star(0, 0, 30, 70, 5)
  popMatrix()
end

function star(x, y, radius1, radius2, npoints)
  local angle = TWO_PI / npoints
  local halfAngle = angle / 2.0
  beginShape()
  for a = 0, TWO_PI - 1, angle do
    local sx = x + cos(a) * radius2
    local sy = y + sin(a) * radius2
    vertex(sx, sy)
    sx = x + cos(a + halfAngle) * radius1
    sy = y + sin(a + halfAngle) * radius1
    vertex(sx, sy)
  end
  endShape(CLOSE)
end
