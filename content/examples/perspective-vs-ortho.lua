--[[
  Perspective vs. Ortho

  Move the mouse left to right to change the "far"
  parameter for the perspective() and ortho() functions.
  This parameter sets the maximum distance from the
  origin away from the viewer and will clip the geometry.
  Click a mouse button to switch between the perspective and
  orthographic projections.
]]

local showPerspective = false

function setup()
  size(600, 360, P3D)
  noFill()
  fill(255)
  noStroke()
end

function draw()
  lights()
  background(0)
  local far = map(mouseX, 0, width, 120, 400)
  if showPerspective == true then
    perspective(PI / 3.0, float(width) / float(height), 10, far)
  else
    ortho(-width / 2.0, width / 2.0, -height / 2.0, height / 2.0, 10, far)
  end
  translate(width / 2, height / 2, 0)
  rotateX(-PI / 6)
  rotateY(PI / 3)
  box(180)
end

function mousePressed()
  showPerspective = not showPerspective
end
