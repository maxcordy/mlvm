// configuration.scad
// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// effector.scad -- modified
separation = 40;  // Distance between ball joint mounting faces.
effector_radius = 30;  
top_bracket_radius = 17;  
offset = 40;  
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8.1;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
armWidth = 30;
armLength = offset - 4;
lipHeight = 4; // height of the lip for the hotend
nut_indent = 1;
bracket_rotation_degrees = 180;

module effector() {
  difference() {
    union() {
      cylinder(r=effector_radius-3, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
          rotate([0, 0, 90]) translate([offset*0.5-2, 0, 0]) {
            hull() {
                cube([armLength, armWidth, height - 1], center=true);
                cube([armLength, armWidth - 1, height], center=true);
            }
          }
            //cube([separation, 40, height], center=true);
          
	//rotate([0, 0, 30]) translate([offset-2, 0, 0])
	//  cube([10, 13, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
	    rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
	  }
        }
      }
    }
    translate([0, 0, push_fit_height-height/2])
      cylinder(r=hotend_radius, h=height, $fn=36);
    translate([0, 0, -6]) # import("m5_internal.stl");
    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}

// jojak-effector.scad


difference(){
lip();
lip_remove();
}


original();
top();


//Johanns original effector modifierad
module original() {
rotate([0,0,bracket_rotation_degrees]) {
difference()
{
rotate([0,0,bracket_rotation_degrees - 60]) translate([0,0,-height/2]) effector();		//rotate([0,0,60])  Rotade 60 degrees to allign.
hull() {
translate([0,0,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole for hotend.
translate([0,hotend_radius/2,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole #2 to fit hotend.
}
}
difference()		//Removes unused screw holes.
{
translate([0,0,height/-2])cylinder(r=effector_radius-3, h=height, center=true, $fn=60);
hull() {
translate([0,0,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole for hotend.
translate([0,hotend_radius/2,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole #2 to fit hotend.
 }
}
}
}


module top() {
rotate([0,0,bracket_rotation_degrees]) {
//Change "hotend_radius+4" to add distance to center
    difference()
    {
    cylinder(40,top_bracket_radius,0, $fn=60);
    translate([-20,-20,height]) cube ([100,100,100]);		//Cut off the top
    translate([-50,0,-2]) cube ([100,100,100]);		//split in half
    translate([0,0,-1]) cylinder(40,hotend_radius,hotend_radius);		//Center for hotend
    translate([-hotend_radius-3,-9,height/2]) rotate([0, 90, 90]) cylinder(r=m3_nut_radius, h=10 + nut_indent, center=true, $fn=6);		//M3 Screw nuts, -hotend_radius-3 give 3mm distance to inner wall
    translate([hotend_radius+3,-9,height/2]) rotate([0, 90, 90]) cylinder(r=m3_nut_radius, h=10 + nut_indent, center=true, $fn=6);		//M3 Screw nuts //M3 Screw nuts, hotend_radius+3 gives 3mm distance to inner wall
    for (a = [0:180:359]) rotate([0, 0, a]) {
          translate([hotend_radius+3, 0, 4])		//M3 Screw hole, hotend_radius+3 & 3 gives 3mm distance to inner wall & 4mm bottom
            rotate([90, 0, 0]) 
            cylinder(r=m3_wide_radius, h=50, center=true, $fn=12);
        }
    }
    }
}


module lip() {
rotate([0,0,bracket_rotation_degrees]) {
    translate([0,0,-8])cylinder(h = height + lipHeight, r1 = hotend_radius+1 , r2 = hotend_radius+1); // h = 13 gives 3mm to top. radius +1 for manifold error
    }
}


module lip_remove() {
rotate([0,0,bracket_rotation_degrees]) {
    difference() {			//Remove material to create half ring for support during print. Break off after print done
    translate([0,0,-1 * height])cylinder(height - 0.5,hotend_radius+1,hotend_radius+1);
    translate([0,0,-1 * height])cylinder(height + 0.5,hotend_radius-1.1,hotend_radius-1.1);	//-1.2 = ca 0.4mm support.
    }
    difference() {		//Diagnoal to make insertion easier
    translate([0,3,0]) rotate([-20,0,0]) cylinder(height+20,hotend_radius,hotend_radius, center=true, $fn=60);
    translate([-15,-15,-20.5])cube([30,30,20]);
    translate([-10,-24,-.5]) cube ([20,20,10]);		//remove unneeded support
    }
    
    translate([-10,0,-9]) cube ([20,20,20]);		//split in half
    translate([-10,-4,-10.5]) cube ([20,20,10]);		//remove unneeded support
    translate([0,0,-8])cylinder(16,hotend_radius-1.5,hotend_radius-1.5);		// center
    }
}


