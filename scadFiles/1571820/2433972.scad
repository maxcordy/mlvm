import("/Users/perlisberg/Downloads/NUFC-right.stl");
//  SCAD Mesh File
//  D. Scott Nettleton
//  Feb. 2, 2013
//  This mesh is for use with the OpenSCAD

//  Width of the heel of your foot (in millimeters)
heelWidth = 62;
//  Width of your foot where your arch ends (in millimeters)
footWidth = 72;
//  Distance from the back of your heel to the start of your arch (in millimeters)
beginningOfArch = 50;
//  Distance from the back of your heel to the end of your arch (in millimeters)
endOfArch = 131;
//  Height of your arch from the ground, with no weight on your foot (in millimeters)
archHeight = 13;
//  Desired thickness of the insert
thickness = 0; // [0:Thin,0.75:Medium,1.5:Thick]
whichFoot = 0; // [0:Right,1:Left]

translate([0, -endOfArch/2.0, 0]) {
	mirror([whichFoot,0,0]) { drawMesh(); }
}