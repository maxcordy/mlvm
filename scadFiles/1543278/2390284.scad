// model variables
$fa=0.5*1; // default minimum facet angle is now 0.5
$fs=0.5*1; // default minimum facet size is now 0.5 mm
tolx=0.5*1; // tolerance for mating parts.

// global variables for 19 inch rack
// thickness of structural elements
wall=4; // [1:3]
// depth of mounting bracket along device
depth=50; // [10,20,40,50,75,100]
// width of shelf to support device
base=12; // [12,25,50,75,100]
// filament diameter for holding pins
filament_diameter=3; // [1.75,3]
// height of bracket in units (each, 44 mm)
nunits=2; // [1:3]

module ears(units){
    oneU=44.4;
    module_height=units*oneU;
    hole_spacing=31.75;
    hole_diameter=5;  // 5.2 mm = close fit for 12-24 or 10-32 screw
    
    // side
    translate([base,0,0]){
    difference(){
        translate([-wall,0,0])
        cube([wall,depth,module_height]);
        for(peg_x=[5:5:module_height])
            for(peg_y=[5:10:depth-5]){
                translate([-(wall+tolx),peg_y,peg_x])
                rotate([0,90,0])
                cylinder(r=filament_diameter/2,h=wall+2*tolx);
                translate([-(wall+tolx),peg_y+5,peg_x+2.5])
                rotate([0,90,0])
                cylinder(r=filament_diameter/2,h=wall+2*tolx);
            }                
    }
    
    // ear
    difference(){
        cube([16,wall,module_height]);
        for(ndx=[0:units-1]){
            for(jdx=[0:2])
                translate([2+1,-tolx,ndx*oneU+jdx*16+3.175])
                cube([16-3*2,wall+2*tolx,hole_diameter]);}
        }}
    // floor
    cube([base,depth,wall]);
    M = [ [ 1, 0, (base-wall)/module_height, 0 ],
          [ 0, 1, 0, 0 ],  // The "0.7" is the skew value; pushed along the y axis
          [ 0, 0, 1, 0 ],
          [ 0, 0, 0, 1 ] ] ;
     difference(){
        multmatrix(M) {
            cube(size=[base,wall,module_height],center=false); }
        translate([base,-tolx,-tolx]){
            cube([base+tolx,wall+2*tolx,module_height+2*tolx]);}
    }
}

rotate([90,0,0]){
    translate([1,0,0])
    ears(nunits);
    mirror([1,0,0])
    translate([1,0,0])
    ears(nunits);
}
