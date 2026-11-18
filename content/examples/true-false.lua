--[[
  True/False.

  A Boolean variable has only two possible values: true or false.
  It is common to use Booleans with control statements to
  determine the flow of a program. In this example, when the
  boolean value "x" is true, vertical black lines are drawn and when
  the boolean value "x" is false, horizontal gray lines are drawn.
]]

function setup()
  local b = false

  size(640, 360)
  background(0)
  stroke(255)

  local d = 20
  local middle = width // 2

  for i = d, width, d do
    if i < middle then
      b = true
    else
      b = false
    end

    if b == true then
      -- Vertical line
      line(i, d, i, height - d)
    end

    if b == false then
      -- Horizontal line
      line(middle, i - middle + d, width - d, i - middle + d)
    end
  end
end
