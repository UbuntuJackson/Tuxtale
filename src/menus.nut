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
::menu <- null; //Current menu
::menuSelectorPos <- 0; //Selector position
//::selectorTimeout <- 0; //Selector timeout
::menuBackTimeout <- 2; //Frames before quitting the menu is allowed

//Menu functions
::updateMenu <- function(optMenu = null) {
	if(!menu && !optMenu) return quitMenu(); //If no menu is loaded and no optional menu is given.
	if(!menu) menu = optMenu; //If an optional menu to use was given as a parameter, set it as the current menu, if there isn't one already.

	for(local index = 0; index < menu.len(); index++) {
		drawText(font, 10, 20 * (index + 1), menu[index].name());
		if(menuSelectorPos == index) {
			setDrawColor(0xFFFFFF);
			drawRec(9, 20 * (index + 1) + 10, menu[index].name().len() * fontWidth, 0, false);
		}
	}
	//Controls for menu navigation
	//Up
	if(getcon("up", "press")) {
		if(menuSelectorPos == 0) {
			menuSelectorPos = menu.len() - 1;
			return;
		}
		menuSelectorPos--;
	}
	//Down
	if(getcon("down", "press")) {
		if(menuSelectorPos == menu.len() - 1) {
			menuSelectorPos = 0;
			return;
		}
		menuSelectorPos++;
	}
	//Accept
	if(getcon("accept", "press")) {
		if(!menu[menuSelectorPos].rawin("func")) return;
		menu[menuSelectorPos].func();
	}
	//Pause
	if(getcon("pause", "press") && menuBackTimeout <= 0) {
		if(!menu[menu.len() - 1].rawin("back")) return;
		menu[menu.len() - 1].back();
	}
	if(menuBackTimeout > 0) menuBackTimeout--; //Count the current tick in the menu back timeout.
}
::goToMenu <- function(newMenu) { //Go to another menu.
	menuSelectorPos = 0;
	menuBackTimeout = 2;
	menu = newMenu;
}
::quitMenu <- function() { //Reset the menu and its values.
	menuSelectorPos = 0;
	menu = null;
	menuBackTimeout = 2;
	if(gvGameOverlay != emptyFunc) resetOverlay();
}


//Define menus
::meMain <- [
  {
    name = function() {return "Start Game"},
    func = function() {goToMenu(meStartGame)}
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
::meStartGame <- [
  {
    name = function() {return "File 1" + (!fileExists("save/save" + 1 + ".json") ? " [EMPTY]" : "")},
    func = function() {quitMenu(); startGame(1)}
  },
  {
    name = function() {return "File 2" + (!fileExists("save/save" + 2 + ".json") ? " [EMPTY]" : "")},
    func = function() {quitMenu(); startGame(2)}
  },
  {
    name = function() {return "File 3" + (!fileExists("save/save" + 3 + ".json") ? " [EMPTY]" : "")},
    func = function() {quitMenu(); startGame(3)}
  },
	{
    name = function() {return "File 4" + (!fileExists("save/save" + 4 + ".json") ? " [EMPTY]" : "")},
    func = function() {quitMenu(); startGame(4)}
  },
	{
    name = function() {return "File 5" + (!fileExists("save/save" + 5 + ".json") ? " [EMPTY]" : "")},
    func = function() {quitMenu(); startGame(5)}
  },
	{
		name = function() {return "Back"},
		func = function() {goToMenu(meMain)},
		back = function() {goToMenu(meMain)}
	}
]
::meOptions <- [
  {
    name = function() {return "Under construction"},
    back = function() {fileWrite("config.json", jsonWrite(config)); goToMenu(meMain)}
  }
]
::mePause <- [
  {
    name = function() {return "Continue"},
    func = function() {quitMenu()}
  },
	{
    name = function() {return "Save Game"},
    func = function() {saveGame(); quitMenu()}
  },
  {
    name = function() {return "Quit Game"},
    func = function() {quitMenu(); quitGame()},
    back = function() {quitMenu()}
  }
]