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
      x = player1.width + 1,
      y = player1.y - 7.5 + player1.height / 2,
      height = 15,
      width = 15,
      speed = 5,
      angle = 60,
      x_direction = '',
      y_direction = ''
  }

  ball2 = {
      x = player1.width + 1,
      y = player1.y - 7.5 + player1.height / 2,
      height = 15,
      width = 15,
      speed = 5,
      angle = 60,
      x_direction = '',
      y_direction = ''
  }

  game_over_text = ""
  max_points = 1
  max_speed = 15
  is_ended = false
  temp = true

  player_sound = love.audio.newSource("player.ogg")
  screen_sound = love.audio.newSource("screen.ogg")
  score_sound = love.audio.newSource("score.ogg")
  love.graphics.setFont(love.graphics.newFont(80))
end

function love.update(dt)
  control_keys()
  speed_increase()
  ball_movement()
  player_ball_colision()
  calculate()
end

function love.draw()

  love.graphics.rectangle('fill', player1.x,
  player1.y, player1.width, player1.height)

  love.graphics.rectangle('fill', player2.x,
  player2.y, player2.width, player2.height)

  love.graphics.rectangle('fill', ball.x,
  ball.y, ball.width, ball.height)

  love.graphics.rectangle('fill', ball2.x,
  ball2.y, ball2.width, ball2.height)

  love.graphics.rectangle('fill', love.graphics.getWidth()/2 + 1.5, 0, 3,
  love.graphics.getHeight())
  love.graphics.print(player1.score, love.graphics.getWidth() * 0.25 - 40, 20)
  love.graphics.print(player2.score, love.graphics.getWidth() * 0.75 - 20, 20)
  love.graphics.printf(game_over_text, 0, love.graphics.getHeight() * 0.25, love.graphics.getWidth(), 'center')

end

function speed_increase()
  if ball.speed <= max_speed then
    ball.speed = ball.speed + 0.016
  end
end

function player1_move()

  if love.keyboard.isDown('w') then
    if not colision_top(player1) then
      player1.y = player1.y - 10
    end
  end

  if love.keyboard.isDown('s') then
    if not colision_bottom(player1) then
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

function calculate()
  if temp then
    x = ball.y / math.cos(math.rad(45))
    ball2.x = x
    ball2.y = 0
    temp = false
  end
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
  return obj.y <= 0
end

function colision_bottom(obj)
  return obj.y + obj.height >= love.graphics.getHeight()
end

function colision_left(obj)
  return obj.x <= 0
end

function colision_right(obj)
  return obj.x + obj.width >= love.graphics.getWidth()
end

function colision_ball_vertical(obj)
  if colision_top(obj) then
    obj.y_direction = 'd'
    screen_sound:play()
  elseif colision_bottom(obj) == true then
    obj.y_direction = 'u'
    screen_sound:play()
  end
end

function count_points (player)
  player.score = player.score  + 1
  if player.score >= max_points then
    game_over_text = "Fim de Jogo \nPressione o ENTER"
    is_ended = true
  end
end

function restart_game()
  if love.keyboard.isDown("return") then
    player1.score = 0
    player2.score = 0
    game_over_text = ""
    is_ended = false
    player1.y = love.graphics.getHeight()/2 - 75
    player2.y = love.graphics.getHeight()/2 - 75
  end
end

function control_keys()
  if not is_ended then
    player1_move()
    player2_move()
    start_game()
  else
    restart_game()
  end
end

function colision_ball_horizontal(obj)
  if colision_right(ball) then
    score_sound:play()
    count_points(player1)
    ball.x_direction = ''
    ball.y_direction = ''
    ball.x = player1.width + 1
    ball.y = player1.y - 7.5 + player1.height / 2

  elseif colision_left(ball) then
    count_points(player2)
    score_sound:play()
    ball.x_direction = ''
    ball.y_direction = ''
    ball.x = player2.x - ball.width - 1
    ball.y = player2.y - 7.5 + player2.height / 2
  end
end

function player_ball_colision(obj)
  if ball.x + ball.width >= player2.x and
    ball.y + ball.height >= player2.y and
      ball.y < player2.y + player2.height then
        ball.x_direction = 'l'
        player_sound:play()
  end

  if ball.x <= player1.x + player1.width and
    ball.y + ball.height >= player1.y and
      ball.y < player1.y + player1.height then
        ball.x_direction = 'r'
        player_sound:play()
  end
end

function start_game()
  if(love.keyboard.isDown(' ')) then
    if ball.x_direction == '' or ball.y_direction == '' then
      if ball.x == player1.width + 1 then
        ball.x_direction = 'r'
        ball.y_direction = 'u'
        ball.speed = 5
      end
    end

    if ball.x_direction == '' or ball.y_direction == '' then
      if ball.x == player2.x - ball.width -1 then
        ball.x_direction = 'l'
        ball.y_direction = 'u'
        ball.speed = 5
      end
    end
  end
end

function ball_at_player_movement()
  if ball.x_direction == '' and ball.y_direction == '' then
    if ball.x == player1.width +1 then
      ball.y = player1.y - 7.5 + player1.height / 2
    elseif ball.x + ball.width == player2.x -1 then
      ball.y = player2.y - 7.5 + player2.height / 2
    end
  end
end
