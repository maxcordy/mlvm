// Trumpet Mute
// (c) Wouter Robers

Length=140;
WallThickness=1;

difference(){
cylinder(r1=(25+Length*0.3)/2,r2=25/2,h=Length);
translate([0,0,WallThickness]) cylinder(r1=(25+Length*0.3)/2-WallThickness,r2=25/2-WallThickness,h=Length);
}

for (i=[0:120:359]){
rotate([0,0,i]) translate([19,-5,Length-50]) rotate([0,-8.5,0]) cube([3,10,40]);
}