
function window_state()
	-- Timer management
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
	end
	love.timer.sleep(next_time - cur_time)	
		
	if game_state == 0 then
		--Draw the start button.
		love.graphics.draw(initScreen, 0, 0)
		--love.graphics.rectangle( "fill", 300, 400, 200, 100)

	elseif game_state == 1 then
		-- Drawing stuff
		love.graphics.print("Score: "..tostring(score), 10, 10)
		love.graphics.setColor(255, 50, 50)
		love.graphics.rectangle( "fill", player.posX, player.posY, player.width, player.height)
		love.graphics.setColor(255, 255, 255)
		balls_factory()
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
		if love.keyboard.isDown('up') and player.posY > 0 then player.posY = player.posY - player.vel
		elseif love.keyboard.isDown('down') and player.posY < 600 - player.height then player.posY = player.posY + player.vel
		elseif love.keyboard.isDown('left') and player.posX > 0 then player.posX = player.posX - player.vel
		elseif love.keyboard.isDown('right') and player.posX < 800 - player.width then player.posX = player.posX + player.vel
		end
	end
end