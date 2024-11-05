local anim8 = require 'anim8'


function love.load()
    x = 100
    y = 0
    imgScale = .5
    velocityX = 300
    velocityY = 300
    font = love.graphics.newFont("/assets/font/OMORI_GAME2.ttf", 48, "normal")
    -- spritesheet
    bagel_spritesheet = love.graphics.newImage("/assets/spritesheet/bagel_animated.png")
    grid = anim8.newGrid(360, 360, 1080, 360)
    animation = anim8.newAnimation(grid('1-3', 1), 0.1)

    -- sound
    yippeee = love.audio.newSource("/assets/sfx/yippee-tbh.mp3", "static")

    -- music files
    musicFiles = {}
    musicToPlay = {}
    bgmDirectory = "/assets/sfx/bgm"
    local files = love.filesystem.getDirectoryItems(bgmDirectory)
    for _, file in ipairs(files) do
        if file:match("%.mp3$") or file:match("%.ogg$") then
            table.insert(musicFiles, file)
            table.insert(musicToPlay, love.audio.newSource(bgmDirectory .. "/" .. file, "stream"))
        end
    end

    for index, value in ipairs(musicToPlay) do
        print(value)
    end

    currentSongIndex = 1

    -- graphics
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    image = love.graphics.newImage("/assets/bagel.png")

    -- particles
    psystem = love.graphics.newParticleSystem(image, 32)
    psystem:setParticleLifetime(1, 10)
    psystem:setLinearAcceleration(-200, -200, 200, 200)
    psystem:setQuads(grid)
end

function love.update(dt)
    -- spritesheet animation
    animation:update(dt)

    x = x + velocityX * dt
    y = y + velocityY * dt
    if x >= width - image:getWidth() * imgScale then
        velocityX = -300
    elseif x <= 0 then
        velocityX = 300
    end
    if y >= height - image:getHeight() * imgScale then
        velocityY = -300
    elseif y <= 0 then
        velocityY = 300
    end
    psystem:update(dt)
    love.mousePressed()
    playMusic()
end

function love.draw()
    love.graphics.setFont(font)
    -- bagel animated
    love.graphics.print("currently playing: " .. musicFiles[currentSongIndex], 600, 100)
    love.graphics.print("R: restart", 100, 50)
    love.graphics.print("esc: exit", 100, 100)
    love.graphics.print("2: next song", 100, 150)
    animation:draw(bagel_spritesheet, x, y, 0, imgScale, imgScale)
    -- love.graphics.draw(image, 100, 100, 0, x/200, y/200)
    love.graphics.draw(psystem, mx, my)

    -- draw song info and controls and stuff on screen

   


end

function love.mousePressed()
    if love.mouse.isDown(1) then
        mx, my = love.mouse.getPosition()
        psystem:emit(32)
        yippeee:play()
    end
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
    if k == 'r' then
        love.event.quit("")
    end
    if k == '2' then
        nextSong()
    end
end

function playMusic()
    if not musicToPlay[currentSongIndex]:isPlaying() then
        nextSong()
    end
end

function incrementSongIndex()
    if currentSongIndex < #musicToPlay then
        currentSongIndex = currentSongIndex + 1
    else
        currentSongIndex = 1
    end
end

function nextSong()
    love.audio.stop(musicToPlay[currentSongIndex])
    incrementSongIndex()
    love.audio.play(musicToPlay[currentSongIndex])
end

-- very important
example = function()
    print("lumi is cute :3 ")
end

example()
