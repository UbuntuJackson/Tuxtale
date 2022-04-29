::textsData <- jsonRead(fileRead("src/text/texts.json"))

::activeDialog <- null
::dialogSelectorPos <- 0

::dialogResponses <- [] //Stores all responses from dialogs with the dialog's id.

::loadDialog <- function(id) {
		activeDialog = id
}

::updateDialogs <- function() {
		if (!activeDialog) return //If there is no active dialog, requested to be displayed.

		drawText(font, screenW() / 2 - textsData[activeDialog]["text"].len() * fontWidth / 2, screenH() / 2 - 15, textsData[activeDialog]["text"])

		if(textsData[activeDialog]["type"] == "option") {
				local responsesLeft = textsData[activeDialog]["responses"].len() //Responses left to print by the loop.
				for(local responseId = 0; responseId < textsData[activeDialog]["responses"].len(); responseId++) {
						local response = textsData[activeDialog]["responses"][responseId]
						local responsePosX = screenW() / 2 - response["text"].len() * fontWidth / 2
						local responsePosY = screenH() / 2 + 15 * (responseId + 1)
						drawText(font, responsePosX, responsePosY, response["text"])
						responsesLeft--

						if(dialogSelectorPos == responseId) { //The current response is selected.
								drawText(font, responsePosX - 15, responsePosY, ">")
								drawText(font, responsePosX + response["text"].len() * fontWidth + 4, responsePosY, "<")
						}
				}

				local responsesLength = textsData[activeDialog]["responses"].len()

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
						dialogResponses.append({"id": activeDialog, "response": dialogSelectorPos + 1}) //Store the current response.
						print(jsonWrite(dialogResponses))
						if(!textsData[activeDialog][dialogSelectorPos].rawin("next")) return
						activeDialog = textsData[activeDialog][dialogSelectorPos]["next"]
				}
				//Pause (exit the dialog)
				if(getcon("pause", "press")) {
						activeDialog = null
						return
				}
		}
}
