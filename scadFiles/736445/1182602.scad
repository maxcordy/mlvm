//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//This code generates a rack with round or square holes.

/* [Global] */

//round or square holes?
hole_shape=1; //[1:Round,0:Square]
//length of edge/diameter if square/round holes (mm)
hole_size=25;
//depth of hole (mm)
hole_depth=30;
//number of rows along the x axis
rows=6;
//number of columns along the y axis
columns=4;
//space between holes (mm)
spacing=1.6;
//thickness of bottom layer (mm)
bottom_thick=1.75;
//height of skids (mm)
skid_height=0.4;
//diameter of skids (mm)
skid_diameter=25;
//wall thickness (mm)
wall_thickness=5;
//material-saving through holes?
material_holes_on=1; //[1:Yes, 0:No]
//material-saving hole size (mm)
material_hole_size=4;
//rotation angle (degrees)
angle=0;

//set openSCAD resolution
$fa=1;
$fs=1;


angle2=(90-angle);
angled_pt1=cos(angle)*(hole_size*columns+spacing*(columns)+wall_thickness);
angled_pt2=sin(angle)*(hole_size*columns+spacing*(columns)+wall_thickness);
angled_pt3=cos(angle2)*(hole_depth+bottom_thick);
angled_pt4=sin(angle2)*(hole_depth+bottom_thick);

module holes(hole_shape,hole_size,hole_depth,rows,columns,spacing,bottom_thick) {
	//This module generates an array of holes with one corner at the origin
	//moves the array of holes to be alligned with a non-centered cube later
	//moves corner of array to origin, raises holes by bottom_thick
	
	translate([hole_size/2+spacing+wall_thickness/2, hole_size/2+spacing+wall_thickness/2, hole_depth/2+bottom_thick+0.5]) {

		//generating rows and columns of holes
		//columns are Y axis
		for (b=[0:columns-1]) {
			//rows are X axis
			for (i=[0:rows-1]) {
				translate([i*(hole_size+spacing), b*(hole_size+spacing), 0]) {
					//square or round holes?
					//value of 1 = circles
					if (hole_shape==1) {

						cylinder(r=hole_size/2, h=hole_depth+1, center=true);
					}
					//any value not equal to 1 generates square holes
					else {cube(size=[hole_size, hole_size, hole_depth+1], center=true);
					}
						
					
				}
			}
		}	
	}
	
}


module material_holes(hole_shape,material_hole_size,hole_depth,rows,columns,spacing,bottom_thick) {
translate([hole_size+1.5*spacing+wall_thickness/2, hole_size+1.5*spacing+wall_thickness/2, hole_depth/2+bottom_thick]){
	//generating rows and columns of holes
		//columns are Y axis
		for (b=[0:columns-2]) {
			//rows are X axis
			for (i=[0:rows-2]) {
				translate([i*(hole_size+spacing), b*(hole_size+spacing), 0]) {
					//square or round holes?
					//value of 1 = circles
					if (hole_shape==1) {
						cylinder(r=material_hole_size, h=hole_depth+bottom_thick*4, center=true);
					}
					//any value not equal to 1 generates square holes
					else {cube(size=[material_hole_size, material_hole_size, hole_depth+bottom_thick], center=true);
					}
}
}
}
}
}


//takes an appropriately sized block and removes an array of holes
	rotate([angle,0,0])
difference() {
hull(){
	//main body

	cube(size=[rows*(hole_size+spacing)+wall_thickness, columns*(hole_size+spacing)+wall_thickness, bottom_thick+hole_depth], center=false);

//round the corners to avoid splitting
if (angle==0){
	translate([0,0,0]) cylinder(h=bottom_thick+hole_depth, d=wall_thickness, $fn=100);
	translate([rows*(hole_size+spacing)+spacing+wall_thickness/2, columns*(hole_size+spacing)+spacing+wall_thickness/2,0]) cylinder(h=bottom_thick+hole_depth, d=wall_thickness, $fn=100);
	translate([0, columns*(hole_size+spacing)+spacing+wall_thickness/2,0]) cylinder(h=bottom_thick+hole_depth, d=wall_thickness, $fn=100);
	translate([rows*(hole_size+spacing)+spacing+wall_thickness/2, 0,0]) cylinder(h=bottom_thick+hole_depth, d=wall_thickness, $fn=100);
}

}
//holes (improved resolution with $fn=100)
	holes(hole_shape,hole_size,hole_depth,rows,columns,spacing,bottom_thick, $fn=100);
//material holes to save mass
if (material_holes_on==1){
	material_holes(hole_shape,material_hole_size,hole_depth,rows,columns,spacing,bottom_thick, $fn=100);
	}

}

//Generate triangular support structures if angled
if (angle!=0) {

	translate([hole_size*rows+spacing*(rows)+wall_thickness-0.5,0,0])
	rotate([0,270,0])
	linear_extrude(height=(hole_size*rows+spacing*(rows)+wall_thickness))
	polygon(points=[ 
		[0,0],
		[0,angled_pt1],
		[angled_pt2,angled_pt1]
		]
	);
	translate([-0.5,0,0])
	rotate([0,270,180])
	linear_extrude(height=(hole_size*rows+spacing*(rows)+wall_thickness))
	polygon(points=[ 
		[0,0],
		[0,angled_pt3],
		[angled_pt4,angled_pt3]
		]
	);

}

//Generate corner skids to minimise curling
//origin skid
   translate([0,-angled_pt3,0]) cylinder(h=skid_height, d=skid_diameter, $fn=100);

//opposite corner skid
	translate([rows*hole_size+spacing*rows+wall_thickness/2, (cos(angle))*(wall_thickness+(columns*(hole_size)+spacing*(columns-1))),0]) cylinder(h=skid_height, d=skid_diameter, $fn=100);

//far y axis skid
	translate([0, (cos(angle))*(columns*hole_size+spacing*(columns)+wall_thickness/2),0]) cylinder(h=skid_height, d=skid_diameter, $fn=100);

//far x axis skid
	translate([rows*hole_size+spacing*(rows)+wall_thickness/2, -angled_pt3,0]) cylinder(h=skid_height, d=skid_diameter, $fn=100);
