function love.load()
    player = { x = 400, y = 50, vy = 0, size = 20 }
    gravity = 400
    jumpForce = -250
    groundHeight = 550
    score = 0
    gameOver = false
end

function love.update(dt)
    if gameOver then return end

    player.vy = player.vy + gravity * dt
    player.y = player.y + player.vy * dt

    -- Bounce or land on the ground
    if player.y + player.size > groundHeight then
        player.y = groundHeight - player.size
        player.vy = 0
        gameOver = true
    end
end

function love.keypressed(key)
    if key == "space" and not gameOver then
        player.vy = jumpForce
        score = score + 1
    elseif key == "r" and gameOver then
        love.load()
    end
end

function love.draw()
    -- Draw moon-like gray background
    love.graphics.clear(0.1, 0.1, 0.15)

    -- Draw the player (Lunar lander / ship)
    love.graphics.setColor(0.9, 0.9, 1)
    love.graphics.rectangle("fill", player.x - player.size / 2, player.y - player.size / 2, player.size, player.size)

    -- Draw ground surface
    love.graphics.setColor(0.5, 0.5, 0.6)
    love.graphics.rectangle("fill", 0, groundHeight, 800, 50)

    -- Instructions & Score
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Press SPACE to thrust up! | Score: " .. score, 20, 20)

    if gameOver then
        love.graphics.print("CRASHED! Press 'R' to restart.", 350, 300)
    end
end
