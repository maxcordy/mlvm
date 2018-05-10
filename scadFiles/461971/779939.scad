

build_plate(Build_Plate_Type,Build_Plate_Manual_Width,Build_Plate_Manual_Length);

/* [Main] */
//Inner Diameter of the Hose
inner_diameter = 8;
//Height
height = 30;
// The mesh resolution
mesh_resolution=30; // [20:120]


dia = inner_diameter +0.5 ;
$fn=mesh_resolution; 

union(){

difference() {
cylinder(h = height, r=dia/2);
translate([0,0,-1])cylinder(h = height+2, r = (dia/2)-1.5);
translate([0,0,height/10+dia/6])rotate([90,0,0])cylinder(h = inner_diameter*2, r=dia/4, center = true);
%translate([0,0,height/10+dia/6])rotate([90,0,90])cylinder(h = inner_diameter*2, r=dia/4, center = true);
}

difference() {
cylinder(h = height/2, r=dia);
translate([0,0,-1])cylinder(h = (height/2)+2, r = (dia)-1.5);
}

cylinder(h = height/10, r=dia);
}