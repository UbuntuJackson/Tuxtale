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

::dialogsData <- jsonRead(fileRead("res/text/dialogs.json"))

::dialog <- null //Current dialog
::dialogSelectorPos <- 0 //Selector position

::updateDialog <- function(optDialog = null) {
		if(!dialog && !optDialog) return quitDialog() //If there is no active dialog and no optional one is given as a parameter.
		if(!dialog) dialog = optDialog //If an optional dialog to use was given as a parameter, set it as the current one, if there isn't one already.
		if(!dialogsData.rawin(dialog)) { //If the given dialog doesn't exist.
				print("Dialog with id " + dialog + " doesn't exist.")
				quitDialog()
				return
		}

		//Draw main text
		if(dialogsData[dialog].rawin("moretext")) {
				drawText(font, screenW() / 2 - dialogsData[dialog]["text"].len() * fontWidth / 2, screenH() / 2 - 25, dialogsData[dialog]["text"])
				drawText(font, screenW() / 2 - dialogsData[dialog]["moretext"].len() * fontWidth / 2, screenH() / 2 - 12, dialogsData[dialog]["moretext"])
		}
		else {
				drawText(font, screenW() / 2 - dialogsData[dialog]["text"].len() * fontWidth / 2, screenH() / 2 - 10, dialogsData[dialog]["text"])
		}

		if(dialogsData[dialog].rawin("responses")) { //The dialog has responses to choose from.
				//Draw the responses.
				local responsesLeft = dialogsData[dialog]["responses"].len() //Responses left to print by the loop.
				for(local responseId = 0; responseId < dialogsData[dialog]["responses"].len(); responseId++) {
						local response = dialogsData[dialog]["responses"][responseId]
						local responsePosX = screenW() / 2 - response["text"].len() * fontWidth / 2
						local responsePosY = screenH() / 2 + 15 * (responseId + 1)
						drawText(font, responsePosX, responsePosY, response["text"])
						responsesLeft--

						if(dialogSelectorPos == responseId) { //The current response is selected.
								drawText(font, responsePosX - 15, responsePosY, ">")
								drawText(font, responsePosX + response["text"].len() * fontWidth + 4, responsePosY, "<")
						}
				}

				local responsesLength = dialogsData[dialog]["responses"].len()

				//Controls for choosing a response
				//Up
				if(getcon("up", "press")) {
						if(dialogSelectorPos == 0) {
							dialogSelectorPos = responsesLength - 1;
							return;
						}
						dialogSelectorPos--;
				}
				//Down
				if(getcon("down", "press")) {
						if(dialogSelectorPos == responsesLength - 1) {
							dialogSelectorPos = 0;
							return;
						}
						dialogSelectorPos++;
				}
				//Accept
				if(getcon("accept", "press")) {
						gmData.dialogResponses[dialog] <- dialogSelectorPos //Store the current response id.
						if(!dialogsData[dialog]["responses"][dialogSelectorPos].rawin("next")) {
								quitDialog()
								return
						}
						goToDialog(dialogsData[dialog]["responses"][dialogSelectorPos]["next"])
				}
				//Pause - exit the dialog
				if(getcon("pause", "press")) quitDialog()
		}
		else { //The dialog is just text.
				//Draw navigation arrows under the text
				if(dialogsData[dialog].rawin("back")) { //Draw an arrow pointing back only if the dialog can go back.
						drawSprite(font, 17, screenW() / 2.5, screenH() / 2 + 15)
				}
				drawSprite(font, 16, screenW() / 3.5 * 2, screenH() / 2 + 15)

				//Controls for navigating through dialogs
				//Left
				if(getcon("left", "press") && dialogsData[dialog].rawin("back")) {
						goToDialog(dialogsData[dialog]["back"])
				}
				//Right
				if(getcon("right", "press")) {
						gmData.dialogResponses[dialog] <- true //Indicate this dialog has been passed.
						//Check if a follow-up dialog is given. If not, close the dialogs.
						if(dialogsData[dialog].rawin("next")) goToDialog(dialogsData[dialog]["next"])
						else quitDialog()
				}
		}
		//Pause (exit the dialogs)
		if(getcon("pause", "press")) quitDialog()
}
::goToDialog <- function(newDialog) {
	dialogSelectorPos = 0
	dialog = newDialog
}
::quitDialog <- function() {
		dialogSelectorPos = 0
		dialog = null
		if(gvGameOverlay != emptyFunc) resetOverlay()
}
