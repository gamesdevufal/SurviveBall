function love.load()
	-- Player configs
	player = {posX=100, posY=100, vel=5}
	
	-- Timer configs
	fps    = 60		-- Using 60 frames per second
	min_dt = 1/fps
	next_time = love.timer.getTime()
end

function love.draw()
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

function love.update(dt) 
	-- Updating time
	next_time = next_time + min_dt
	
	-- Updating all the rest
	readKeyboard()
end

function readKeyboard()
	    if love.keyboard.isDown('up')    then player.posY = player.posY - player.vel
	elseif love.keyboard.isDown('down')  then player.posY = player.posY + player.vel
	elseif love.keyboard.isDown('left')  then player.posX = player.posX - player.vel
	elseif love.keyboard.isDown('right') then player.posX = player.posX + player.vel
	end
end