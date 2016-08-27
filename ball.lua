ball_ID = 0
balls = {}
function balls_factory()
	if ball_ID < 4 then
		balls[ball_ID] ={posX=math.random(0, 800), posY=math.random(0, 600), width=16, height=16,  vel=2, ang = math.random(0, 180)}
		ball_ID = ball_ID + 1
	end


	for i = 0 , ball_ID-1 do
		love.graphics.rectangle( "fill", balls[i].posX, balls[i].posY, balls[i].width, balls[i].height)
	end
end

function balls_move()
	for i = 0, ball_ID-1 do
		balls[i].posX = balls[i].posX + balls[i].vel * math.cos(balls[i].ang)
		balls[i].posY = balls[i].posY + balls[i].vel * math.sin(balls[i].ang)
	end
end