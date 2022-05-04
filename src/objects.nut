// Tuxtale
// Copyright (C) 2022 UbuntuJackson, Vankata453

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

::Tile <- class extends Actor {
	w = 8
	h = 8
	spr = sprTile
	tile = 0
	solid = true
	visible = true
	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		if(!_arr) return
		if(_arr.len() >= 1) spr = _arr[0]
		if(_arr.len() >= 2) tile = _arr[1]
		if(_arr.len() >= 3) solid = _arr[2]
		if(_arr.len() >= 4) visible = _arr[3]
	}
	function run() {
		if(visible) drawSprite(spr, tile, x - gmData.camX, y - gmData.camY)
	}
}

::Object <- class extends Actor {
	w = 8
	h = 8
	spr = sprObjects
	tile = 0
	solid = false
	visible = true
	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		if(!_arr) return
		if(_arr.len() >= 1) spr = _arr[0]
		if(_arr.len() >= 2) tile = _arr[1]
		if(_arr.len() >= 3) solid = _arr[2]
		if(_arr.len() >= 4) visible = _arr[3]
	}
	function run() {
		if(visible) draw()
		// switch(tile) { //Do different actions on update, based on which the current object is.
		// 	case 0: //Info block
		// 		break;
		// 	case 1: //Spawn point
		// 		break;
		// 	case 2: //Badguy
		// 		break;
		// 	case 3: //Chest
		// 		break;
		// 	case 4: //NPC
		// 		break;
		// }
	}
	function draw() {
		drawSprite(spr, tile, x - gmData.camX, y - gmData.camY)
	}
	function onCollision() {
		local text = null
		switch(tile) { //Do different actions on collision, based on which the current object is.
			case 0: //Info block
				text = "Press Space to open dialog"
				if(keyPress(k_space)) setOverlay(updateDialog, "0")
				break;
			case 1: //Spawn point
				text = "Touching spawn point"
				break;
			case 2: //Badguy
				text = "Touching badguy"
				break;
			case 3: //Chest
				text = "Touching chest"
				break;
			case 4: //NPC
				text = "Touching NPC"
				break;
		}
		drawText(font, screenW() / 2 - fontWidth * text.len() / 2, screenH() / 12, text)
	}
}
