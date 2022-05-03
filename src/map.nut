// Tuxtale
// Copyright (C) 2022 Vankata453

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

::gmMap <- null //The map that's currently loaded in-game.

::loadMap <- function(pathToMap) { //Load a given Tiled map.
	gmMap = jsonRead(fileRead(pathToMap))
	//Create all tiles.
	foreach(layer in gmMap["layers"]) {
		if(!layer.rawin("data") || !layer["visible"]) continue
		local tileDataIterator = 0;
		for(local y = 1; y <= layer["height"]; y++) {
			for(local x = 1; x <= layer["width"]; x++) {
				if(layer["data"][tileDataIterator] > 0)
					tiles.push(actor[newActor(Tile, 16 * x, 16 * y, [sprCollision, layer["data"][tileDataIterator] - 1])])
				tileDataIterator++
			}
		}
	}
	//Create all objects.
	local firstGid = 1
	foreach(tileset in gmMap["tilesets"]) {
		if(tileset.rawin("name")) if(tileset["name"] == "objects") firstGid = tileset["firstgid"]
	}
	foreach(layer in gmMap["layers"]) {
		if(!layer.rawin("objects") || !layer["visible"]) continue
		foreach(object in layer["objects"]) {
			objects.push(actor[newActor(Object, object["x"], object["y"], [sprObjects, object["gid"] - firstGid])])
		}
	}
}
