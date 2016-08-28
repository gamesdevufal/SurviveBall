--[[
	Game Name: SurviveBall
	version: 1.0
	Created: 27/08/2016
	Authors : Bruno Gabriel Cavalcante Lima (https://github.com/bglima)
	          Felipe Emídio Esteves da Silva (https://github.com/felipeemidio)
]]

require 'game_state'
require 'ball'
local anim8 = require 'anim8'

--Variable that define which screen should appear
game_state = 0

function love.load()
	-- Set window proprieties
	love.window.setMode(800, 600, {resizable=false})
	love.window.setTitle("Survive Game v1.0")

	-- Conf new font
	love.graphics.setNewFont("fonts/FFF_Tusj.ttf", 18)
	
	-- Timer configs
	fps    = 60		-- Using 60 frames per second
	min_dt = 1/fps
	next_time = love.timer.getTime()

	-- Get images
	initScreen = love.graphics.newImage('media/Inicio.png')
	floorScreen = love.graphics.newImage('media/floor.jpg')
	ballImage  = love.graphics.newImage('media/Bola.png')
	gameOverImage  = love.graphics.newImage('media/gameOver2.png')
	game_state = 0
	heroImage  = love.graphics.newImage('media/people.png')

	-- Get animations
	local g = anim8.newGrid(64, 64, heroImage:getWidth(), heroImage:getHeight())
	animation_down = anim8.newAnimation( g('4-6', 1), 0.1)
	animation_left = anim8.newAnimation( g('4-6', 2), 0.1)
	animation_right = anim8.newAnimation( g('4-6', 3), 0.1)
	animation_up = anim8.newAnimation( g('4-6', 4), 0.1)
	animations = {animation_down, animation_left, animation_right, animation_up}

	-- Set game variables
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
	paused = false
	
	-- Player configs
	player = {posX=380, posY=280, width = 32, height = 48, vel=5, direction = 1}
	collision_rect = {posX = player.posX+15, posY = player.posY+20, width = player.width-26, height = player.height-26}
	
	-- Sound settings
	bgSongIntro = love.audio.newSource("media/intro.ogg")
	bgSongPlay  = love.audio.newSource("media/playing.ogg")
	bgSongEnd	= love.audio.newSource("media/gameOver.ogg")	
	songLiveLost = love.audio.newSource("media/liveLost1.ogg")
	songTenScore = love.audio.newSource("media/score.ogg")
	flagBgSong = 0
	flagLiveSong = 0
	flagTenScore = 0
end

function love.draw()
	-- Ask which is the current game state
	window_state()
end

function love.update(dt)

	playSound()
	--next_time = next_time + min_dt
	if not paused then 
		-- Updating time
		if walking then
			animations[player.direction]:update(dt)
		end
		-- Updating all the rest
		
		balls_move()
	end

	treat_keyboard()

end

--On version 0.10 love.mousepressed( x, y, button, istouch )
--Get mouse event
function love.mousepressed()
	treat_mouse(love.mouse.getX(), love.mouse.getY())
end	

function playSound()
	-- Set the music by game stage
	if flagBgSong ~= 0 then
		if flagBgSong == 1 then bgSongIntro:play() bgSongPlay:stop() bgSongEnd:stop()
		elseif flagBgSong == 2 then bgSongIntro:stop() bgSongPlay:play() bgSongEnd:stop() 
		elseif flagBgSong == 3 then bgSongIntro:stop() bgSongPlay:stop() bgSongEnd:play() end
		
		flagBgSong = 0
	end	
	
	-- Set sound if the player was hit
	if flagLiveSong ~= 0 then
		love.audio.play(songLiveLost)
		flagLiveSong = 0
	end
	
	-- Set the song if the player level up
	if flagTenScore ~= 0 then
		love.audio.play(songTenScore)
		flagTenScore = 0
	end
end