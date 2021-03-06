
function balls_factory()
	-- Creatinf all balls
	if ball_ID < num_ball then
		create_ball(ball_ID)
		ball_ID = ball_ID + 1
	end

	for i = 0 , ball_ID-1 do
		if balls[i] ~= nil then
			-- Delete balls out of the screen
			if balls[i].posX < -balls[i].width or balls[i].posX > 800+balls[i].width or
			 balls[i].posY < -balls[i].height or balls[i].posY > 800+balls[i].height then
				--table.remove(balls, i)
				create_ball(i)
				score = score + 1

				if score >= nextLevel then
					nextLevel = nextLevel + 5
					level = level + 1
					num_ball = num_ball+1
				end
			else
				love.graphics.draw(ballImage, balls[i].posX, balls[i].posY)
				--love.graphics.rectangle( "fill", balls[i].posX, balls[i].posY, balls[i].width, balls[i].height)
			end

		end
	end
end

function balls_move()
	-- Define the movement of the balls
	for i = 0, ball_ID-1 do
		if balls[i] ~= nil then
			balls[i].posX = balls[i].posX + balls[i].vel * math.cos(balls[i].ang)
			balls[i].posY = balls[i].posY + balls[i].vel * math.sin(balls[i].ang)
			
			if collisionFlag==1 then detect_collision(i) end
		end
		
	end
	collisionFlag = 1
end

function create_ball(index)
	-- Draw where the ball will born
	position = math.random(0, 4)
	if position == 0 then -- ball from upside
		balls[index] = {posX = math.random(0, 800), posY = -64, width = 64, height = 64,  vel = math.random(2, 3),
		 ang = math.random( math.pi / 6, (math.pi * 5) / 6)}
	elseif position == 2 then -- ball from downside
		balls[index] = {posX = math.random(0, 800), posY = 663, width = 64, height = 64,  vel = math.random(2, 3),
		 ang = math.random( (math.pi * 7) / 6, (math.pi * 11) / 6)}
	elseif position == 3 then -- ball from left side
		balls[index] = {posX = -64, posY = math.random(0, 600), width = 64, height = 64,  vel = math.random(2, 3),
		 ang = math.random( -math.pi / 3, math.pi / 3)}
	elseif position == 4 then -- ball from right side
		balls[index] = {posX = 864, posY = math.random(0, 600), width = 64, height = 64,  vel = math.random(2, 3),
		 ang = math.random( (math.pi * 2) / 3, (math.pi * 4) / 3)} 
	end
end

function detect_collision(index)
	-- See if the player was cought
	originX = (balls[index].posX+32)
	originY = (balls[index].posY+32)

	if math.sqrt( (originX-(collision_rect.posX))*(originX-(collision_rect.posX)) + 
		(originY-(collision_rect.posY))*(originY-(collision_rect.posY)) ) < 32 or
		 
		 math.sqrt( (originX-(collision_rect.posX+collision_rect.width))*(originX-(collision_rect.posX+collision_rect.width)) +
		  (originY-(collision_rect.posY))*(originY-(collision_rect.posY)) ) < 32 or
		 
		 math.sqrt( (originX-(collision_rect.posX))*(originX-(collision_rect.posX)) + 
		 	(originY-(collision_rect.posY+collision_rect.height))*(originY-(collision_rect.posY+collision_rect.height)) ) < 32 or 
		 
		 math.sqrt( (originX-(collision_rect.posX+collision_rect.width))*(originX-(collision_rect.posX+collision_rect.width)) +
		 	(originY-(collision_rect.posY+collision_rect.height))*(originY-(collision_rect.posY+collision_rect.height)) ) < 32 then

		print ("collision")

		flagLiveSong = 1

		if lastIndex ~= index then
			lives = lives - 1
			lastIndex = index
			collisionFlag = 0
			player.posX = 400
			player.posY = 300
		end
	end
end