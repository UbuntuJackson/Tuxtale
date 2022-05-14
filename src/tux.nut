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

::Tux <- class extends Actor {
	frame = 0.0
	anim = [] //Animation frame delimiters: [start, end, speed]
	anStandRight = [0.0, 0.0, "standright"]
	anStandLeft = [12.0, 12.0, "standleft"]
	anStandUp = [4.0, 4.0, "standup"]
	anStandDown = [8.0, 8.0, "standdown"]
	anWalkRight = [0.0, 3.0, "walkright"]
	anWalkDown = [8.0, 11.0, "walkdown"]
	anWalkUp = [4.0, 7.0, "walkup"]
	anWalkLeft = [12.0, 15.0]
	//anHurt = [3.0, 12.0, "hurt"]
	hspeed = 0
	vspeed = 0
	mspeed = 1
	ysort = 0
	xsort = 0
	diagonal = 1
	nsp = 2
	face = 0
	shape = 0
	w = 16
	h = 16

	constructor(_x, _y, _arr = null) {
		hspeed = 1
		anim = anStandRight
		nsp = 1.5
		x = _x
		y = _y
		w = 7
		h = 7
	}

	function collision(_x, _y) {
		foreach(tile in gmMap.tiles) {
			if(fabs(_x - tile.x) < w + tile.w && fabs(_y - tile.y) < h + tile.h) {
				return tile.solid
			}
		}
		foreach(obj in gmMap.objects) {
			if(fabs(_x - obj.x) < w + obj.w && fabs(_y - obj.y) < h + obj.h) {
				obj.onCollision()
				return obj.solid
			}
		}
	}

	function run() {
	  	if(gvGameOverlay != emptyFunc) { //If an overlay is active, update Tux without allowing him to move.
			tuxStand()
			return updateTux()
		}

		if(xsort != 0 && ysort != 0) {
			diagonal = 0.707
		}
		else {
			diagonal = 1
		}

		if(!(getcon("right", "hold") || getcon("left", "hold"))) xsort = 0
		if(!(getcon("up", "hold") || getcon("down", "hold"))) ysort = 0

		if(getcon("right", "hold")) xsort = (nsp * diagonal)
		if(getcon("left", "hold")) xsort = (-nsp * diagonal)
		if(getcon("up", "hold")) ysort = (-nsp * diagonal)
		if(getcon("down", "hold")) ysort = (nsp * diagonal)

		if(xsort > 0) {
			anim = anWalkRight
			face = 0
		}
		if(xsort < 0) {
			anim = anWalkLeft
			face = 1
		}
		if(ysort > 0) {
			anim = anWalkDown
			face = 2
		}
		if(ysort < 0) {
			anim = anWalkUp
			face = 3
		}

		if(xsort == 0 && ysort == 0) tuxStand()

		if(collision(x + xsort, y)) {
			xsort = 0
			if(xsort == 0 && ysort == 0) tuxStand()
		}

		if(collision(x, y + ysort)) {
			ysort = 0
			if(xsort == 0 && ysort == 0) tuxStand()
		}

		if(collision(x + xsort, y + ysort)){
			ysort = 0
			xsort = 0
			if(xsort == 0 && ysort == 0) tuxStand()
		}

		x += xsort
		y += ysort

		updateTux()
	}

	function tuxStand() {
		  switch(face) {
		  	case 0:
			  	anim = anStandRight
			  	break
		  	case 1:
			  	anim = anStandLeft
			  	break
		  	case 2:
			  	anim = anStandDown
			  	break
		  	case 3:
			  	anim = anStandUp
			  	break
	  	}
	}

	function updateTux() {
		frame += 0.1
		drawSprite(sprTaleTux, wrap(floor(frame), anim[0], anim[1]), x - gmData.camX, y - gmData.camY)
	}
}
