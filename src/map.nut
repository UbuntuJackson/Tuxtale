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

for(local i = 0; i < 5; i++){
    objects.push(actor[newActor(solid, i * 16, 64)])
}
for(local i = 0; i < 10; i++){
    objects.push(actor[newActor(solid, 160, 16 * i)])
}
objects.push(actor[newActor(solid, 16, 16)])
objects.push(actor[newActor(solid, 32, 16)])
