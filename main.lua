--[[
function love.keypressed(k)
	if k == "up" then
		print ("up!")
	end
end
]]


--WindowID = 0 -> tela inicial, WindowID=2 -> tela de jogo 

require 'window_initial'
require 'window_game'

windowID = 0


-- na versao 0.10 love.mousepressed( x, y, button, istouch )
--Get mouse event
function love.mousepressed( x, y, button )
	if windowID == 0 then
		treat_mouse_0( x, y, button )
	end
end	

function love.load()
	love.window.setMode(800, 600, {resizable=false})
	
	-- Timer configs
	fps    = 60		-- Using 60 frames per second
	min_dt = 1/fps
	next_time = love.timer.getTime()

	-- Player configs
	player = {posX=100, posY=100, vel=5}
end

function love.draw()
	-- Ask which is the current game state
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
	treat_keyboard_1()
end


