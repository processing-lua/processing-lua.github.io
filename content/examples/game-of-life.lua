--[[
  Game of Life
  by Joan Soler-Adillon.

  Press SPACE BAR to pause and change the cell's values
  with the mouse. On pause, click to activate/deactivate
  cells. Press 'R' to randomly reset the cells' grid.
  Press 'C' to clear the cells' grid. The original Game
  of Life was created by John Conway in 1970.
]]

-- a table of n values, counted from 1 (rows of tables for more sizes)
local function newArray(n, ...)
  local t = {}
  for i = 1, n do
    if select("#", ...) > 1 then t[i] = newArray(...) else t[i] = (...) end
  end
  return t
end

-- Size of cells
local cellSize = 5

-- How likely for a cell to be alive at start (in percentage)
local probabilityOfAliveAtStart = 15

-- Variables for timer
local interval = 100
local lastRecordedTime = 0

-- Colors for active/inactive cells
local alive = color(0, 200, 0)
local dead = color(0)

-- Array of cells
local cells
-- Buffer to record the state of the cells and use this
-- while changing the others in the interations
local cellsBuffer

-- Pause
local pause = false

function setup()
  size(640, 360)

  -- Instantiate arrays
  cells = newArray(width // cellSize, height // cellSize, 0)
  cellsBuffer = newArray(width // cellSize, height // cellSize, 0)

  -- This stroke will draw the background grid
  stroke(48)

  noSmooth()

  -- Initialization of cells
  for x = 1, width // cellSize do
    for y = 1, height // cellSize do
      local state = random(100)
      if state > probabilityOfAliveAtStart then
        state = 0
      else
        state = 1
      end
      cells[x][y] = int(state)  -- Save state of each cell
    end
  end
  -- Fill in black in case cells don't cover all the windows
  background(0)
end

function draw()
  --Draw grid
  for x = 0, width // cellSize - 1 do
    for y = 0, height // cellSize - 1 do
      if cells[x + 1][y + 1] == 1 then
        fill(alive)  -- If alive
      else
        fill(dead)  -- If dead
      end
      rect(x * cellSize, y * cellSize, cellSize, cellSize)
    end
  end
  -- Iterate if timer ticks
  if millis() - lastRecordedTime > interval then
    if not pause then
      iteration()
      lastRecordedTime = millis()
    end
  end

  -- Create  new cells manually on pause
  if pause and mousePressed then
    -- Map and avoid out of bound errors
    local xCellOver = int(map(mouseX, 0, width, 0, width / cellSize))
    xCellOver = constrain(xCellOver, 0, width / cellSize - 1)
    local yCellOver = int(map(mouseY, 0, height, 0, height / cellSize))
    yCellOver = constrain(yCellOver, 0, height / cellSize - 1)

    -- Check against cells in buffer
    if cellsBuffer[xCellOver + 1][yCellOver + 1] == 1 then
      -- Cell is alive
      cells[xCellOver + 1][yCellOver + 1] = 0  -- Kill
      fill(dead)  -- Fill with kill color
    else
      -- Cell is dead
      cells[xCellOver + 1][yCellOver + 1] = 1  -- Make alive
      fill(alive)  -- Fill alive color
    end
  elseif pause and not mousePressed then
    -- And then save to buffer once mouse goes up
    -- Save cells to buffer (so we opeate with one array keeping the other intact)
    for x = 1, width // cellSize do
      for y = 1, height // cellSize do
        cellsBuffer[x][y] = cells[x][y]
      end
    end
  end
end

function iteration()
  -- When the clock ticks
  -- Save cells to buffer (so we opeate with one array keeping the other intact)
  for x = 1, width // cellSize do
    for y = 1, height // cellSize do
      cellsBuffer[x][y] = cells[x][y]
    end
  end

  -- Visit each cell:
  for x = 0, width // cellSize - 1 do
    for y = 0, height // cellSize - 1 do
      -- And visit all the neighbours of each cell
      local neighbours = 0  -- We'll count the neighbours
      for xx = x - 1, x + 1 do
        for yy = y - 1, y + 1 do
          if ((xx >= 0) and (xx < width / cellSize)) and ((yy >= 0) and (yy < height / cellSize)) then
            -- Make sure you are not out of bounds
            if not ((xx == x) and (yy == y)) then
              -- Make sure to to check against self
              if cellsBuffer[xx + 1][yy + 1] == 1 then
                neighbours = neighbours + 1  -- Check alive neighbours and count them
              end
            end  -- End of if
          end  -- End of if
        end  -- End of yy loop
      end  --End of xx loop
      -- We've checked the neigbours: apply rules!
      if cellsBuffer[x + 1][y + 1] == 1 then
        -- The cell is alive: kill it if necessary
        if neighbours < 2 or neighbours > 3 then
          cells[x + 1][y + 1] = 0  -- Die unless it has 2 or 3 neighbours
        end
      else
        -- The cell is dead: make it live if necessary
        if neighbours == 3 then
          cells[x + 1][y + 1] = 1  -- Only if it has 3 neighbours
        end
      end  -- End of if
    end  -- End of y loop
  end  -- End of x loop
end  -- End of function

function keyPressed()
  if key == "r" or key == "R" then
    -- Restart: reinitialization of cells
    for x = 1, width // cellSize do
      for y = 1, height // cellSize do
        local state = random(100)
        if state > probabilityOfAliveAtStart then
          state = 0
        else
          state = 1
        end
        cells[x][y] = int(state)  -- Save state of each cell
      end
    end
  end
  if key == " " then
    -- On/off of pause
    pause = not pause
  end
  if key == "c" or key == "C" then
    -- Clear all
    for x = 1, width // cellSize do
      for y = 1, height // cellSize do
        cells[x][y] = 0  -- Save all to zero
      end
    end
  end
end
