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

::dialogsData <- jsonRead(fileRead("src/text/dialogs.json"))

::activeDialog <- null
::dialogSelectorPos <- 0

::loadDialog <- function(id) {
		dialogSelectorPos = 0
		activeDialog = id.tostring()
}

::updateDialogs <- function() {
		if(!activeDialog) return //If there is no active dialog, requested to be displayed.
		if(!dialogsData.rawin(activeDialog)) { //If the given dialog doesn't exist.
				print("Dialog with id " + activeDialog + " doesn't exist.")
				activeDialog = null
				return
		}

		//Draw main text
		if(dialogsData[activeDialog].rawin("moretext")) {
				drawText(font, screenW() / 2 - dialogsData[activeDialog]["text"].len() * fontWidth / 2, screenH() / 2 - 25, dialogsData[activeDialog]["text"])
				drawText(font, screenW() / 2 - dialogsData[activeDialog]["moretext"].len() * fontWidth / 2, screenH() / 2 - 12, dialogsData[activeDialog]["moretext"])
		}
		else {
				drawText(font, screenW() / 2 - dialogsData[activeDialog]["text"].len() * fontWidth / 2, screenH() / 2 - 10, dialogsData[activeDialog]["text"])
		}

		if(dialogsData[activeDialog].rawin("responses")) { //The dialog has responses to choose from.
				//Draw the responses.
				local responsesLeft = dialogsData[activeDialog]["responses"].len() //Responses left to print by the loop.
				for(local responseId = 0; responseId < dialogsData[activeDialog]["responses"].len(); responseId++) {
						local response = dialogsData[activeDialog]["responses"][responseId]
						local responsePosX = screenW() / 2 - response["text"].len() * fontWidth / 2
						local responsePosY = screenH() / 2 + 15 * (responseId + 1)
						drawText(font, responsePosX, responsePosY, response["text"])
						responsesLeft--

						if(dialogSelectorPos == responseId) { //The current response is selected.
								drawText(font, responsePosX - 15, responsePosY, ">")
								drawText(font, responsePosX + response["text"].len() * fontWidth + 4, responsePosY, "<")
						}
				}

				local responsesLength = dialogsData[activeDialog]["responses"].len()

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
						gmData.dialogResponses[activeDialog] <- dialogSelectorPos //Store the current response id.
						if(!dialogsData[activeDialog]["responses"][dialogSelectorPos].rawin("next")) {
								activeDialog = null
								return
						}
						activeDialog = dialogsData[activeDialog]["responses"][dialogSelectorPos]["next"]
				}
				//Pause - exit the dialog
				if(getcon("pause", "press")) activeDialog = null
		}
		else { //The dialog is just text.
				//Draw navigation arrows under the text
				if(dialogsData[activeDialog].rawin("back")) { //Draw an arrow pointing back only if the dialog can go back.
						drawSprite(font, 17, screenW() / 2.5, screenH() / 2 + 15)
				}
				drawSprite(font, 16, screenW() / 3.5 * 2, screenH() / 2 + 15)

				//Controls for navigating through dialogs
				//Left
				if(getcon("left", "press") && dialogsData[activeDialog].rawin("back")) {
						activeDialog = dialogsData[activeDialog]["back"]
				}
				//Right
				if(getcon("right", "press")) {
						gmData.dialogResponses[activeDialog] <- true //Indicate this dialog has been passed.
						//Check if a follow-up dialog is given. If not, close the dialogs.
						if(dialogsData[activeDialog].rawin("next")) activeDialog = dialogsData[activeDialog]["next"]
						else activeDialog = null
				}
		}
		//Pause (exit the dialogs)
		if(getcon("pause", "press")) activeDialog = null
}
