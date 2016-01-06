windows = { "terminal", "terminal2" }
terminals = {}

terminals.terminal = {
name = "main",
x = 50,
y = 50,
width = 820,
height = 31,
active = true,
dragging = { active = false, diffX = 0, diffY = 0 }
}

terminals.terminal2 = {
name = "secondary",
x = 600,
y = 600,
width = 820,
height = 31,
active = false,
dragging = { active = false, diffX = 0, diffY = 0 }
}

function drawTerminal(terminalX, terminalY)
	if terminalOpen == 1 then
		love.graphics.draw(terminalImage, terminalX, terminalY)
		love.graphics.print(displayText, terminalX + 50 , terminalY + 75)
		love.graphics.setColor (200, 204, 221, 100)
		love.graphics.rectangle("fill", terminalX + 2, terminalY + 528, 800, 22, 0 , 0)
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(termFont)
		love.graphics.print ("#! " .. input .. underscore, terminalX + 5, terminalY + 530)
		for _,v in ipairs(inputHistory) do
			love.graphics.print (v)
		end
	end	
end

function terminalDragging(terminal)
	if terminal.dragging.active then
		terminal.x = love.mouse.getX() - terminal.dragging.diffX
		terminal.y = love.mouse.getY() - terminal.dragging.diffY
	end
end

function terminalMousePressed(terminal, x, y, button)
	if button == 1
	and x >= terminal.x and x <= terminal.x + terminal.width
	and y >= terminal.y and y <= terminal.y + terminal.height then
		terminal.dragging.active = true
		terminal.dragging.diffX = x - terminal.x
		terminal.dragging.diffY = y - terminal.y
	end
	if button == 1
	and x >= terminal.x and x <= terminal.x + terminal.width
	and y >= terminal.y and y <= terminal.y + 548 then
		terminal.active = true
	else
		terminal.active = false
	end
end

function terminalMouseReleased(button, terminal)
	if button == 1 then
		terminal.dragging.active = false
	end
end