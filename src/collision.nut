::objects <- []
::nr <- ["x"]

::Solid <- class extends Actor {
    w = 16
    h = 16
    constructor(_x, _y, _arr = null){
        x = _x
        y = _y
        w = 16
        h = 16
    }
    function run(){
        drawSprite(sprTile, 0, x, y)
    }
}
