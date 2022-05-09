::Opponent <- class extends Object{
	//x = 0
	//y = 0
	timer = 0
	restart = 0

	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		timer = 0
		//restart = 500
		if(!_arr) return
		if(_arr.len() >= 1) restart = _arr[0]
		//timer = 0
		//drawText(font, x, y, "O")
	}

	

	function c(additional_info){
		print("attack 1 " + additional_info)
	}

	function d(additional_info){
		print("attack 2 " + additional_info)
	}
	
	function e(additional_info){
		print("attack 3 " + additional_info)
	}

	function run(){
		schedule(100, c, "Some")
		schedule(200, d, "additional")
		schedule(300, e, "arguments")
		//print("P")
		update_timer()
	}

	function schedule(time, event, letter){
		if(timer == time) event(letter)
	}

	function update_timer(){
		timer++
		print(timer)
		if(timer >= restart) timer = 0
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
			//gmMap.bullets.remove(_id)
			deleteActor(id)
			print(jsonWrite(gmMap.bullets))
		}
		drawText(font, x - gmData.camX, y - gmData.camY, "O")
	}
}

::Opponent2 <- class extends Object{
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

	function wait(t){
		s++
		if(s == t) return
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
		print(gmMap.bullets.len())
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

//Bullet rain defined
