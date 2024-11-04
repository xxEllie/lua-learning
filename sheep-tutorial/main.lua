function love.load()
    x = 100
    moveSpeed = 100
    fruits = {"apples", "bananas"}
    table.insert(fruits, "pear")
end



function love.update(dt)
    if love.keyboard.isDown("right") then
        x = x + moveSpeed * dt
    elseif love.keyboard.isDown("left") then
        x = x - 100 * dt
    end
end

function love.draw()
    love.graphics.rectangle("line", x, 50, 200, 150)
    for i=1, #fruits do
        love.graphics.print(fruits[i], 100, 100 + 50 * i)
    end
end
