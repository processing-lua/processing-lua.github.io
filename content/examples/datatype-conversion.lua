--[[
  Datatype Conversion.

  It is sometimes beneficial to convert a value from one type of
  data to another. Each of the conversion functions converts its parameter
  to an equivalent representation within its datatype.
  The conversion functions include int(), float(), char(), byte(), and others.
]]

function setup()
  size(640, 360)
  background(0)
  noStroke()

  textFont(createFont("SourceCodePro-Regular.ttf", 24))

  local c  -- Chars are used for storing alphanumeric symbols
  local f  -- Floats are decimal numbers
  local i  -- Integers are values between 2,147,483,647 and -2147483648
  local b  -- Bytes are values between -128 and 127

  c = "A"
  f = string.byte(c) + 0.0  -- Sets f = 65.0 (a letter is text in Lua, string.byte gives its code)
  i = int(f * 1.4)  -- Sets i to 91
  b = byte(string.byte(c) // 2)  -- Sets b to 32

  --println(f);
  --println(i);
  --println(b);

  text("The value of variable c is " .. c, 50, 100)
  text("The value of variable f is " .. f, 50, 150)
  text("The value of variable i is " .. i, 50, 200)
  text("The value of variable b is " .. b, 50, 250)
end
