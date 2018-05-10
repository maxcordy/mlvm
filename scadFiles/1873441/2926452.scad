// Rendering Quality from 25 to 75. 
rendering_quality = 50; // [25:75]
//Sphere size
 sphere_width = 30; // [27:30]
 //Sphere thickness. The larger the number the less thick the sphere 
 sphere_thickness = 22; //[22:26]

$fn = rendering_quality; 

module santa(){
 
difference () { 
union () { //makes actual ornament with little square thingy on top and adds the belt buckle and santas eyes 
    
    difference(){
    sphere (r= sphere_width);
    sphere (r = sphere_thickness); 
    }
    translate ([0,0,33]) cube ([10,10,10],center = true);
    translate([20,-10,20])sphere( r= 5, center = true );
    translate([20,10,20])sphere( r= 5, center = true );
    translate([27,-8,5]) cylinder (h = 10, r = 2, center = true ); 
    translate([27,8,5]) cylinder (h = 10, r = 2, center = true ); 
    translate([27,8,-5]) cylinder (h = 10, r = 2, center = true ); 
    translate([27,-8,-5]) cylinder (h = 10, r = 2, center = true );
    rotate ([90,0,0]) translate([27.5,-9,0]) cylinder (h = 20, r = 2, center = true );
    rotate ([90,0,0]) translate([27.5,9,0])cylinder (h = 20, r = 2, center = true );
       
    }
    translate([0,0,33])rotate([0,90,0])cylinder(h=100,r=1.7,center =true ); 
    translate([-25,0,12])rotate([0,90,0])cube([11,6,10],center = true); 
}

difference () { // makes hook hanger 
    translate ([0,0,41])sphere (r = 5, center = true);
    translate ([0,0,41])scale([1,2,1])sphere (r= 4, center = true ); //power switch 
}

rotate_extrude(angle = 360, convexity = 2){ 
    translate ([sphere_width,0,0])circle (r=4,center = true); 
}

}
//santa(); 

if (1){
rotate([0,-90,0]){
difference (){ 
        SantaWithHoles(); 
        translate([-50,0,0])cube ([100,100,100],center = true); 
    
}
}
rotate([0,90,0]){
translate ([0,70,0]){
difference () { 
     SantaWithHoles(); 
     translate([50,0,0])cube ([100,100,100],center = true); 
      
}
}
}
}
module SantaWithHoles()
difference () { 
    santa (); 
    for (aa = [0:60:360]){
        rotate([0,90, aa])cylinder( h=100, r= 2.8); 
    }
} 

    
