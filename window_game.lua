function window_game()
	-- Timer management
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
	end
	love.timer.sleep(next_time - cur_time)	
	
	-- Drawing stuff
	love.graphics.rectangle( "fill", player.posX, player.posY, 16, 16)	
end

function treat_keyboard_1()
	if love.keyboard.isDown('up')    then player.posY = player.posY - player.vel
	elseif love.keyboard.isDown('down')  then player.posY = player.posY + player.vel
	elseif love.keyboard.isDown('left')  then player.posX = player.posX - player.vel
	elseif love.keyboard.isDown('right') then player.posX = player.posX + player.vel
	end
end