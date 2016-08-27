function love.load()
	player = {posX=100, posY=100, vel=5}
end

function love.draw()
	love.graphics.rectangle( "fill", player.posX, player.posY, 16, 16)
	
end

--[[
function love.keydown(key)
	if 		key == 'up' then 	player.posY = player.posY - player.vel
	elseif	key == 'down' then	player.posY = player.posY + player.vel
	elseif  key == 'right' then player.posX = player.posX + player.vel
	elseif	key == 'left' then  player.posX = player.posX - player.vel
	end
		
end ]]

function love.update(dt) 
	readKeyboard()
end

function readKeyboard()
	    if love.keyboard.isDown('up')    then player.posY = player.posY - player.vel
	elseif love.keyboard.isDown('down')  then player.posY = player.posY + player.vel
	elseif love.keyboard.isDown('left')  then player.posX = player.posX - player.vel
	elseif love.keyboard.isDown('right') then player.posX = player.posX + player.vel
	end
end