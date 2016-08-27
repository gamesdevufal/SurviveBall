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
end

function love.load()
	love.window.setMode(800, 600, {resizable=false})
end

function love.draw()
	if windowID == 1 then
		window_game()
	else
		window_initial()
	end
end



