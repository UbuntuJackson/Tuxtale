::Physactor <- class extends Actor{
	xspeed = 0.0
	yspeed = 0.0
	xstart = 0.0
	ystart = 0.0
	xprev = 0.0
	yprev = 0.0
	shape = 0

	constructor(_x, _y, _arr = null) {
		base.constructor(_x, _y)
		xstart = _x
		ystart = _y
	}

	function collision(_x, _y, _obj) {
		if(actor.rawin(_obj)) foreach (i in actor[_obj]) {
			if(fabs(_x - i.x) < w + i.w && fabs(_y - i.y) < h + i.h) {
				return [true, i]
			}

		}
		return [false]
	}

	function run() {
		xprev = x
		yprev = y
	}

	function placeFree(_x, _y){
		local ns
		if(typeof shape == "Rec") ns = Rec(_x + shape.ox, _y + shape.oy, shape.w, shape.h, shape.kind)
		local cx = floor(_x / 16)
		local cy = floor(_y / 16)
		local cw = ceil(shape.w / 16)
		local ch = ceil(shape.h / 16)

	}

	function onCollision(entity){

	}
}

::Rec <- class {
	x = 0.0
	y = 0.0
	w = 0.0
	h = 0.0
	kind = 0
	ox = 0.0
	oy = 0.0

	constructor(_x, _y, _w, _h, _kind, _ox = 0.0, _oy = 0.0) {
		x = _x.tofloat()
		y = _y.tofloat()
		w = _w.tofloat()
		h = _h.tofloat()
		kind = _kind

		//Prevent zero dimensions
		//It's important, trust me
		if(w <= 0) w = 0.1
		if(h <= 0) h = 0.1
		ox = _ox.tofloat()
		oy = _oy.tofloat()
	}

	function _typeof() { return "Rec" }

	function setPos(_x, _y) {
		x = _x.tofloat() + ox
		y = _y.tofloat() + oy
	}

	function draw() {
		drawRect(x - w - gmData.camX, y - h - gmData.camY, (w * 2) + 1, (h * 2) + 1, false)
	}

	function _typeof() { return "Rec" }
}

/*::collision <- function(a, b) {

	if(fabs(a.x - b.x) < a.w + b.w && fabs(a.y - b.y) < a.h + b.h) {
		b.onCollision()
		return b.solid
	}

}

::placeFree <- function(_x, _y){
	local ns
	if(typeof shape == "Rec") ns = Rec(_x + shape.ox, _y + shape.oy, shape.w, shape.h, shape.kind)
	if(typeof shape == "Cir") ns = Cir(_x + shape.ox, _y + shape.oy, shape.r)
	local cx = floor(_x / 16)
	local cy = floor(_y / 16)
	local cw = ceil(shape.w / 16)
	local ch = ceil(shape.h / 16)



}*/