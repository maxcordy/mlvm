/* [Global] */

// Which one would you like to see?
part = "both"; // [Extruder Holder,Frame Holder,both]

// Pivot point diameter
Pivot_Dia = 4.8;



/* [Frame Holder] */

// I3 Frame thickness (of acrylic)
Frame_Thickness = 8.5;

// I3 Frame mounting hole distance
Frame_Mounting_Dist = 100;

// I3 Frame mounting hole diameter
Frame_Mounting_Dia = 3.6;



/* [Extruder Holder] */

// Extruder mounting hole diameter
Extr_Mounting_Dia = 3.6;

// Extruder mounting hole distance
Extr_Mounting_Dist = 40;

print_part();

module print_part() {
	if (part == "Extruder Holder") {
		extr_holder();
	} else if (part == "Frame Holder") {
		frame_holder();
	} else {
		color("Green") translate([-6, Frame_Thickness/2+2+6, 3]) extr_holder();
        frame_holder();
	}
};

module extr_holder()
{
    difference()
    {
        union()
        {
            cube([20,12,4], center=true);
            
            translate([0,12+6,3.5-2])
                cube([20,24,7], center=true);
            
            translate([0,-2-6,(Extr_Mounting_Dist * 1.2 + 7)/2 - 2])
                cube([20,4,Extr_Mounting_Dist* 1.2 + 7], center=true);
            translate([(20-3)/2,0,+2+1.5])
                cube([3,12,3], center=true);
            translate([-(20-3)/2,0,+2+1.5])
                cube([3,12,3], center=true);
        };
        
        union()
        {
            cylinder(d=Pivot_Dia, h=7,center=true);
            translate([0,-2-6,7]) union()
            {
                rotate([90,0,0])
                    cylinder(d=Extr_Mounting_Dia, h=5, center=true);
                
                translate([0,0,Extr_Mounting_Dist])
                    rotate([90,0,0])
                        cylinder(d=Extr_Mounting_Dia, h=5, center=true);
                
                translate([0,0,14]) rotate([90,0,0])
                    cylinder(d=13.5, h=5, center=true);
            };
        };
    };
};

module frame_holder()
{
    difference()
    {
        union()
        {
        translate([0,Frame_Thickness / 2 + 1,-6-3]) cube([Frame_Mounting_Dist * 1.1,2,12], center=true);

         translate([0,-Frame_Thickness / 2 - 1,-6-3])cube([Frame_Mounting_Dist * 1.1,2,12], center=true);

        translate([0,0,-1.5])
            cube([Frame_Mounting_Dist * 1.1,Frame_Thickness+4,3], center=true);
            
            translate([-6,Frame_Thickness/2+2+6,-6])
                cube(12, center=true);
        };
        
        union()
        {
            translate([Frame_Mounting_Dist/2,0,-7.5-3]) rotate([90,0,0])
            cylinder(d=Frame_Mounting_Dia, h=Frame_Thickness + 7, center=true);

        translate([-Frame_Mounting_Dist/2,0,-7.5-3]) rotate([90,0,0])
            cylinder(d=Frame_Mounting_Dia, h=Frame_Thickness + 7, center=true);
        };
        
        translate([-6,Frame_Thickness/2+2+6,-6])
        cylinder(d=Pivot_Dia, h=13,center=true);
    };
};