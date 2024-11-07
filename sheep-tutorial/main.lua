anim8 = require('anim8')

function love.load()
    player = {}
    player.moveSpeed = 100
    player.image = love.graphics.newImage('/assets/spritesheet.png')

    player.g = anim8.newGrid(64, 128, player.image:getWidth(), player.image:getHeight())

    player.animations = {
        walkRight = anim8.newAnimation(player.g('2-10',1), .1),
        walkLeft = anim8.newAnimation(player.g('2-10', 2), .1),
        idleLeft = anim8.newAnimation(player.g('1-1', 2), .1),
        idleRight = anim8.newAnimation(player.g('1-1', 1), .1),
    }

    player.facingLeft=false
    player.facingRight = true
    player.walkingRight=false
    player.walkingLeft = false
    player.y = 200
    player.x = 10

end



function love.update(dt)
    if love.keyboard.isDown("right") then
        player.x = player.x + player.moveSpeed * dt
        player.facingLeft = false
        player.facingRight = true
        player.walkingLeft = false
        player.walkingRight = true
    elseif love.keyboard.isDown("left") then
        player.x = player.x - player.moveSpeed * dt
        player.walkingLeft = true
        player.walkingRight = false
        player.facingLeft = true
        player.facingRight = false
    else
        player.walkingLeft = false
        player.walkingRight = false
    end
    if player.walkingRight then
        player.animations.walkRight:update(dt)
    elseif player.walkingLeft then
        player.animations.walkLeft:update(dt)
    elseif player.facingRight then
        player.animations.idleRight:update(dt)
    elseif player.facingLeft then
        player.animations.idleLeft:update(dt)
    end
end

function love.draw()
    if player.facingLeft then
        if player.walkingLeft then 
            player.animations.walkLeft:draw(player.image, player.x, player.y, 0, 1, 1)
        else
            player.animations.idleLeft:draw(player.image, player.x, player.y, 0, 1, 1)
        end
    elseif player.facingRight then
        if player.walkingRight then
            player.animations.walkRight:draw(player.image, player.x, player.y)
        else
            player.animations.idleRight:draw(player.image, player.x, player.y)
        end
    end
end
