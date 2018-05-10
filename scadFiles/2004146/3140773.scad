
/* [Adapter Type] */
type=2; // [1:pin+hole,2:hole+hole]
/* [Adapter shape] */
//exterior of the adapter
form=2; // [1:cylinder,2:hexagon]
/* [Bit size] */
// size of the bit in mm
size=4;
// Depth of the hole for the bit in mm
depth=10;
/* [Joint parameters] */
//thickness of wall
wall=2; // [1:1mm,2:2mm,3:3mm,4:4mm,5:5mm, 6:6mm]
// distance (in mm.) between two bit's holes inside the adapter. Use it to get long adapter. Full adapter height=depth*2+distance
distance=20;
/* [Adjustments] */
// Delta setting may be used to compensate material shrinkage or printer's calibration issues. Pin will be decreased, holes will be increased for this value. Try  the default, correct if too tight/free.
//setting for bottom part
delta_bottom=0.8;
//setting for top part
delta_top=0.8;

if (distance<2) {
    distance=2;
    };

radius=(wall+size)/2;
    
if (type==2){
difference(){
difference(){
if (form==1){
cylinder(depth*2+distance,r=radius+delta_bottom,center=false);
}else{
    Hexagone(radius*2+delta_bottom,depth*2+distance);
};
Hexagone(size+delta_bottom,depth);
    };
translate([0,0,depth+distance]) {Hexagone(size+delta_top,depth);
    };
};
} else {
difference(){
if (form==1) {
    cylinder(depth+distance,r=radius+delta_bottom,center=false);
} else {
    Hexagone(radius*2+delta_bottom,depth+distance);
};
Hexagone(size+delta_bottom,depth);
};
translate([0,0,depth+distance]) {Hexagone(size-delta_top,depth);
    };
};
function cot(x)=1/tan(x);
module Hexagone(size,height)
{
	angle = 60;		
	width = size * cot(angle);

    translate([0,0,height/2]){

	union()
	{
		rotate([0,0,0])
			cube([size,width,height],center=true);
		rotate([0,0,angle])
			cube([size,width,height],center=true);
		rotate([0,0,2*angle])
			cube([size,width,height],center=true);
	}
};
}
