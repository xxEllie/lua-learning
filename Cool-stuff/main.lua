local ffi = require("ffi")
local bit = require("bit")
ffi.cdef[[
    void* GetActiveWindow();    
    int SetWindowPos(void* hWnd, int hWndInsertAfter, int X, int Y, int cx, int cy, unsigned int uFlags);
    int SetWindowLongA(void* hWnd, int nIndex, long dwNewLong);
    long GetWindowLongA(void* hWnd, int nIndex);
    bool SetLayeredWindowAttributes(void* hwnd, int crKey, unsigned char bAlpha, int dwFlags);
]]
local bagel
local hwnd = ffi.C.GetActiveWindow()
local SWP_NOSIZE = 0x0001
local HWND_TOP = 0
local GWL_EXSTYLE = -20
local WS_EX_LAYERED = 0x80000
local WS_EX_TRANSPARENT = 0x20
local LWA_COLORKEY = 0x1

local function setWindowPosition(x, y)
    ffi.C.SetWindowPos(hwnd, HWND_TOP, x, y, 0, 0, SWP_NOSIZE)
end


local gravity = 500
local velocity = 0
local windowX, windowY = 100, 100
local floorY = 600
local moveSpeed = 400
function love.load()
    bagel = love.graphics.newImage("/assets/bagel.png")

    local exStyle = ffi.C.GetWindowLongA(hwnd, GWL_EXSTYLE)
    ffi.C.SetWindowLongA(hwnd, GWL_EXSTYLE, bit.bor(exStyle, WS_EX_LAYERED, WS_EX_TRANSPARENT))
    ffi.C.SetLayeredWindowAttributes(hwnd, 0x000000, 0, LWA_COLORKEY)
end

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

function love.draw()
    love.graphics.draw(bagel, 0, 0)
end
