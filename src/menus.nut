//Menu variables
::menu <- []; //Current menu
::selectorPos <- 0; //Selector position
//::selectorTimeout <- 0; //Selector timeout

//Menu functions
::updateMenu <- function() {
	if(menu == [] || gmPlay) return; //If no menu is loaded, or a game instance is currently running.

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
