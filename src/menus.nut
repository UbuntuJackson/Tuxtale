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

//Menu variables
::menu <- []; //Current menu
::selectorPos <- 0; //Selector position
//::selectorTimeout <- 0; //Selector timeout

//Menu functions
::updateMenu <- function() {
	if(menu == [] || gmPlay) return; //If no menu is loaded, or a game instance is currently running.
	
	drawSprite(sprchalk, 0, 0, 0)

	for(local index = 0; index < menu.len(); index++) {
		drawText(font, 10, 20 * (index + 1), menu[index].name());
		if(selectorPos == index) {
			setDrawColor(0xFFFFFF);
			drawRec(10, 20 * (index + 1) + 10, menu[index].name().len() * fontWidth, 0, false);
		}
	}
	//Controls for menu navigation
	//Up
	if(getcon("up", "press")) {
		if(selectorPos == 0) {
			selectorPos = menu.len() - 1;
			return;
		}
		selectorPos--;
	}
	//Down
	if(getcon("down", "press")) {
		if(selectorPos == menu.len() - 1) {
			selectorPos = 0;
			return;
		}
		selectorPos++;
	}
	//Accept
	if(getcon("accept", "press")) {
		if(!menu[selectorPos].rawin("func")) return;
		menu[selectorPos].func();
	}
	//Pause
	if(getcon("pause", "press")) {
		if(!menu[menu.len() - 1].rawin("back")) return;
		menu[menu.len() - 1].back();
	}
}
::goToMenu <- function(newMenu) {
	selectorPos = 0;
	menu = newMenu;
}


//Define menus
::meMain <- [
  {
    name = function() {return "Start Game"},
    func = function() {selectorPos = 0; newGame()}
  },
  {
    name = function() {return "Options"},
    func = function() {goToMenu(meOptions)}
  },
  {
    name = function() {return "Quit Game"},
    func = function() {gvQuit = true}
  }
]
::meOptions <- [
  {
    name = function() {return "Under construction"},
    back = function() {goToMenu(meMain)}
  }
]