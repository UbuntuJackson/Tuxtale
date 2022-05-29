::gmCurrentBattle <- null

::EnemyBattle <- class extends Physactor{
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
	init = false

	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		print("created")
		timer = 0
		queue = [c, d, e, f]
		max_number_of_projectiles = 20
		print(max_number_of_projectiles)
		released = 0
		init = false
		//restart = 500
		if(!_arr) return
		if(_arr.len() >= 1) restart = _arr[0]
		//timer = 0
		//drawText(font, x, y, "O")
	}

	function start_act(re, max){
		released = re
		max_number_of_projectiles = max
	}

	function end_act(){
		released = 0
		n+=1
		init = false
	}

	function c(){
		max_number_of_projectiles = 10
		print("c")
		print(released)
		print(max_number_of_projectiles)
		if(released < max_number_of_projectiles){
			if(getFrames() % 30 == 0){
				actor[newActor(Bullet, 200, 200, [0.5, 0.5])]
				released += 1
			}
		}
		else{
			print("ending act")
			end_act()
		}

		//number_of_projectiles == length of the bullets list
	}

	function d(){
		print("d")
		max_number_of_projectiles = 5
		if(released < max_number_of_projectiles){
			if(getFrames() % 30 == 0){
				actor[newActor(Bullet, 200, 200, [-0.5, -0.5])]
				released += 1
			}
		}
		else{
			end_act()
		}
	}

	function e(){
		print("e")
		max_number_of_projectiles = 10
		if(released < max_number_of_projectiles){
			if(getFrames() % 30 == 0){
				actor[newActor(Bullet, 200, 200, [1, 1])]
				released += 1
			}
		}
		else{
			end_act()
		}
	}

	function f(){
		if(init == false){
			timer = 100
			init = true
		}
		timer--
		if(timer > 0){
			drawText(font, 200, 200, "Attack F")
		}
		else{
			end_act()
		}
	}

	function run(){
		//schedule(100, c, "Some")
		//schedule(200, d, "additional")
		//schedule(300, e, "arguments")
		//print(gmMap.bullets.len())
		act = queue[n%queue.len()]
		act()

		//print("P")
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

::Enemy <- class extends Physactor{
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

		if(collision(x, y, "gmPlayer")[0]){
			startBattle(this)
		}
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
			//print(jsonWrite(gmMap.bullets))
		}
		drawText(font, x, y, "O")
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

	constructor(_x, _y, _arr = null) {
		hspeed = 1
		nsp = 1.5
		x = _x
		y = _y
		w = 7
		h = 7
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

		updateSoul()

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
		drawSprite(sprSoul, 0, x, y)
	}
}