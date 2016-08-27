--[[
function love.keypressed(k)
	if k == "up" then
		print ("up!")
	end
end
]]
-- na versao 0.10 love.mousepressed( x, y, buttonm istouch )

--WindowID = 0 -> tela inicial, WindowID=2 -> tela de jogo 
windowID = 0

function window_initial()
	love.graphics.rectangle( "fill", 300, 400, 200, 100)
end

function love.mousepressed( x, y, button )
	if button == "l" and 300 < x and x < 500 and 400 < y and y < 500 then
		print("Star button clicked")
		windowID = 1
	end
end	


function window_game()
	love.graphics.rectangle( "fill", 100, 100, 16, 16)
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

function love.load()
	love.window.setMode(800, 600, {resizable=false})
	-- Player configs
	player = {posX=100, posY=100, vel=5}
	
	-- Timer configs
	fps    = 60		-- Using 60 frames per second
	min_dt = 1/fps
	next_time = love.timer.getTime()
end

function love.draw()
	if windowID == 1 then
		window_game()
	else
		window_initial()
	end
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
