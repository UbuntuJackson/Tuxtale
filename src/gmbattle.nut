::gmInactiveActors <- []
::battleMenu <- []
::gmBattlePhase <- null

::startBattle <- function(enemy){
	gmInactiveActors = clone(actor)
	actor = clone(actorsClear)
	print("startBattle")
	actor[newActor(EnemyBattle, 200, 200)]
	gvGameMode = gmBattleMode
	actor[newActor(Soul, screenW()/2, screenH()/2)]
	battleMenu = meBattle
	gmBattlePhase = gmBattleMenu
	gmCurrentBattle = enemy
}

::gmBattleMode <- function(){
	runActors()
	gmBattlePhase() //phase(), phase = gmBattleMenu, phase = Attack, phase = enemySpeak
	if(getcon("pause", "press") && gvGameOverlay == emptyFunc) setOverlay(updateMenu, mePause)
}

::gmBattleMenu <- function(optMenu = null){
	if(!battleMenu && !optMenu) return quitMenu(); //If no menu is loaded and no optional menu is given.
	if(!battleMenu) battleMenu = optMenu; //If an optional menu to use was given as a parameter, set it as the current menu, if there isn't one already.
	for(local index = 0; index < battleMenu.len(); index++) {
		//drawText(font, 10, 20 * (index + 1), menu[index].name()); //drawSprite(xc, yc, path+bright/dark)
		drawSprite(battleMenu[index].name(), 0, screenW()/2 + 41 * (index) - 41 * 3, screenH() - 37)
		if(menuSelectorPos == index) {
			setDrawColor(0xFFFFFF);
			drawSprite(battleMenu[index].name(), 1, screenW()/2 + 41 * (index) - 41 * 3, screenH() - 37);
		}
	}
	//Controls for menu navigation
	//Up
	if(getcon("left", "press")) {
		if(menuSelectorPos == 0) {
			menuSelectorPos = battleMenu.len() - 1;
			return;
		}
		menuSelectorPos--;
	}
	//Down
	if(getcon("right", "press")) {
		if(menuSelectorPos == battleMenu.len() - 1) {
			menuSelectorPos = 0;
			return;
		}
		menuSelectorPos++;
	}
	//Accept
	if(getcon("accept", "press") || (mousePress(0) && config.showcursor && cursorItem == menuSelectorPos)) {
		if(!menu[menuSelectorPos].rawin("func")) return;
		battleMenu[menuSelectorPos].func();
	}
	//Pause
	if(getcon("pause", "press") && menuBackTimeout <= 0) {
		/*if(!menu[menu.len() - 1].rawin("back")) return;
		menu[menu.len() - 1].back();*/
	}
	//if(menuBackTimeout > 0) menuBackTimeout--; //Count the current frame in the menu back timeout.

	//updateCursor() //Update the mouse cursor.
}

::meBattle <- [
	{
		name = function() {return sprButtonFight},
		func = function() {}
	},
	{
		name = function() {return sprButtonAct},
		func = function() {}
	},
	{
		name = function() {return sprButtonDefend},
		func = function() {}
	},
	{
		name = function() {return sprButtonItem},
		func = function() {}
	},
	{
		name = function() {return sprButtonMagic},
		func = function() {}
	},
	{
		name = function() {return sprButtonEnd},
		func = function() {}
	}
]

