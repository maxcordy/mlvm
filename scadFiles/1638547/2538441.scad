top_diameter = 20;
bottom_diameter = 110;
height = 160;
brim_diameter = 200;
resolution = 60;


top_radius = top_diameter/2;
bottom_radius = bottom_diameter/2;
brim_radius = brim_diameter/2;

difference() {
    union() {
        hull() {
            sphere(r = bottom_radius, center=true, $fn = resolution);
            translate([0,0,height-top_radius]) sphere(r = top_radius, center=true, $fn = resolution);
        }
        cylinder(h=2, r1=brim_radius, r2=brim_radius, center=true, $fn = resolution);
    }
    
    translate([0,0,-bottom_diameter]) cylinder(h=bottom_diameter, r1=brim_diameter*2, r2=brim_diameter*2, center=false);
    hull() {
        sphere(r = bottom_radius-2, center=true, $fn = resolution);
        translate([0,0,height-top_radius]) sphere(r = top_radius-2, center=true, $fn = resolution);
    }
    
}