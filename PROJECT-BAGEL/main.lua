
function love.load()
    x = 100
    y = 0
    imgScale = .5
    velocityX = 300
    velocityY = 300
    
    -- sound
    sound = love.audio.newSource("/assets/yippee-tbh.mp3", "static")


    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    image = love.graphics.newImage("/assets/bagel.png")
    
    -- particles
    psystem = love.graphics.newParticleSystem(image, 32)
    psystem:setParticleLifetime(1, 10)
    psystem:setLinearAcceleration(-200, -200, 200, 200)

end

function love.update(dt)
    
    function love.keypressed(k)
        if k == 'escape' then
            love.event.quit()
        end
        if k == 'r' then
            love.event.quit("")
        end
    end

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
end
function love.mousePressed()
    --this checks if you are left clicking, and if you are it runs the code under it
    if love.mouse.isDown(1) then
      --this says if the user is left clicking then emit 32 particles and since the particles are drawn where the mouse is they come out of the mouse
      psystem:emit(32)
      sound:play()
    end
end
function love.draw()
    love.graphics.draw(image, x, y, 0, imgScale, imgScale)
    -- love.graphics.draw(image, 100, 100, 0, x/200, y/200)
    love.graphics.draw(psystem, 500, 500)

end

example = function() 
    print("lumi is cute :3 ")
end

example()

