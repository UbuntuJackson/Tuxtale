// Tuxtale
// Copyright (C) 2022 UbuntuJackson

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

::gvQuit <- false //Requested game quit

//Engine
::sprFont <- newSprite("res/gfx/engine/font.png", 6, 8, 0, 0, 0, 0)
::font <- newFont(sprFont, 0, 0, true, 0)
::fontWidth <- 6

//Sprites
::sprChalk <- newSprite("res/gfx/BG/menu/chalk.png", 400, 240, 0, 0, 0, 0)
::sprTaleTux <- newSprite("res/gfx/Tux/taletuxCL.png", 16, 16, 0, 0, 8, 8)
::sprTile <- newSprite("res/gfx/tiles/block.png", 16, 16, 0, 0, 8, 8)
::sprBricks <- newSprite("res/gfx/tiles/bricks.png", 16, 16, 0, 0, 8, 8)
::sprCollision <- newSprite("res/gfx/tiles/collision.png", 16, 16, 0, 0, 8, 8)
::sprObjects <- newSprite("res/gfx/tiles/objects.png", 16, 16, 0, 0, 8, 8)
::sprDoors <- newSprite("res/gfx/tiles/doors.png", 16, 16, 0, 0, 8, 8)
::sprStatics <- newSprite("res/gfx/tiles/statics.png", 16, 16, 0, 0, 8, 8)

//Game management
::gvCamTarget <- null
::gvGameMode <- null //Current gamemode
::gvGameOverlay <- null //Current game overlay
::gvGameOverlayParam <- null //Current game overlay parameter

//Others
::emptyFunc <- function() {return}
::actorsClear <- clone(actor)

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
	fullscreen = false,
	language = "en"
}
