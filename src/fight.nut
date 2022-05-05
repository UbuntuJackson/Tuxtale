::Opponent <- class extends Actor{

	timer = 0

	constructor(_x, _y, _arr = null) {
		x = _x
		y = _y
		if(!_arr) return
		timer = 200
	}

	function c(){
		print("event")
	}

	function run(){
		schedule(100, c, "x")
		timer--
		if(timer <= 0) timer = 200
	}

	function schedule(time, event, letter){
		if(timer == time) event(letter)
	}


}

newActor(Opponent, 200, 200)