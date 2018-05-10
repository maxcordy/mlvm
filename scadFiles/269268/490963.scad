grid=1.27;
unit_height=3;
hole_size=3.1;

number_of_units=1;

//  - segment
module horizontal_segment()
 {
union()
{
translate([2*grid,0])
circle(h=unit_height+2,r=hole_size/2,$fn=16);
translate([5*grid,0])
circle(h=unit_height+2,r=hole_size/2,$fn=16);
translate([8*grid,0])
circle(h=unit_height+2,r=hole_size/2,$fn=16);
}
}

// | Segment
module vertical_segment()
{
union()
{
translate([0,2*grid])
circle(h=unit_height+2,r=hole_size/2,$fn=16);
translate([0,5*grid])
circle(h=unit_height+2,r=hole_size/2,$fn=16);
translate([0,8*grid])
circle(h=unit_height+2,r=hole_size/2,$fn=16);
}
}

module display_unit()
{
difference()
{
translate([-2*grid,-2*grid,0])
square ([14*grid,24*grid]);

translate([0,0,0])
horizontal_segment();
translate([0,10*grid,0])
horizontal_segment();
translate([0,20*grid,0])
horizontal_segment();

translate([0,0,0])
vertical_segment();
translate([0,10*grid,0])
vertical_segment();
translate([10*grid,0,0])
vertical_segment();
translate([10*grid,10*grid,0])
vertical_segment();
}
}

for (i=[1:14:number_of_units*14])
{
translate([i*grid,0,0])
display_unit();
}

