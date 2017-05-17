function love.load()
  player1 = {
    x = 0,
    y = love.graphics.getHeight()/2 - 75;
    height = 150,
    width = 15
  }

  player2 = {
    x = love.graphics.getWidth() - 15,
    y = love.graphics.getHeight()/2 - 75;
    height = 150,
    width = 15
  }

  ball = {
      x = player1.width,
      y = player1.y - 7.5 + player1.height / 2,
      height = 15,
      width = 15,
      speed = 5,
      x_direction = 'r',
      y_direction = 'u'
  }
end

function love.update(dt)

  player1_move()

  player2_move()

  ball_movement()

end

function love.draw()
  love.graphics.rectangle('fill', player1.x,
  player1.y, player1.width, player1.height)

  love.graphics.rectangle('fill', player2.x,
  player2.y, player2.width, player2.height)

  love.graphics.rectangle('fill', ball.x,
  ball.y, ball.width, ball.height)
end

function player1_move()

  if love.keyboard.isDown('w') then
    if colision_top(player1) == false then
      player1.y = player1.y - 10
    end
  end

  if love.keyboard.isDown('s') then
    if colision_bottom(player1) == false then
      player1.y = player1.y + 10
    end
  end
end

function player2_move()

  if love.keyboard.isDown('up') then
    if colision_top(player2) == false then
      player2.y = player2.y - 10
    end
  end

  if love.keyboard.isDown('down') then
    if colision_bottom(player2) == false then
      player2.y = player2.y + 10
    end
  end
end

function ball_movement()

  if ball.x_direction == 'r' and ball.y_direction == 'u' then
    ball.y = ball.y - 0.75 * ball.speed
    ball.x = ball.x + 1 * ball.speed
  end

  if ball.x_direction == 'r' and ball.y_direction == 'd' then
    ball.y = ball.y + 0.75 * ball.speed
    ball.x = ball.x + 1 * ball.speed
  end

end

function colision_top(obj)
  if obj.y <= 0 then
    return true
  end
  return false
end

function colision_bottom(obj)
  if obj.y + obj.height >= love.graphics.getHeight() then
    return true
  end
  return false
end
