
function window_initial()
	--Draw the start button.
	love.graphics.rectangle( "fill", 300, 400, 200, 100)
end

function treat_mouse_0( x, y, button )
	--See if the start button was clicked.
	if button == "l" and 300 < x and x < 500 and 400 < y and y < 500 then
		print("Star button clicked")
		windowID = 1
	end
end