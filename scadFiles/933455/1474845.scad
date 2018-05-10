//Measures
// Thickness
thick = 4;
// Width
t_w = 20;
// Height
t_h = 60;
// Upper arm lenght
u_arm_l = 20;
// Lower arm lenght
d_arm_l = 40;
ua_l = u_arm_l+thick;
da_l = d_arm_l+thick;
// How far do you want lower tab be from the upper tab
d_arm_sep = 20;
chamfer_size = thick/2;
// Diameter of filament
fil_dia = 1.75; // [1.75, 3]


//Positioning the parts on assembly
ua_loc = t_h-thick;
da_loc = (t_h-(thick*2))-d_arm_sep;


//Parts building
module main_plate()
    {
        translate([0,0,0]) cube([t_w,thick,t_h]);
        translate([0,0,ua_loc]) cube([t_w,ua_l,thick]);
        translate([0,0,da_loc]) cube([t_w,da_l,thick]);
    }
    
module main_hole_drilled()
    {
        difference()
            {
                main_plate();
                filament_hole();
            }
    }
    
    
//Assembly position
color([0,0,1]) assembly();

//Drilling hole for the filament
hole_loc = [t_w/2,12,t_w/2];
r_hole_loc_1 = [t_w/2,1,t_w/2];
r_hole_loc_2 = [t_w/2,thick-1,t_w/2];

module filament_hole()
    {
        translate(hole_loc) rotate([90,0,0]) cylinder(h = 20, r = fil_dia, $fn = 100);
    }

module rounded_hole_1()
    {
        hole_chamfer1 = 1.57;
        rotate_extrude(convexity = 1, $fn = 100)
        translate([fil_dia*hole_chamfer1,0,0]) circle(r = 2/2, $fn = 100);
    }
module rounded_hole_2()
    {
        hole_chamfer2 = 1.33;
        rotate_extrude(convexity = 1, $fn = 100)
        translate([fil_dia*hole_chamfer2,0,0]) circle(r = 2/2, $fn = 100);
    }

module hole_rounder()
    {
        if (fil_dia==1.75)
        {
            difference()
            {
                translate([0,0,0]) rotate([90,0,0]) cylinder(h = 20, r = fil_dia+(2/1.96), $fn = 100);
                rotate([90,0,0])rounded_hole_1();
            }
        }
            else
            {
                difference()
                {
                    translate([0,0,0]) rotate([90,0,0]) cylinder(h = 20, r = fil_dia+(2/1.94), $fn = 100);
                    rotate([90,0,0]) rounded_hole_2();
                }
            }
    }


// Rounding corners
module chamfer_template()
    {
        difference()
            {
                translate([-2,-1,0])cube([t_w+4,chamfer_size+1,chamfer_size+1]);
                translate([-4,chamfer_size,0]) rotate([0,90,0]) cylinder(h = t_w+8,r = chamfer_size, $fn = 100);
            }
    }
    
module assembly()
    {
        difference()
            {
                main_hole_drilled();
                // Upper arm chamfers
                translate([0,0,ua_loc+chamfer_size]) chamfer_template();
                translate([0,u_arm_l+chamfer_size,ua_loc+(chamfer_size*2)]) rotate([-90,0,0]) chamfer_template();
                *translate([0,u_arm_l+(chamfer_size*2),ua_loc+chamfer_size]) rotate([180,0,0]) chamfer_template();
                // Lower arm chamfers
                *translate([0,d_arm_l+chamfer_size,da_loc+(chamfer_size*2)]) rotate([-90,0,0]) chamfer_template();
                translate([0,d_arm_l+(chamfer_size*2),da_loc+chamfer_size]) rotate([180,0,0]) chamfer_template();
                // Base chamfers
                translate([0,chamfer_size,0]) rotate([90,0,0]) chamfer_template();
                translate([0,thick,chamfer_size]) rotate([180,0,0]) chamfer_template();
                // Hole rounding
                translate(r_hole_loc_1) hole_rounder();
                translate(r_hole_loc_2) rotate([180,0,0]) hole_rounder();
            }
        union()
            {
                translate([0,u_arm_l+(thick/2),ua_loc]) rotate([0,90,0]) cylinder(h = t_w, r = chamfer_size, $fn = 100);
                translate([0,d_arm_l+(thick/2),da_loc+thick]) rotate([0,90,0]) cylinder(h = t_w, r = chamfer_size, $fn = 100);
            }
    }