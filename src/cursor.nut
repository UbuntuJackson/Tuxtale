// Tuxtale
// Copyright (C) 2022 Vankata453

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

::lastCursorPos <- [mouseX(), mouseY()]
::cursorItem <- null

::updateCursor <- function() {
	if(!config.showcursor) return //If the cursor is set to hidden in the config, don't draw it.

	//Draw the cursor
	drawText(font, lastCursorPos[0], lastCursorPos[1], "+")
	//Cursor idle detection
	if(lastCursorPos[0] == mouseX() && lastCursorPos[1] == mouseY()) return
	lastCursorPos[0] = mouseX()
	lastCursorPos[1] = mouseY()

	//Check if the cursor is on top of any menu item
	cursorItem = null
	for(local index = 0; index < menu.len(); index++) {
		local menuItemY = 20 * (index + 1) - 5
		if(mouseX() >= 10 && mouseX() <= 10 + menu[index].name().len() * fontWidth && mouseY() >= menuItemY && mouseY() <= menuItemY + 10) {
			menuSelectorPos = index
			cursorItem = index
			break
		}
	}
}
