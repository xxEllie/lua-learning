local ffi = require("ffi")

ffi.cdef[[
    void* GetActiveWindow();
    int SetWindowPos(void* hWnd, int hWndInsertAfter, int X, int Y, int cx, int cy, unsigned int uFlags);
]]

local hwnd = ffi.C.GetActiveWindow()
local SWP_NOSIZE = 0x0001
local HWND_TOP = 0
local function setWindowPosition(x, y)
    ffi.C.SetWindowPos(hwnd, HWND_TOP, x, y, 0, 0, SWP_NOSIZE)
end


local gravity = 500
local velocity = 0
local windowX, windowY = 100, 100
local floorY = 600
local moveSpeed = 400

function love.update(dt)
    velocity = velocity + gravity * dt
    windowY = windowY + velocity * dt

    if windowY >= floorY then
        windowY = floorY
        velocity = 0
    end

    if love.keyboard.isDown("left") then
        windowX = windowX - moveSpeed * dt
    elseif love.keyboard.isDown("right") then
        windowX = windowX + moveSpeed * dt
    end
    if love.keyboard.isDown("up") then
        windowY = windowY - (velocity + gravity) * dt
    end
    setWindowPosition(windowX, windowY)
end

