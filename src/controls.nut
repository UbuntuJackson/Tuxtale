::autocon <- { //Has nothing to do with Transformers
	up = false
	down = false
	left = false
	right = false
	jump = false
	shoot = false
}

::getcon <- function(control, state, useauto = false) {
	local keyfunc = 0
	local joyfunc = 0
	local hatfunc = 0

	switch(state) {
		case "press":
			keyfunc = keyPress
			joyfunc = joyButtonPress
			hatfunc = joyHatPress
			break
		case "release":
			keyfunc = keyRelease
			joyfunc = joyButtonRelease
			hatfunc = joyHatRelease
			break
		case "hold":
			keyfunc = keyDown
			joyfunc = joyButtonDown
			hatfunc = joyHatDown
			break
		default:
			return false
			break
	}

	switch(control) {
		case "up":
			if(keyfunc(k_up) || hatfunc(0, js_up) || (state == "hold" && joyY(0) < -js_max / 10)) return true
			if(state == "hold" && useauto) return autocon.up
			if(state == "press" && joyAxisPress(0, 1, js_max / 20) == -1) return true
			if(state == "release" && joyAxisRelease(0, 1, js_max / 20) == -1) return true
			break
		case "down":
			if(keyfunc(k_down) || hatfunc(0, js_down) || (state == "hold" && joyY(0) > js_max / 10)) return true
			if(state == "hold" && useauto) return autocon.down
			if(state == "press" && joyAxisPress(0, 1, js_max / 20) == 1) return true
			if(state == "release" && joyAxisRelease(0, 1, js_max / 20) == 1) return true
			break
		case "left":
			if(keyfunc(k_left) || hatfunc(0, js_left) || (state == "hold" && joyX(0) < -js_max / 10)) return true
			if(state == "hold" && useauto) return autocon.left
			if(state == "press" && joyAxisPress(0, 0, js_max / 20) == -1) return true
			if(state == "release" && joyAxisRelease(0, 0, js_max / 20) == -1) return true
			break
		case "right":
			if(keyfunc(k_right) || hatfunc(0, js_right) || (state == "hold" && joyX(0) > js_max / 10)) return true
			if(state == "hold" && useauto) return autocon.right
			if(state == "press" && joyAxisPress(0, 0, js_max / 20) == 1) return true
			if(state == "release" && joyAxisRelease(0, 0, js_max / 20) == 1) return true
			break
		case "sneak":
			if(keyfunc(config.key.sneak) || joyfunc(0, config.joy.sneak)) return true
			break
		case "pause":
			if(keyfunc(config.key.pause) || joyfunc(0, config.joy.pause)) return true
			break
		case "swap":
			if(keyfunc(config.key.swap) || joyfunc(0, config.joy.swap)) return true
			break
		case "accept":
			if(keyfunc(config.key.accept) || joyfunc(0, config.joy.accept)) return true
			break
		case "leftPeek":
			if(keyfunc(config.key.leftPeek) || joyfunc(0, config.joy.leftPeek)) return true
			break
		case "rightPeek":
			if(keyfunc(config.key.rightPeek) || joyfunc(0, config.joy.rightPeek)) return true
			break
		case "downPeek":
			if(keyfunc(config.key.downPeek) || joyfunc(0, config.joy.downPeek)) return true
			break
		case "upPeek":
			if(keyfunc(config.key.upPeek) || joyfunc(0, config.joy.upPeek)) return true
			break
	}

	return false
}
