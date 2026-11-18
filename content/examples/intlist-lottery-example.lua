--[[
  IntList Lottery example
  by Daniel Shiffman.

  This example demonstrates an IntList can be used to store a list of numbers.
  While an array of integers serves a similar purpose it is of fixed size.  The
  An IntList can easily have values added or deleted and it can also be
  shuffled and sorted.  For lists of floats or Strings, you can use FloatList
  and StringList.  For lists of objects, use ArrayList.

  In this example, three lists of integers are created.  One is a pool of numbers
  that is shuffled and picked randomly from.  One is the list of "picked" numbers.
  And one is a lottery "ticket" which includes 5 numbers that are trying to be matched.
]]

-- Three lists of integers
local lottery
local results
local ticket

function setup()
  size(640, 360)
  frameRate(30)
  -- Create empy lists
  lottery = IntList()
  results = IntList()
  ticket = IntList()

  -- Add 20 integers in order to the lottery list
  for i = 0, 19 do
    lottery:append(i)
  end

  -- Pick five numbers from the lottery list to go into the Ticket list
  for i = 1, 5 do
    local index = int(random(lottery:size()))
    ticket:append(lottery:get(index))
  end
end

function draw()
  background(51)

  -- The shuffle() method randomly shuffles the order of the values in the list
  lottery:shuffle()

  -- Call a method that will display the integers in the list at an x,y location
  showList(lottery, 16, 48)
  showList(results, 16, 100)
  showList(ticket, 16, 140)

  -- This loop checks if the picked numbers (results)
  -- match the ticket numbers
  for i = 0, results:size() - 1 do
    -- Are the integers equal?
    if results:get(i) == ticket:get(i) then
      fill(0, 255, 0, 100)  -- if so green
    else
      fill(255, 0, 0, 100)  -- if not red
    end
    ellipse(16 + i * 32, 140, 24, 24)
  end

  -- One every 30 frames we pick a new lottery number to go in results
  if frameCount % 30 == 0 then
    if results:size() < 5 then
      -- Get the first value in the lottery list and remove it
      local val = lottery:remove(0)
      -- Put it in the results
      results:append(val)
    else
      -- Ok we picked five numbers, let's reset
      for i = 0, results:size() - 1 do
        -- Put the picked results back into the lottery
        lottery:append(results:get(i))
      end
      -- Clear the results and start over
      results:clear()
    end
  end
end

-- Draw a list of numbers starting at an x,y location
function showList(list, x, y)
  for i = 0, list:size() - 1 do
    -- Use get() to pull a value from the list at the specified index
    local val = list:get(i)
    stroke(255)
    noFill()
    ellipse(x + i * 32, y, 24, 24)
    textAlign(CENTER)
    fill(255)
    text(val, x + i * 32, y + 6)
  end
end
