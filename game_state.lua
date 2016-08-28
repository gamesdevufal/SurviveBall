
function window_state()
	-- Timer management
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
	end
	love.timer.sleep(next_time - cur_time)	
	
	-- Sound that plays each 50 points scored
	if( (score+1)%50 == 0 ) then flagTenScore = 1 end	
	
	-- Check if the game is over
	if lives <= 0 then print("The game is over...") lives = 0 game_state = 3 end
	
	if game_state == 0 then
		--Draw the start button.
		love.graphics.draw(initScreen, 0, 0)
		--love.graphics.rectangle( "fill", 300, 400, 200, 100)\
		flagBgSong = 1
		
	elseif game_state == 1 then
		love.graphics.draw(floorScreen, 0, 0)

		-- Drawing stuff
		love.graphics.print("Score: "..tostring(score), 10, 10)
		love.graphics.print("Lives left: "..tostring(lives), 10, 20)
		animations[player.direction]:draw(heroImage, player.posX, player.posY)
		--love.graphics.setColor(255, 50, 50)
		--love.graphics.rectangle( "fill", player.posX, player.posY, player.width, player.height)
		love.graphics.setColor(255, 255, 255)
		balls_factory()
		flagBgSong = 2
	elseif game_state == 3 then
		flagBgSong = 3

	end
	
	
	
end

function treat_mouse( x, y )
	if game_state == 0 then
		--See if the start button was clicked.
		if 365 < x and x < 475 and 510 < y and y < 565 then
			print("Star button clicked")
			game_state = 1
		end
	end
end

function treat_keyboard()
	if game_state == 1 then
		-- Moving the hero
		if love.keyboard.isDown('up') and player.posY > 0 then 
			player.posY = player.posY - player.vel
			player.direction = 4
		elseif love.keyboard.isDown('down') and player.posY < 600 - player.height then 
			player.posY = player.posY + player.vel
			player.direction = 1
		elseif love.keyboard.isDown('left') and player.posX > 0 then 
			player.posX = player.posX - player.vel
			player.direction = 2
		elseif love.keyboard.isDown('right') and player.posX < 800 - player.width then 
			player.posX = player.posX + player.vel
			player.direction = 3
		end
	end
end