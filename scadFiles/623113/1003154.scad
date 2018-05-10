/*
PetCageCleaner
Copyright (C) 2014  Benjamin Hirmer - hardy at virtoreal.net

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//Softening the Edges of your Tool
edgeround = 10; // [0:15]
//Adjust the Width of your Tool (6 would be strong enough)
toolwidth = 6; 
//Type in the Lenght of your Tool, the Longer the Easy to Clean!
toollenght = 120; 
//Resize the Handle
handlysize = 30; 
//Rezize the Hole in the Handle
handlyhole = 5; 
//Whats the Distance between the Rods of your Cage? (center to center of rod)
latticerodsdistance = 12.5; 
//Define the Size of the Gaps, remember: the Rod and your Cloth have to fit in
gapsize = 3.1;
//Define the Depth of the Gaps (dont make them to deep, your cloth will tear apart)
gapdepth = 5; 
//The End of the Gap depends on your Tool-Lenght/Gap-Size, rearrange for a nicer Look
rearrangegap = 5; 
//Resolution of your Tool (70 would be fine enough)
$fn = 70;

difference () {

  union () {
    minkowski() {
      cube([toollenght-edgeround*2,handlysize,toolwidth-1]);
      cylinder(r=edgeround,h=1);
    }
    translate ([-edgeround,-edgeround-gapdepth,0]) cube (size = [toollenght,edgeround+gapdepth,toolwidth]);
  }
  union () {
    translate ([-edgeround+toollenght/5,handlysize/2-handlyhole/2,-1]) {
      minkowski() {
	cube([toollenght/5*3,edgeround/4+handlyhole,toolwidth+1]);
	cylinder(r=edgeround,h=1);
      }
    }
      translate ([-edgeround+gapsize+rearrangegap,-edgeround-gapdepth,-1]) {
	for ( i = [0 : latticerodsdistance : toollenght] )
	{
	    translate([i, -1, 0])
	    cube (size = [gapsize,gapdepth,toolwidth+2]);
	}
      }
  
  
  }
}
