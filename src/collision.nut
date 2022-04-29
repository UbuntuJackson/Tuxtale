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
::nr <- ["x"]

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
