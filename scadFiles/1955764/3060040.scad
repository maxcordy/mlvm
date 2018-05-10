height = 2.4;
internal_diameter=25.248;
hole_diameter=15;
thickness=1.6;
printer_margin=0.8;

internal_diameter_with_margin=internal_diameter+printer_margin;
external_diameter=internal_diameter+thickness;


difference() {
translate([0,0,-1])
cylinder(height+1, external_diameter/2, external_diameter/2, center=true, $fn=80);
color("red")
cylinder(height*1.1, internal_diameter_with_margin/2, internal_diameter_with_margin/2, center=true, $fn=80);
translate([0,0,-2])
    cylinder(height+2, hole_diameter/2, hole_diameter/2, center=true, $fn=80);
}