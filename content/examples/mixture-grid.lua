--[[
  Mixture Grid
  modified from an example by Simon Greenwold.

  Display a 2D grid of boxes with three different kinds of lights.
]]

function setup()
  size(640, 360, P3D)
  noStroke()
end

function draw()
  defineLights()
  background(0)

  for x = 0, width, 60 do
    for y = 0, height, 60 do
      pushMatrix()
      translate(x, y)
      rotateY(map(mouseX, 0, width, 0, PI))
      rotateX(map(mouseY, 0, height, 0, PI))
      box(90)
      popMatrix()
    end
  end
end

function defineLights()
  -- Orange point light on the right
  pointLight(150, 100, 0, 200, -150, 0)  -- Color  -- Position

  -- Blue directional light from the left
  directionalLight(0, 102, 255, 1, 0, 0)  -- Color  -- The x-, y-, z-axis direction

  -- Yellow spotlight from the front
  spotLight(255, 255, 109, 0, 40, 200, 0, -0.5, -0.5, PI / 2, 2)  -- Color, Position, Direction  -- Angle, concentration
end
