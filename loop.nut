donut("global.nut");
donut("controls.nut");
donut("tux.nut");
donut("speech.nut");
donut("collision.nut");
//donut("map.nut");

::gvPlayer <- newActor(Tux, 200, 200)
for(local i = 0; i < 5; i++){
    objects.push(actor[newActor(Solid, i * 16, 64)])
}
for(local i = 0; i < 10; i++){
    objects.push(actor[newActor(Solid, 90, 16 * i)])
}
objects.push(actor[newActor(Solid, 16, 16)])
objects.push(actor[newActor(Solid, 32, 16)])

::main <- function() {
	//Set up the window
	setFPS(120)
	setResolution(400, 240)
	setWindowTitle("Test")
	gvQuit = 0

	//Main game loop
	while(!gvQuit) {
		if(getQuit()) break
        Dialogue("000")
        runActors()
        //if(getcon("down", "press")) cursor++
        //if(getcon("up", "press")) Queue(textobj["000"]["response"][cursor]["next"])
        update()
	}
}

main();