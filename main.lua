--WindowID = 0 -> tela inicial, WindowID=2 -> tela de jogo 

require 'game_state'
require 'ball'
local anim8 = require 'anim8'

game_state = 0

--Na versao 0.10 love.mousepressed( x, y, button, istouch )
--Get mouse event
function love.mousepressed()
	treat_mouse(love.mouse.getX(), love.mouse.getY())
end	

function love.load()
	-- Set window proprieties
	love.window.setMode(800, 600, {resizable=false})
	love.window.setTitle("Survive Game v1.0")
	
	-- Timer configs
	fps    = 60		-- Using 60 frames per second
	min_dt = 1/fps
	next_time = love.timer.getTime()

	-- Game configs
	initScreen = love.graphics.newImage('media/Inicio.png')
	floorScreen = love.graphics.newImage('media/floor.jpg')
	ballImage  = love.graphics.newImage('media/Bola.png')

	heroImage  = love.graphics.newImage('media/people.png')

	local g = anim8.newGrid(32, 48, heroImage:getWidth(), heroImage:getHeight())
	animation_down = anim8.newAnimation( g('4-6', 1), 0.2)
	animation_left = anim8.newAnimation( g('4-6', 2), 0.2)
	animation_right = anim8.newAnimation( g('4-6', 3), 0.2)
	animation_up = anim8.newAnimation( g('4-6', 4), 0.2)

	animations = {animation_down, animation_left, animation_right, animation_up}

	score = 0
	lives = 3
	lastCollisionIndex = 0
	collisionFlag = 1
	
	-- Player configs
	player = {posX=380, posY=280, width = 32, height = 48, vel=5, direction = 1}
end

function love.draw()
	-- Ask which is the current game state
	window_state()
end

function love.update(dt) 
	-- Updating time
	next_time = next_time + min_dt

	animations[player.direction]:update(dt)
	
	-- Updating all the rest
	treat_keyboard()
	balls_move()

end