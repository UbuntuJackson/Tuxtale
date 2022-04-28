//Game data
::gmPlay <- false //Currently in-game
::gvPlayer <- null //Player 1
//::gvPlayer2 <- null //Player 2
::gmData <- {
	posX = 0
	posY = 0
};
::gmDataClear <- gmData; //Copy of game data with all values cleared

::newGame <- function() {
	gmData.posX = 150
	gmData.posY = 150
	gvPlayer = newActor(Tux, gmData.posX, gmData.posY)
	gmPlay = true
}

//::saveGame <- function() {
//
//}

::quitGame <- function() {
	gmPlay = false
	gmData = gmDataClear
	deleteActor(gvPlayer)
	gvPlayer = null
}
