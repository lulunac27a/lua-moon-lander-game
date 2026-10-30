function love.load()                                --load assets and initialize variables
    love.window.setTitle("Lunar Lander Game")       --set window title
    love.window.setMode(800, 600)                   --set window size
    player = { x = 400, y = 50, vy = 0, size = 20 } --initialize player properties
    gravity = 400                                   --set gravity value
    jumpForce = -250                                --set jump force value
    groundHeight = 550                              --set ground height
    score = 0                                       --initialize score
    gameOver = false                                --initialize game over state
end

function love.update(dt)                 --update game state
    if gameOver then return end          --stop updating if game is over

    player.vy = player.vy + gravity * dt --set player position and velocity
    player.y = player.y + player.vy * dt

    -- Bounce or land on the ground
    if player.y + player.size > groundHeight then --check if player y axis reaches height
        player.y = groundHeight - player.size     --decrease player y axis
        player.vy = 0                             --reset player velocity
        gameOver = true                           --set game over state to true
    end
end

function love.keypressed(key)               --when key is pressed
    if key == "space" and not gameOver then --when space key is pressed
        player.vy = jumpForce               --increase player y axis
        score = score + 1                   --increase score
    elseif key == "r" and gameOver then     --when r key is pressed
        love.load()                         --load game
    end
end

function love.draw() --draw canvas
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
    love.graphics.print("Press SPACE to thrust up! | Score: " .. score, 20, 20) --print score display

    if gameOver then
        love.graphics.print("CRASHED! Press 'R' to restart.", 350, 300) --display text if game over
    end
end
