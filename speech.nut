//::speech_id <- 0
//::text <- 0
::textobj <- jsonRead(fileRead("texts.json"))
local next = ""

::cursor <- 0

::Queue <- function(n){
    next = textobj[n]["next"]
    return textobj[n]["text"]
}

//print(Queue(next))

::Dialogue <- function(text){
    if(textobj[text]["type"] != "non option"){
        foreach(value, i in textobj[text]["response"]){
            //print(i["text"])
            drawText(font, 200, value * 20, i["text"].tostring())
        }
    }
    else{
        print(Queue(text))
    }
}

if(getcon("down", "press")) cursor++
if(getcon("up", "press")) Queue(textobj["000"]["response"][cursor]["next"])

Dialogue("000")
drawText(font, 20, 20, cursor.tostring())
//Dialogue(next)
//print(textobj["000"]["response"][0]["text"])
//print(textobj["000"]["response"][1]["text"])

/*foreach(i in textobj["000"]["response"]){
    print(i["text"])
}*/



