function love.load()
  player1 = {
    x = 0,
    y = love.graphics.getHeight()/2 - 75,
    height = 150,
    width = 15,
    score = 0
  }

  player2 = {
    x = love.graphics.getWidth() - 15,
    y = love.graphics.getHeight()/2 - 75,
    height = 150,
    width = 15,
    score = 0
  }

  ball = {
      x = player1.width,
      --x = 600,
      y = player1.y - 7.5 + player1.height / 2,
      height = 15,
      width = 15,
      speed = 5,
      x_direction = '',
      y_direction = ''
  }
end

function love.update(dt)

  player1_move()
  player2_move()
  ball_movement()
  start_game()
  player_ball_colision()

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

  ball_at_player_movement()
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

  ball_at_player_movement()
end

function ball_movement()
  colision_ball_vertical(ball)
  colision_ball_horizontal(ball)

  if ball.x_direction == 'r' and ball.y_direction == 'u' then
    ball.y = ball.y - 0.75 * ball.speed
    ball.x = ball.x + 1 * ball.speed
  end

  if ball.x_direction == 'r' and ball.y_direction == 'd' then
    ball.y = ball.y + 0.75 * ball.speed
    ball.x = ball.x + 1 * ball.speed
  end

  if ball.x_direction == 'l' and ball.y_direction == 'u' then
    ball.y = ball.y - 0.75 * ball.speed
    ball.x = ball.x - 1 * ball.speed
  end

  if ball.x_direction == 'l' and ball.y_direction == 'd' then
    ball.y = ball.y + 0.75 * ball.speed
    ball.x = ball.x - 1 * ball.speed
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

function colision_left(obj)
  if obj.x == 0 then
    return true
  end
  return false
end

function colision_right(obj)
  if obj.x + obj.width == love.graphics.getWidth() then
    return true
  end
  return false
end

function colision_ball_vertical(obj)
  if colision_top(obj) == true then
    obj.y_direction = 'd'
  elseif colision_bottom(obj) == true then
    obj.y_direction = 'u'
  end
end

function colision_ball_horizontal(obj)
  if colision_right(obj) == true then
    obj.x_direction = ''
    obj.y_direction = ''
    obj.x = player1.width
    obj.y = player1.y - 7.5 + player1.height / 2

  elseif colision_left(obj) == true then
    obj.x_direction = ''
    obj.y_direction = ''
    obj.x = player2.x - obj.width
    obj.y = player2.y - 7.5 + player2.height / 2
  end
end

function player_ball_colision(obj)
  if ball.x + ball.width >= player2.x and
    ball.y - ball.height > player2.y and
      ball.y < player2.y + player2.height then
        ball.x_direction = 'l'
  end
end

function start_game()
  if(love.keyboard.isDown(' ')) then
    if ball.x_direction == '' or ball.y_direction == '' then
      if ball.x == player1.width + 1 then
        ball.x_direction = 'r'
        ball.y_direction = 'u'
      end
    end

    if ball.x_direction == '' or ball.y_direction == '' then
      if ball.x == player2.x - ball.width - 1 then
        ball.x_direction = 'l'
        ball.y_direction = 'u'
      end
    end
  end
end

function ball_at_player_movement()
  if ball.x_direction == '' and ball.y_direction == '' then
    if ball.x == player1.width then
      ball.y = player1.y - 7.5 + player1.height / 2
    elseif ball.x == player2.x - ball.width then
      ball.y = player2.y - 7.5 + player2.height / 2
    end
  end

end
