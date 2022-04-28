// Tuxtale
// Copyright (C) 2022 UbuntuJackson

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

//::speech_id <- 0
//::text <- 0
::textObj <- jsonRead(fileRead("src/text/texts.json"))
local next = ""

::cursor <- 0

::queue <- function(n){
    next = textObj[n]["next"]
    return textObj[n]["text"]
}

//print(queue(next))

::dialogue <- function(text){
    if(textObj[text]["type"] != "non option"){
        foreach(value, i in textObj[text]["response"]){
            //print(i["text"])
            drawText(font, 200, value * 20, i["text"].tostring())
        }
    }
    else{
        print(queue(text))
    }
}

if(getcon("down", "press")) cursor++
if(getcon("up", "press")) queue(textObj["000"]["response"][cursor]["next"])

dialogue("000")
drawText(font, 20, 20, cursor.tostring())
//dialogue(next)
//print(textObj["000"]["response"][0]["text"])
//print(textObj["000"]["response"][1]["text"])

/*foreach(i in textObj["000"]["response"]){
    print(i["text"])
}*/
