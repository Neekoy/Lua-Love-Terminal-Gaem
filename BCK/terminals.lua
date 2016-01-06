windows = { "terminal", "terminal2" }

terminal = {
x = 0,
y = 0,
width = 820,
height = 31,
dragging = { active = false, diffX = 0, diffY = 0 }
}

terminal2 = {
x = 400,
y = 400,
width = 820,
height = 31,
dragging = { active = false, diffX = 0, diffY = 0 }
}

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
end

function terminalMouseReleased(button)
	if button == 1 then
		terminal.dragging.active = false
	end
end