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
::gmPlay <- false //Currently in-game
::gmPlayer <- null //Player 1
//::gmPlayer2 <- null //Player 2
::gmData <- {
	posX = 0
	posY = 0
};
::gmDataClear <- gmData; //Copy of game data with all values cleared

::newGame <- function() {
	gmData.posX = 150
	gmData.posY = 150
	gmPlayer = newActor(Tux, gmData.posX, gmData.posY)
	gmPlay = true
}

//::saveGame <- function() {
//
//}

::quitGame <- function() {
	gmPlay = false
	gmData = gmDataClear
	deleteActor(gmPlayer)
	gmPlayer = null
}
