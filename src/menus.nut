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
	if(getcon("accept", "press") || (mousePress(0) && config.showcursor && cursorItem == menuSelectorPos)) {
		if(!menu[menuSelectorPos].rawin("func")) return;
		menu[menuSelectorPos].func();
	}
	//Pause
	if(getcon("pause", "press") && menuBackTimeout <= 0) {
		if(!menu[menu.len() - 1].rawin("back")) return;
		menu[menu.len() - 1].back();
	}
	if(menuBackTimeout > 0) menuBackTimeout--; //Count the current frame in the menu back timeout.
	
	updateCursor() //Update the mouse cursor.
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

//Main menu
::meMain <- [
	{
		name = function() {return translation.tr("Start Game")},
		func = function() {goToMenu(meStartGame)}
	},
	{
		name = function() {return translation.tr("Options")},
		func = function() {goToMenu(meOptions)}
	},
	{
		name = function() {return translation.tr("Quit Game")},
		func = function() {gvQuit = true}
	}
]
//Start game menu
::meStartGame <- [
	{
		name = function() {return translation.tr("File 1") + (!fileExists("save/save" + 1 + ".json") ? translation.tr(" [EMPTY]") : "")},
		func = function() {quitMenu(); startGame(1)}
	},
	{
		name = function() {return translation.tr("File 2") + (!fileExists("save/save" + 2 + ".json") ? translation.tr(" [EMPTY]") : "")},
		func = function() {quitMenu(); startGame(2)}
	},
	{
		name = function() {return translation.tr("File 3") + (!fileExists("save/save" + 3 + ".json") ? translation.tr(" [EMPTY]") : "")},
		func = function() {quitMenu(); startGame(3)}
	},
	{
		name = function() {return translation.tr("File 4") + (!fileExists("save/save" + 4 + ".json") ? translation.tr(" [EMPTY]") : "")},
		func = function() {quitMenu(); startGame(4)}
	},
	{
		name = function() {return translation.tr("File 5") + (!fileExists("save/save" + 5 + ".json") ? translation.tr(" [EMPTY]") : "")},
		func = function() {quitMenu(); startGame(5)}
	},
	{
		name = function() {return translation.tr("Back")},
		func = function() {goToMenu(meMain)},
		back = function() {goToMenu(meMain)}
	}
]
//Options menu
::meOptions <- [
	{
		name = function() {return translation.tr("Language")},
		func = function() {
			if(!fileExists("res/lang/languages.json"))
				return
			local languageList = jsonRead(fileRead("res/lang/languages.json"))
			foreach(entry in languageList["languages"]) {
				meLanguage.push(
				{
					lang = entry[0],
					langTitle = entry[1],
					name = function() {return translation.tr(langTitle)},
					func = function() {
						translation.setLanguage(lang)
						config.language = lang
						meLanguage = []
						goToMenu(meOptions)
					}
				})
			}
			meLanguage.push(
			{
				name = function() {return translation.tr("Back")},
				func = function() {meLanguage = []; goToMenu(meOptions)},
				back = function() {meLanguage = []; goToMenu(meOptions)}
			})
			goToMenu(meLanguage)
		}
	},
	{
		name = function() {return translation.tr("Cursor") + ": " + (config.showcursor ? translation.tr("Shown") : translation.tr("Hidden"))},
		func = function() {config.showcursor = !config.showcursor; fileWrite("config.json", jsonWrite(config))}
	},
	{
		name = function() {return translation.tr("Back")},
		func = function() {fileWrite("config.json", jsonWrite(config)); goToMenu(meMain)},
		back = function() {fileWrite("config.json", jsonWrite(config)); goToMenu(meMain)}
	}
]
//Pause menu
::mePause <- [
	{
		name = function() {return translation.tr("Continue")},
		func = function() {quitMenu()}
	},
	{
		name = function() {return translation.tr("Save Game")},
		func = function() {saveGame(); quitMenu()}
	},
	{
		name = function() {return translation.tr("Quit Game")},
		func = function() {quitMenu(); quitGame()},
		back = function() {quitMenu()}
	}
]
//Language menu
//Language menu is dynamic so it's empty when the program starts
::meLanguage <- []
