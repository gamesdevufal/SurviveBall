--WindowID = 0 -> tela inicial, WindowID=2 -> tela de jogo 

require 'game_state'
require 'ball'

game_state = 0

--Na versao 0.10 love.mousepressed( x, y, button, istouch )
--Get mouse event
function love.mousepressed( x, y, button )
	treat_mouse(x, y, button)
end	

function love.load()
	-- Set window proprieties
	love.window.setMode(800, 600, {resizable=false})
	love.window.setTitle("Survive Game v1.0")
	
	-- Timer configs
	fps    = 60		-- Using 60 frames per second
	min_dt = 1/fps
	next_time = love.timer.getTime()

	-- Player configs
	player = {posX=100, posY=100, width = 32, height = 32, vel=5}
end

function love.draw()
	-- Ask which is the current game state
	window_state()
end

function love.update(dt) 
	-- Updating time
	next_time = next_time + min_dt
	
	-- Updating all the rest
	treat_keyboard()
	balls_move()
end