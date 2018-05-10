$fn=30;
width=30;
depth=35;
height=30;
diameter=8;
//
//jambe
//
translate([width/3,depth/3.04,-height/1.7])cube([width/6,depth/5.83,height/10]);
translate([-width/2,depth/3.04,-height/1.7])cube([width/6,depth/5.83,height/10]);
translate([width/3,-depth/2,-height/1.7])cube([width/6,depth/5.83,height/10]);
translate([-width/2,-depth/2,-height/1.7])cube([width/6,depth/5.83,height/10]);
//
//nez
//
translate([0,depth/1.92,height/6-6])cube([width/3.75,depth/23.33,height/3.75],center=true);
//
//narine
//
translate([width/18,depth/1.81,height/6-6])cube([width/30,depth/50,height/10],center=true);
translate([-width/18,depth/1.81,height/6-6])cube([width/30,depth/50,height/10],center=true);
//
//yeux
//
translate([width/4,depth/2.1,height/4])rotate([270,0,0])cylinder(h=diameter/4,r=diameter/5.33);
translate([-width/4,depth/2.1,height/4])rotate([270,0,0])cylinder(h=diameter/4,r=diameter/5.33);
//
//oreille
//
translate([width/1.63,depth/2.5,height/2.7])cube([width/21,depth/9.9,height/12]);
intersection()
{
difference()
{
translate([width/1.8,depth/2.5,height/2.3])rotate([270,0,0])cylinder(h=diameter/2.3,r=diameter/2.5);
translate([width/1.8,depth/2.5,height/2.3])rotate([270,0,0])cylinder(h=diameter/2.3,r=diameter/4.3);
}
translate([width/2.5,depth/2.7,height/2.3])cube([width/3,depth/7,height/2.5]);
}
//
//oreille 2
//
translate([-width/1.51,depth/2.5,height/2.7])cube([width/21,depth/9.9,height/12]);
intersection()
{
difference()
{
translate([-width/1.8,depth/2.5,height/2.3])rotate([270,0,0])cylinder(h=diameter/2.3,r=diameter/2.5);
translate([-width/1.8,depth/2.5,height/2.3])rotate([270,0,0])cylinder(h=diameter/2.3,r=diameter/4.3);
}
translate([-width/1.4,depth/2.7,height/2.3])cube([width/3,depth/7,height/2.5]);
}
//
//trous pour argent
//
difference()
{
cube([width,depth,height],center=true);
union() {
translate([0,0,height/1.5])cube([width/6,depth/1.25,height],center=true);
cube([width/1.1,depth/1.4,height/1.1],center=true);
}
translate([0,-depth/8-2,-height/2.3])cube([width/1.2,depth/0.744,height/15],center=true);
translate([0,0,-height/2])cube([width/2,depth/1.522,height/1.25],center=true);
}