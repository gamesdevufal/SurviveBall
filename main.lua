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

	love.graphics.setNewFont("fff/FFF_Tusj.ttf", 18)


	-- Game configs
	initScreen = love.graphics.newImage('media/Inicio.png')
	floorScreen = love.graphics.newImage('media/floor.jpg')
	ballImage  = love.graphics.newImage('media/Bola.png')
	gameOverImage  = love.graphics.newImage('media/gameOver.png')

	heroImage  = love.graphics.newImage('media/people.png')

	local g = anim8.newGrid(64, 64, heroImage:getWidth(), heroImage:getHeight())
	animation_down = anim8.newAnimation( g('4-6', 1), 0.1)
	animation_left = anim8.newAnimation( g('4-6', 2), 0.1)
	animation_right = anim8.newAnimation( g('4-6', 3), 0.1)
	animation_up = anim8.newAnimation( g('4-6', 4), 0.1)

	animations = {animation_down, animation_left, animation_right, animation_up}

	score = 0
	level = 1
	lives = 3
	ball_ID = 0
	balls = {}
	num_ball = 3
	nextLevel = 5
	lastCollisionIndex = 0
	collisionFlag = 1
	walking = false
	
	-- Player configs
	player = {posX=380, posY=280, width = 64, height = 64, vel=5, direction = 1}
	collision_rect = {posX = player.posX+15, posY = player.posY+20, width = player.width-26, height = player.height-26}
end

function love.draw()
	-- Ask which is the current game state
	window_state()
end

function love.update(dt) 
	-- Updating time
	next_time = next_time + min_dt

	if walking then
		animations[player.direction]:update(dt)
	end
	-- Updating all the rest
	treat_keyboard()
	balls_move()

end