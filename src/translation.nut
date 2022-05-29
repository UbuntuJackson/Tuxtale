// Tuxtale
// Copyright (C) 2022 mrkubax10

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

::Translation <- class {
	// Contains currently selected language
	lang = "en"
	// Contains translation loaded from .json
	translationData = {}
	// Contains translation data in English (used for failback)
	translationDataEn = jsonRead(fileRead("res/lang/en.json"))

	/*
	* \brief Changes selected language
	* \param langToSet Language that has to be used
	*/
	function setLanguage(langToSet) {
		lang = langToSet
		if(lang == "en") {
			translationData = {}
			return
		}
		local langFile = "res/lang/" + lang + ".json"
		if(!fileExists(langFile))
			return
		translationData = jsonRead(fileRead(langFile))
	}

	/*
	* \brief Returns translation of msgid in selected language, if msgid is not found in lang file, it returns msgid back
	* \param msgCategory - The category of the message; msgId - The ID of the string to be translated
	* \returns Translated string
	*/
	function tr(msgCategory, msgId) {
		if(!translationData.rawin(msgCategory)) return translationDataEn[msgCategory][msgId]
		if(!translationData[msgCategory].rawin(msgId)) return translationDataEn[msgCategory][msgId]
		return translationData[msgCategory][msgId]
	}
}
::translation <- Translation()
