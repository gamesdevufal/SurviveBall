function window_game()
	-- Timer management
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
	end
	love.timer.sleep(next_time - cur_time)	
	
	-- Drawing stuff
	love.graphics.rectangle( "fill", player.posX, player.posY, player.width, player.height)	
end

function treat_keyboard_1()
	-- Moving the hero
	if love.keyboard.isDown('up') and player.posY > 0 then player.posY = player.posY - player.vel
	elseif love.keyboard.isDown('down') and player.posY < 600 - player.height then player.posY = player.posY + player.vel
	elseif love.keyboard.isDown('left') and player.posX > 0 then player.posX = player.posX - player.vel
	elseif love.keyboard.isDown('right') and player.posX < 800 - player.width then player.posX = player.posX + player.vel
	end
end