$fn=100;
target_size=80;
target_thickness=5;
bottom_length=100;
difference()
{
union()
{
cylinder(h=target_thickness,r=target_size/2);
translate([target_size/2.5,-15,0])cube([bottom_length,30,target_thickness]);
}
}
