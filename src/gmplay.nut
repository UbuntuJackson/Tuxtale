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
::gmSave <- null //The id of the save file currently used
::gmMap <- null //The map that's currently loaded
::gmPlayer <- null //Player 1
//::gmPlayer2 <- null //Player 2
::gmData <- {
	map = "test2.json" //The map to be loaded
	posX = 64 //X pos of first player (default value, if no spawnpoint is found)
	posY = 96 //Y pos of first player (default value, if no spawnpoint is found)
	camX = 64 - 180 //X pos of the camera (default value, if no spawnpoint is found)
	camY = 96 - 130 //Y pos of the camera (default value, if no spawnpoint is found)
	dialogResponses = {} //Stores all responses from dialogs
};
::gmDataClear <- clone(gmData); //Copy of game data with all values cleared

//Define the in-game gamemode.
::gmPlay <- function() {
	if(gvGameMode != gmPlay) return //If not in-game, do not do anything.

	runActors()
	//Update position and camera data of the player in game data.
	gmData.posX = gmPlayer.x
	gmData.posY = gmPlayer.y
	gmData.camX += gmPlayer.xsort
	gmData.camY += gmPlayer.ysort
	//gmPlayer.xsort = 1

	if(getcon("pause", "press") && gvGameOverlay == emptyFunc) setOverlay(updateMenu, mePause) //Pressing the Pause key pauses the game.
}

//Additional functions for managing the in-game gamemode.

::startGame <- function(saveNum = 1) {
	local saveExists = false //Indicates if the current save file wasn't empty.
	gmSave = saveNum
	if(fileExists("save/save" + gmSave + ".json")) { //Load game progress from save file, if it exists.
		gmData = mergeTable(gmData, jsonRead(fileRead("save/save" + gmSave + ".json")))
		saveExists = true
	}
	gmMap = Map("res/map/" + gmData.map) //Create a Map instance for the current map
	gmMap.load() //Load the current map
	if(gmMap.spawnpoint && !saveExists) { //If a spawnpoint exists in the current map and an empty save is being entered, use it.
		gmData.posX = gmMap.spawnpoint["x"]
		gmData.posY = gmMap.spawnpoint["y"]
		gmData.camX = gmData.posX - 180
		gmData.camY = gmData.posY - 130
	}
	gmPlayer = actor[newActor(Tux, gmData.posX, gmData.posY)] //Define the player (Tux)
	gvGameMode = gmPlay
}

::saveGame <- function() {
	fileWrite("save/save" + gmSave + ".json", jsonWrite(gmData)) //Save game progress to a save file.
}

::quitGame <- function() {
	gvGameMode = gmMenu
	saveGame()
	gmData = clone(gmDataClear) //Reset game progress to default values.
	actor = clone(actorsClear) //Clear all actors.
	gmPlayer = null
	gmMap = null
	gmSave = null
}
