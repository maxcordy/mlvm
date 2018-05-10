// pepper spray can holder
// always prepared at entry door
// 20151113 WA


// grip height
$h=50;
// top overlap 
$ol=10;
// can diameter
$d=35;
// wall thicknes
$ws=2.8;
// bottom stop depth
$bsd=20;
//  
$fn=200;



difference(){

    
    cylinder(r=$d/2+$ws/2,h=$h);
    
    translate([0,0,-0.2])
    cylinder(r=$d/2,h=$h+0.4);
    
    translate([$d/4,-$d/2,-0.2])
    #cube([$d-$d/2,$d,$h+0.4]);
    
    
}

translate([-$d/2-$ws,-$d,0])
cube([$ws,$d*2,$h+$ol]);

translate([-$d/2-$ws,-$d/2,0])
cube([$bsd,$d,$ws]);
