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
