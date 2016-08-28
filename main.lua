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

	local g = anim8.newGrid(64, 64, heroImage:getWidth(), heroImage:getHeight())
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
	collision_rect = {posX = player.posX+15, posY = player.posY+20, width = player.width-26, height = player.height-26}
	
	-- Sound settings
	bgSongIntro = love.audio.newSource("media/intro.mp3")
	bgSongPlay  = love.audio.newSource("media/playing.mp3")
	bgSongEnd	= love.audio.newSource("media/gameOver.mp3")
	songLiveLost = love.audio.newSource("media/liveLost1.mp3")
	songTenScore = love.audio.newSource("media/score.mp3")
	flagBgSong = 0
	flagLiveSong = 0
	flagTenScore = 0
end

function playSound()
	if flagBgSong ~= 0 then
		if flagBgSong == 1 then bgSongIntro:play() bgSongPlay:stop() bgSongEnd:stop()
		elseif flagBgSong == 2 then bgSongIntro:stop() bgSongPlay:play() bgSongEnd:stop()
		elseif flagBgSong == 3 then bgSongIntro:stop() bgSongPlay:stop() bgSongEnd:play() end
		flagBgSong = 0
	end	
	
	if flagLiveSong ~= 0 then
		love.audio.play(songLiveLost)
		flagLiveSong = 0
	end
	
	if flagTenScore ~= 0 then
		love.audio.play(songTenScore)
		flagTenScore = 0
	end
end

function love.draw()
	-- Ask which is the current game state
	window_state()
end

function love.update(dt) 
	-- Updating time
	next_time = next_time + min_dt

	-- Animations
	animations[player.direction]:update(dt)
	
	-- Sound
	playSound()
	
	-- Updating all the rest
	treat_keyboard()
	balls_move()

end