/*::EnemyBattle <- class extends Object{
	//x = 0
	//y = 0
	timer = 0
	restart = 0
	queue = []
	n = 0
	act = null
	s = 0
	max_number_of_projectiles = 0
	released = 0

	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		timer = 0
		queue = [c, d, e]
		//restart = 500
		if(!_arr) return
		if(_arr.len() >= 1) restart = _arr[0]
		n = 0
		s = 0
		max_number_of_projectiles = 20
		released = 0
		//timer = 0
		//drawText(font, x, y, "O")
	}

	function start_act(re, max){
		released = re
		max_number_of_projectiles = max
	}

	function end_act(re, max){
		if(gmMap.bullets.len() == 0){
			n += 1
			released = re
			max_number_of_projectiles = max
			//start_act()
		}
	}

	function c(){
		print("c")

		if(released != max_number_of_projectiles){
			if(getFrames() % 30 == 0){
				gmMap.bullets.push(actor[newActor(Bullet, 200, 200, [0.5, 0.5])])
				released += 1
			}
		}
		else{
			print("ending act")
			end_act(0, 200)
		}

		//number_of_projectiles == length of the bullets list
	}

	function d(){
		print("d")
		released = 0
		max_number_of_projectiles = 20

		if(released != max_number_of_projectiles){
			if(getFrames() % 30 == 0){
				gmMap.bullets.push(actor[newActor(Bullet, 200, 200, [-0.5, -0.5])])
				released += 1
			}
		}
		else{
			end_act(0, 20)
		}
	}

	function e(){
		gmMap.bullets.push(actor[newActor(Bullet, 200, 200, [1, 1])])
		n += 1
		print("e")
	}

	function run(){
		//schedule(100, c, "Some")
		//schedule(200, d, "additional")
		//schedule(300, e, "arguments")
		//print(gmMap.bullets.len())
		act = queue[n%3]
		act()

		//print("P")
		update_timer()
	}

	function schedule(time, event, letter){
		if(timer == time) event(letter)
	}

	function update_timer(){
		timer++
		//print(timer)
		if(timer >= restart) timer = 0
	}

	function _typeof(){
		return "Bullet"
	}

}

::Enemy <- class extends Actor{
	w = 8
	h = 8
	spr = sprObjects
	tile = 0
	solid = false
	visible = true
	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		if(!_arr) return
		if(_arr.len() >= 1) spr = _arr[0]
		if(_arr.len() >= 2) tile = _arr[1]
		if(_arr.len() >= 3) solid = _arr[2]
		if(_arr.len() >= 4) visible = _arr[3]
	}
	function run() {
		if(visible) draw()
	}
	function draw() {
		drawSprite(spr, tile, x - gmData.camX, y - gmData.camY)
	}
	function onCollision() {
		startBattle(this)
	}
	function _typeof(){
		return "Enemy"
	}
}

::Bullet <- class extends Object{
	hspeed = 0
	vspeed = 0
	destruction_timer = 0
	_id = 0

	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y

		_id = gmMap.bullets.len() //-1
		//timer = 0
		hspeed = 0.5
		vspeed = 0.5
		//restart = 500
		if(!_arr) return
		if(_arr.len() >= 1) hspeed = _arr[0]
		if(_arr.len() >= 2) vspeed = _arr[1]
		destruction_timer = 100
	}

	function run(){
		x += hspeed
		y += vspeed
		destruction_timer--
		if(destruction_timer <= 0){
			deleteActor(id)
			print(jsonWrite(gmMap.bullets))
		}
		drawText(font, x - gmData.camX, y - gmData.camY, "O")
	}
}

::Soul <- class extends Actor{
	frame = 0.0
	anim = [] //Animation frame delimiters: [start, end, speed]
	//anHurt = [3.0, 12.0, "hurt"]
	hspeed = 0
	vspeed = 0
	mspeed = 1
	yspeed = 0
	xspeed = 0
	diagonal = 1
	nsp = 2
	shape = 0
	w = 16
	h = 16
	step = 0

	constructor(_x, _y, _arr = null) {
		hspeed = 1
		anim = anStandRight
		nsp = 1.5
		x = _x
		y = _y
		w = 7
		h = 7
		step = 0
	}

	function collision(_x, _y) {
		foreach(tile in gmMap.tiles) {
			if(fabs(_x - tile.x) < w + tile.w && fabs(_y - tile.y) < h + tile.h) {
				return tile.solid
			}
		}
		foreach(obj in gmMap.objects) {
			if(fabs(_x - obj.x) < w + obj.w && fabs(_y - obj.y) < h + obj.h) {
				obj.onCollision()
				return obj.solid
			}
		}
	}

	function run() {

		if(gvGameOverlay != emptyFunc) { //If an overlay is active, update Tux without allowing him to move.
			return updateSoul()
		}

		if(xspeed != 0 && yspeed != 0) {
			diagonal = 0.707
		}
		else {
			diagonal = 1
		}

		if(!(getcon("right", "hold") || getcon("left", "hold"))) xspeed = 0
		if(!(getcon("up", "hold") || getcon("down", "hold"))) yspeed = 0

		if(getcon("right", "hold")) xspeed = (nsp * diagonal)
		if(getcon("left", "hold")) xspeed = (-nsp * diagonal)
		if(getcon("up", "hold")) yspeed = (-nsp * diagonal)
		if(getcon("down", "hold")) yspeed = (nsp * diagonal)

		if(collision(x + xspeed, y)) {
			xspeed = 0
		}

		if(collision(x, y + yspeed)) {
			yspeed = 0
		}

		if(collision(x + xspeed, y + yspeed)){
			yspeed = 0
			xspeed = 0
		}

		x += xspeed
		y += yspeed

	}

	function move(){
		if(getcon("right", "hold") || getcon("left", "hold") || getcon("up", "hold") || getcon("down", "hold")) return true
	}

	function press(){
		if(getcon("right", "press") || getcon("left", "press") || getcon("up", "press") || getcon("down", "press")) return true
	}

	function move_vertically(){
		if(getcon("right", "hold") || getcon("left", "hold")) return true
	}

	function move_horisontally(){
		if(getcon("up", "hold") || getcon("down", "hold")) return true
	}

	function move_diagonally(){
		if(move_horisontally() && move_vertically()) return true
	}

	function updateSoul() {
		frame += 0.1
		drawSprite(sprTaleTux, wrap(floor(frame), anim[0], anim[1]), x - gmData.camX, y - gmData.camY)
	}
}*/