--[[
  Regular Polygon

  What is your favorite? Pentagon? Hexagon? Heptagon?
  No? What about the icosagon? The polygon() function
  created for this example is capable of drawing any
  regular polygon. Try placing different numbers into the
  polygon() function calls within draw() to explore.
]]

function setup()
  size(640, 360)
end

function draw()
  background(102)

  pushMatrix()
  translate(width * 0.2, height * 0.5)
  rotate(frameCount / 200.0)
  polygon(0, 0, 82, 3)  -- Triangle
  popMatrix()

  pushMatrix()
  translate(width * 0.5, height * 0.5)
  rotate(frameCount / 50.0)
  polygon(0, 0, 80, 20)  -- Icosagon
  popMatrix()

  pushMatrix()
  translate(width * 0.8, height * 0.5)
  rotate(frameCount / -100.0)
  polygon(0, 0, 70, 7)  -- Heptagon
  popMatrix()
end

function polygon(x, y, radius, npoints)
  local angle = TWO_PI / npoints
  beginShape()
  for a = 0, TWO_PI - 1, angle do
    local sx = x + cos(a) * radius
    local sy = y + sin(a) * radius
    vertex(sx, sy)
  end
  endShape(CLOSE)
end
