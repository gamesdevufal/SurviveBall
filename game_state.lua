
function window_state()
		
	if game_state == 0 then
		--Draw the start button.
		love.graphics.draw(initScreen, 0, 0)
		--love.graphics.rectangle( "fill", 300, 400, 200, 100)\
		flagBgSong = 1
		
	elseif game_state == 1 then
		love.graphics.draw(floorScreen, 0, 0)

		-- See if the player lose
		if lives == 0 then
			game_state = 2
		end

		-- Drawing stuff
		love.graphics.setColor(153, 0, 0)
		love.graphics.print("Score: "..tostring(score), 10, 10)
		love.graphics.print("Level: "..tostring(level), 10, 30)
		love.graphics.print("Lives left: "..tostring(lives), 10, 50)
		if paused then
			love.graphics.setNewFont("fonts/FFF_Tusj.ttf", 36)
			love.graphics.print("PAUSED ", 350, 280)
			love.graphics.setNewFont("fonts/FFF_Tusj.ttf", 18)
		end
		love.graphics.setColor(255, 255, 255)
		--love.graphics.rectangle( "fill", collision_rect.posX, collision_rect.posY, collision_rect.width, collision_rect.height)
		animations[player.direction]:draw(heroImage, player.posX, player.posY)
		balls_factory()

		--set music
		flagBgSong = 2


	elseif game_state == 2 then
		-- Show tha game over screen
		flagBgSong = 3
		love.graphics.draw(gameOverImage, 0, 0)
		love.graphics.setNewFont("fonts/FFF_Tusj.ttf", 36)
		love.graphics.print("FINAL SCORE: "..tostring(score), 250, 500)
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
		walking = true

		if love.keyboard.isDown('p') then
			--love.graphics.print("Paused Game: ", 350, 280)
			paused = not paused
			love.timer.sleep(0.5)
		end

		-- For dont't read the keyboard event if it's paused
		if paused then
			return
		end

		-- Set movement by key down
		if love.keyboard.isDown('up') and player.posY > 0 then 
			player.posY = player.posY - player.vel
			collision_rect.posY = player.posY + 20
			player.direction = 4
		elseif love.keyboard.isDown('down') and player.posY < 600 - player.height then 
			player.posY = player.posY + player.vel
			collision_rect.posY = player.posY + 20
			player.direction = 1
		elseif love.keyboard.isDown('left') and player.posX > 0 then 
			player.posX = player.posX - player.vel
			collision_rect.posX = player.posX + 15
			player.direction = 2
		elseif love.keyboard.isDown('right') and player.posX < 800 - player.width then 
			player.posX = player.posX + player.vel
			collision_rect.posX = player.posX + 15
			player.direction = 3
		else
			walking = false
		end
	
	elseif game_state == 2 then
		-- Restart the game if enter or space is pressed.
		if love.keyboard.isDown('return') or love.keyboard.isDown('space') then
			bgSongEnd:stop() 
			love.load()	
		end
	end

	-- Quit if press 'esc' 
	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

end