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

::Map <- class {
	path = "res/map/test.json" //Path to the map
	map = null //Stores the loaded map file
	tiles = [] //List for keeping all tiles in a map.
	objects = [] //List for keeping all objects in a map.
	constructor(_path = null) {
		if(_path) path = _path
		map = jsonRead(fileRead(path))
		loadMap()
	}
	function loadMap() { //Load the given Tiled map.
		//Create all tiles.
		foreach(layer in map["layers"]) {
			if(!layer.rawin("data")) continue
			local tileDataIterator = 0;
			for(local y = 1; y <= layer["height"]; y++) {
				for(local x = 1; x <= layer["width"]; x++) {
					if(layer["data"][tileDataIterator] > 0)
						tiles.push(actor[newActor(Tile, 16 * x, 16 * y, [sprCollision, layer["data"][tileDataIterator] - 1, !getProperty(layer, "unsolid"), layer["visible"]])])
					tileDataIterator++
				}
			}
		}
		//Create all objects.
		local firstGid = getFirstGid("objects")
		foreach(layer in map["layers"]) {
			if(!layer.rawin("objects")) continue
			foreach(object in layer["objects"]) {
				objects.push(actor[newActor(Object, object["x"], object["y"], [sprObjects, object["gid"] - firstGid, getProperty(object, "solid") && !getProperty(layer, "unsolid"), object["visible"] && layer["visible"]])])
			}
		}
	}
	//Functions to help utilize maps.
	function getProperty(obj, propertyName) { //Get a specified Tiled property in an object, if the property exists.
		if(obj.rawin("properties")) foreach(property in obj["properties"]) {
			if(property["name"] == propertyName) {
				return property["value"]
			}
		}
		return null
	}
	function getFirstGid(tilesetName) {
		foreach(tileset in map["tilesets"]) {
			if(tileset.rawin("name")) if(tileset["name"] == tilesetName) {
				return tileset["firstgid"]
			}
		}
		return 0
	}
}
