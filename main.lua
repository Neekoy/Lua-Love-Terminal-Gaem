function love.load()

	require ("terminals")
	require ("parser")

	username = "neekoy"

	input = ""
	inputHistory = {""}
  terminalOutput = {""}
	inputHistoryCount = 0
  systemOutput = nil
	terminalPrompt = username .. "@paragon.net.uk:~$ "
	terminalOpen = 1

	phase = 0

	previousDt = 0
	timer = 0
	displayText = ""
	counter = 1

	blinktime = 0
	underscore = "_"

	openMenu = 0

	termFont = love.graphics.newFont("fonts/DejaVuSansMono.ttf", 15)

	backgroundImage = love.graphics.newImage("images/background.jpg")
	toolbarImage = love.graphics.newImage("images/toolbar.png")
	terminalImage = love.graphics.newImage("images/terminal.png")
	mainMenuImage = love.graphics.newImage("images/main_menu.png")
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
	love.graphics.draw(backgroundImage, 0 , 0)
	love.graphics.draw(toolbarImage, 0, 1041)
	drawTerminal(terminals.terminal.x, terminals.terminal.y)
	if openMenu == 1 then
		love.graphics.draw(mainMenuImage, 5, 555)
	end
end

function love.update(dt)

	timer = timer + dt
	previousDt = previousDt + dt
	blinktime = blinktime + dt

	if phase == 0 then
		updateText(text1)
	elseif phase == 1 then
		updateText(text2)
	end

	for _,l in ipairs(windows) do
		local ourWindow = terminals[l]
		terminalDragging(ourWindow)
	end

	if love.keyboard.isDown("backspace") then
		if previousDt >= 0.075 then
			input = string.sub(input, 1, -2)
			previousDt = 0
		end
	end

	if blinktime > 0.5 then
		if underscore == "_" then
			underscore = ""
		else
			if terminals.terminal.active == true then
				underscore = "_"
			end
		end
		blinktime = 0
	end

end

function love.focus(bool)
end

function love.textinput(text)
	if terminals.terminal.active == true then
		input = input .. text
	end
end

function love.keypressed( key, unicode )
	--if key == "j" then
	--	phase = 1
	--	displayText = ""
	--	c = ""
	--	counter = 1
	--end

	if terminals.terminal.active == true then
		if key == "return" then
			print (input)
			parseInput(input)
			inputHistoryCount = inputHistoryCount + 1
			table.insert(inputHistory, inputHistoryCount, input)
			table.insert(terminalOutput, inputHistoryCount, terminalPrompt .. input)
			if systemOutput then
			    inputHistoryCount = inputHistoryCount + 1
			    table.insert(terminalOutput, inputHistoryCount, systemOutput)
		  end
			input = ""
		end
	end
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )

	if x >= 0 and x <= 82
	and y >= 1041 and y <= 1080 then
		if openMenu == 0 then
		    openMenu = 1
		else
			openMenu = 0
		end
	end

    if openMenu == 1 then
		if x >= 375 and y >= 555 or
		y <= 555 then
	        openMenu = 0
		end
	end

	for _,l in ipairs(windows) do
		local ourWindow = terminals[l]
		terminalMousePressed(ourWindow, x, y, button)
	end
end

function love.mousereleased( x, y, button )
	for _,l in ipairs(windows) do
		local ourWindow = terminals[l]
		terminalMouseReleased(button, ourWindow)
	end
end

function love.quit()
end
