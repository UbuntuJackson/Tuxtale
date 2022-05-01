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

::objects <- [] //The list that objects are added to. However, I think we can replace this with the actor list.
::portals <- []
::map_0 <- [
        ["x", " ", " ", " ", " ", " ", " ", " ", " ", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x"],
        ["x", " ", "x", " ", "x", " ", " ", "x", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", "x", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", "x", "x", "x", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", "p", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", "x", "x", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", " ", "x", "x", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", " ", "x", "x", "x", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", "x", "x", "x", "x", "x", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"],
        ["x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x"]
        ]

::map_1 <- [
            [" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", "p", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", "x", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", "x", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", "x", " ", "x", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "x", " ", " "],
            [" ", " ", " ", " ", " "]
            ]

::map_3 <- []

::map_2 <-[[
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            "x            x       x                   x",
            "x      x  xxpx       x                   x",
            "x   xxxx  x          x                   x",
            "x      xxxx          x                   x",
            "x      x          xxxxxxx            xxxxx",
            "xxxx         x                 x     x    ",
            "      x           xxxxxxx      x     x   x",
            "xxxxxxx s    xxxxxx            x     x   x",
            "x                                        x",
            "x                                        x",
            "x                                        x",
            "x                      xxxxxxxxx     x   x",
            "x          x           x       x     x   x",
            "x          x           x       x     x   x",
            "x          x        x  x       x     x   x",
            "x          x     x xxx x       x     x   x",
            "x          x     x  x  x       x     x   x",
            "x          x     x     x       xxxxxxx   x", 
            "xxxxx   xxxxxxx  x  x  x                 x",
            "           x        x                    x",
            "           x        x                    x",
            "           x        x                    x",
            "xxx        x        x                    x",
            "           x        x                    x",
            "           x                       xxx   x"
            ], [map_3]]

::map_3 <- [["xxxxxxxx", "x   p   x"],[]]

::convert_map <- function(map){
    //local map = [["s", "t"], ["r", "i"]] //["s", "t"] -> "st" 
    local b = []
    local str = ""

    //b.push(["string"])

    foreach(i in map){
        foreach(j in i){
            foreach(k in j){
                str += k.tochar()
            }
            
        }
        b.push(str)
        str = ""
    }

    //foreach(i in b) print(i)

    return b;
}

::solid <- class extends Actor {
    w = 16
    h = 16
    constructor(_x, _y, _arr = null) {
        x = _x
        y = _y
        w = 8
        h = 8
    }
    function run() {
        drawSprite(sprTile, 0, x - gmData.camX, y - gmData.camY)
    }
}

::load_map_obsc <- function(map){
    foreach(a, i in map){
        foreach(b, j in map[a]){
            if(j == "x") objects.push(actor[newActor(solid, 16 * b, 16 * a)])
            if(j == "p") gmPlayer = newActor(Tux, 16 * b, 16 * a)
        }
    }
}

::load_map <- function(map){
    foreach(a, i in map[0]){
        foreach(b, j in i){
            if(j.tochar() == "x") objects.push(actor[newActor(solid, 16 * b, 16 * a)])
            if(j.tochar() == "p") gmPlayer = newActor(Tux, 16 * b, 16 * a)
            if(j.tochar() == "s") portals.push(actor[newActor(Portal, 16*b, 16*a, map[1][0])])
        }
    }
}

::Portal <- class extends Actor{
    _map = null
    w = 0
    h = 0
    
    constructor(_x, _y, _arr = null){
        x = _x
        y = _y
        w = 8
        h = 8
		_arr = []
        _arr.push(_map)
    }
    function run(){
        drawText(font, x - gmData.camX, y-gmData.camY, "S")
		
		//if(distance2(gmPlayer.x, x, gmPlayer.y, y) < 8)

		/*if(gmPlayer){
			if(fabs(x - gmPlayer.x) < w + gmPlayer.x && fabs(y - gmPlayer.y) < h + gmPlayer.h){
				load_map(_map)
			}
		}*/
    }
}