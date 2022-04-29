::Tux <- class extends Actor {
    frame = 0.0
    anim = [] //Animation frame delimiters: [start, end, speed]
	anStandRight = [0.0, 0.0, "standright"]
    anStandLeft = [12.0, 12.0, "standleft"]
    anStandUp = [4.0, 4.0, "standup"]
    anStandDown = [8.0, 8.0, "standdown"]
	anWalkRight = [0.0, 3.0, "walkright"]
    anWalkDown = [8.0, 11.0, "walkdown"]
    anWalkUp = [4.0, 7.0, "walkup"]
    anWalkLeft = [12.0, 15.0]
	//anHurt = [3.0, 12.0, "hurt"]
    hspeed = 0
    vspeed = 0
    mspeed = 1
    ysort = 0
    xsort = 0
    diagonal = 1
    nsp = 1
    face = 0
    shape = 0
    w = 16
    h = 16
    
    constructor(_x, _y, _arr = null){
        hspeed = 1
        anim = anStandRight
        nsp = 1
        x = _x
        y = _y
        w = 0.1
        h = 0.1
    }

    function collision(_x, _y){
        foreach(obj in objects){
            if(fabs(_x - obj.x) < w + obj.w && fabs(_y - obj.y) < h + obj.h){
                return true
            }
        }
    }

    function run(){
        if(xsort != 0 && ysort != 0){
            diagonal = 0.707
        }
        else{
            diagonal = 1
        }

				if(!activeDialog) { //If a dialog is active, don't allow moving the player.
						if(!(getcon("right", "hold") || getcon("left", "hold"))) xsort = 0
						if(!(getcon("up", "hold") || getcon("down", "hold"))) ysort = 0

						if(getcon("right", "hold")) xsort = (nsp * diagonal)
						if(getcon("left", "hold")) xsort = (-nsp * diagonal)
						if(getcon("up", "hold")) ysort = (-nsp * diagonal)
						if(getcon("down", "hold")) ysort = (nsp * diagonal)
				}

        if(xsort > 0){
            anim = anWalkRight
            face = 0
            //queue(next)
        }
        if(xsort < 0){
            anim = anWalkLeft
            face = 1
        }
        if(ysort > 0){
            anim = anWalkDown
            face = 2
        }
        if(ysort < 0){
            anim = anWalkUp
            face = 3
        }

        if(xsort == 0 && ysort == 0){
            switch(face){
                case 0:
                    anim = anStandRight
                    break
                case 1:
                    anim = anStandLeft
                    break
                case 2:
                    anim = anStandDown
                    break
                case 3:
                    anim = anStandUp
                    break
            }
        }

        if(collision(x + xsort, y)){
            xsort = 0
        }

        if(collision(x, y + ysort)){
            ysort = 0
        }

        x+=xsort
        y+=ysort

        //print(jsonWrite(objects))
        
        frame += 0.05
        drawSprite(sprTaleTux, wrap(floor(frame), anim[0], anim[1]), x, y)
        //drawSpriteExZ(0, sprite, floor(frame), x - camx, y - camy, 0, flip, 1, 1, 1)
        //drawText(font, x + 20, y + 20, diagonal.tostring())
        //drawText(font, 20, 20, cursor.tostring())
    }
}
