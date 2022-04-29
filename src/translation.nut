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
	m_lang="en"
	// Contains translation loaded from .json
	m_translationData={}


	/*
	* \brief Changes selected language
	* \param lang Language that has to be used
	*/
	function setLanguage(lang) {
		m_lang=lang
		if(lang=="en") {
			m_translationData={}
			return
		}
		local langFile="res/lang/"+lang+".json"
		if(!fileExists(langFile))
			return
		m_translationData=jsonRead(fileRead(langFile))
	}

	/*
	* \brief Returns translation of msgid in selected language, if msgid is not found in lang file, it returns msgid back
	* \param msgid String to be translated
	* \returns Translated string
	*/
	function tr(msgid) {
		if(!m_translationData.rawin(msgid))
			return msgid
		return m_translationData[msgid]
	}
}
::gvTranslation <- Translation()
