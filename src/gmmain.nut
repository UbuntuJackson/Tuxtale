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

//Game data
::gmActive <- false //Currently in-game
::gmPlayer <- null //Player 1
//::gmPlayer2 <- null //Player 2
::gmData <- {
	posX = 150 //X pos of first player
	posY = 150 //Y pos of first player
	dialogResponses = {} //Stores all responses from dialogs
};
::gmDataClear <- jsonWrite(gmData); //String copy of game data with all values cleared

::newGame <- function() {
	gmPlayer = newActor(Tux, gmData.posX, gmData.posY)
	gmActive = true
}

//::saveGame <- function() {
//
//}

::quitGame <- function() {
	gmActive = false
	gmData = jsonRead(gmDataClear)
	deleteActor(gmPlayer)
	gmPlayer = null
}

::updateGame <- function() {
	if(!gmActive) return //If not in-game, do not do anything.

	runActors()
	if(getcon("pause", "press")) quitGame() //Pressing the Pause key leaves the game.
	if(keyPress(k_d)) loadDialog(0) //TEMPORARY: Loads dialog number 0 by pressing "D" in-game.
}
