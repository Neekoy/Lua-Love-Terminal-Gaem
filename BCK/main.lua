function love.load()

	require ("terminals")

	input = ""

	phase = 0

	timer = 0
	displayText = ""
	counter = 1

	terminalImage = love.graphics.newImage("images/terminal.png")
	text1 = "Welcome to ANY Industries."
	text2 = "There is no spoon too.. This will be your instructions."

	function updateText(text)
		if timer >= 0.05 then
		c = text:sub(counter,counter)
		displayText = displayText .. c
		counter = counter + 1
		timer = 0
		end
	end

end

function love.draw()
	love.graphics.draw(terminalImage, terminal.x, terminal.y)
	love.graphics.print(displayText, terminal.x + 50 , terminal.y + 75)
end

function love.update(dt)

	timer = timer + dt

	if phase == 0 then
		updateText(text1)
	elseif phase == 1 then
		updateText(text2)
	end

	terminalDragging(terminal)
end

function love.focus(bool)
end

function love.textinput(text)
	input = input .. text
end

function love.keypressed( key, unicode )
	if key == "j" then
		phase = 1
		displayText = ""
		c = ""
		counter = 1
	end
	if key == "return" then
		print (input)
	end
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
	terminalMousePressed(terminal, x, y, button)
end

function love.mousereleased( x, y, button )
	terminalMouseReleased(button)
end

function love.quit()
end