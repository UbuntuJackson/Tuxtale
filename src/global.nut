::gvQuit <- false //Requested game quit

//Engine
::sprFont <- newSprite("res/gfx/engine/font.png", 6, 8, 0, 0, 0, 0)
::font <- newFont(sprFont, 0, 0, true, 0)
::fontWidth <- 6
//::fontHeight <- 14

//Sprites - overworld
::sprTaleTux <- newSprite("res/gfx/Tux/taletuxNL.png", 16, 16, 0, 0, 8, 8)
::sprTile <- newSprite("res/gfx/tiles/block.png", 16, 16, 0, 0, 8, 8)

::config <- {
	key = {
		up = k_up
		down = k_down
		left = k_left
		right = k_right
		jump = k_z
		shoot = k_x
		run = k_lshift
		sneak = k_lctrl
		pause = k_escape
		swap = k_a
		accept = k_enter
		leftPeek = k_home
		rightPeek = k_end
		downPeek = k_pagedown
		upPeek = k_pageup
	}
	joy = {
		jump = 0
		shoot = 2
		run = 4
		sneak = 5
		pause = 7
		swap = 3
		accept = 0
		leftPeek = -1
		rightPeek = -1
		downPeek = -1
		upPeek = -1
	}
	fullscreen = false
}
