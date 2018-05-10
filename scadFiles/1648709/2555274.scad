resolution = 100;

diameter = 25.2;
height = 11.2;

real_diameter = diameter - (2*1.3);
real_height = height - (2*1.3);

difference() {
    union() {
        minkowski() {
			hull() {
				cylinder(h=(real_height-4), d1=real_diameter, d2=real_diameter, center=false, $fn=resolution);
				translate([0,0,(real_height-4)]) cylinder(h=4, d1=real_diameter, d2=(real_diameter-0.5), center=false, $fn=resolution);
			}
            sphere(r=1.3, $fn=resolution);
        }
        translate([0,0,-2.6]) cylinder(h=2, d=27.5, center=false, $fn=resolution);
    }
    
    translate([0,0,-6]) cylinder(h=height, d=diameter-8, center=false, $fn=resolution);
}

translate([0,0,(height/2)-2.6]) cube(size = [diameter-1.2,2,height], center = true);
rotate([0,0,90]) translate([0,0,(height/2)-2.6]) cube(size = [diameter-1.2,2,height], center = true);
