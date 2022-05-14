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
	path = null //Path to the map
	map = null //Stores the loaded map file
	tiles = null //List for keeping all tiles in a map.
	objects = null //List for keeping all objects in a map.
	enemies = null
	spawnpoint = null //The first found spawnpoint in the map.

	constructor(_path = null) {
		//Set all class variables to their initial values.
		path = "res/map/test2.json"
		tiles = []
		objects = []
		enemies = []
		//If a path to a map is given, load it.
		if(_path) path = _path
		map = jsonRead(fileRead(path))
	}
	function load() { //Load the given Tiled map.
		//Create all tiles.
		foreach(layer in map["layers"]) {
			if(!layer.rawin("data")) continue
			local tileDataIterator = 0;
			//Iterate through all tiles in a layer and create them accordingly with their IDs.
			for(local y = 1; y <= layer["height"]; y++) {
				for(local x = 1; x <= layer["width"]; x++) {
					local tileId = layer["data"][tileDataIterator]
					if(tileId > 0) {
						local tilesetData = getTileset(tileId) //Structure: [tileset, firstGID].
						tiles.push(actor[newActor(Tile, 16 * x, 16 * y, [tilesetData[0], tileId - tilesetData[1], !getProperty(layer, "unsolid"), layer["visible"]])])
					}
					tileDataIterator++
				}
			}
		}
		//Create all objects.
		foreach(layer in map["layers"]) {
			if(layer.rawin("objects")){
				//Iterate through all objects in a layer and create them accordingly with their IDs.
				foreach(object in layer["objects"]) {
					local tilesetData = getTileset(object["gid"]) //Structure: [tileset, firstGID].
					objects.push(actor[newActor(Object, object["x"] + 16, object["y"], [tilesetData[0], object["gid"] - tilesetData[1], getProperty(object, "solid") && !getProperty(layer, "unsolid"), object["visible"] && layer["visible"]])])
					if(getProperty(object, "spawnpoint") && !spawnpoint) spawnpoint = {"x": object["x"] + 16, "y": object["y"]} //If that's the first object with the property "spawnpoint" set to true, set it as the current spawnpoint.
				}
			}

			/*if(layer.rawin("enemies")){

				foreach(enemy in layer["enemies"]){
					local tilesetData = getTileset(enemy["gid"])
					enemies.push(actor[newActor(Object, object["x"] + 16, object["y"]. [tilesetData[0], object["gid"] - tilesetData[1], getProperty(object, "solid") && !getProperty(layer, "unsolid"), object["visible"] && layer["visible"]])])
					if(getProperty(object, "spawnpoint") && !spawnpoint) spawnpoint = {"x": object["x"] + 16, "y": object["y"]} //If that's the first object with the property "spawnpoint" set to true, set it as the current spawnpoint.
				}
			}*/
		}
	}
	//Functions to help utilize maps.
	function getProperty(obj, propertyName) { //Get a specified Tiled property in an object, if the property exists.
		if(obj.rawin("properties")) foreach(property in obj["properties"]) {
			if(property["name"] == propertyName) return property["value"]
		}
		return null
	}
	function getTileset(tileGID) { //Get which tileset a tile is a part of, according to which firstGID it falls into. Returns the tileset ID and its firstGID.
		//For each tileset, check if the current tile ID is within its tilesetGID and isn't going over its tile count.
		for(local tileset = 0; tileset < map["tilesets"].len(); tileset++) {
			local tilesetGID = map["tilesets"][tileset]["firstgid"]
			local tilesetTileCount = map["tilesets"][tileset]["tilecount"]
			if(tileGID >= tilesetGID && tileGID < tilesetTileCount + tilesetGID) return [findSprite(fileFromPath(map["tilesets"][tileset]["image"])), tilesetGID]
		}
		return [null, 0]
	}
}
