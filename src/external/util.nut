// SuperTux Advance
// Copyright (C) 2022 KelvinShadewing

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

//These functions may end up being added to the runtime core file.
//They will be marked as such if this happens.

::mergeTable <- function(a, b) {
	if(typeof a == null && typeof b == null) return null
	if(typeof a == null) return b
	if(typeof b == null) return a

	//Create new table
	local nt = clone(a)

	//Merge B table slots into A table
	foreach(slot, i in b) {
		if(!nt.rawin(slot)) nt[slot] <- i
		else if(typeof nt[slot] == "table" && typeof b[slot] == "table") nt[slot] = mergeTable(nt[slot], b[slot])
		else nt[slot] <- i
	}

	return nt
}

::minNum <- function(a, b) {
	return (a * (a < b)) + (b * (b <= a))
}

::maxNum <- function(a, b) {
	return (a * (a > b)) + (b * (b >= a))
}