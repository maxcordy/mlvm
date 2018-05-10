$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

tolx=0.5; // tolerance for mating parts.

radius_can=3.125*12.7; // radius of can in mm
feeder_wall=18;
wall=3;

module can_base(internal_radius,height,wall){
    difference(){
        cylinder(r1=internal_radius+4*wall,r2=internal_radius+wall,h=height*2+wall*3);
        translate([0,0,wall]){
            cylinder(r=internal_radius+tolx,h=height*2+2*wall+tolx);}
        translate([internal_radius,0,height]){
            sphere(r=height-2*wall);}
        }
}

module chute(width,angle,internal_radius,wall){
    can_base(radius_can,feeder_wall+wall,wall);
    feed_cup(feeder_wall,wall);
    translate([-internal_radius+1,-width/2-wall*1.3,0]){
        cube([internal_radius*1.95,wall,feeder_wall]);
    }
        translate([-internal_radius+1,width/2+wall*.3,0]){
        cube([internal_radius*1.95,wall,feeder_wall]);
    }
    translate([0,0,wall]){
        difference(){
        cylinder(r=width/2+wall,h=0.75*25.4+wall);
        union(){
            cylinder(r=(width+tolx)/2,h=0.75*25.4+wall+tolx);
            translate([0,0,wall]){
                rotate([90,0,90]){
                cylinder(r=wall,h=25);}}}}}
}

module feed_cup(height,wall){
    translate([radius_can,0,height]){
        difference(){
            union(){
                sphere(r=height);
                translate([0,0,-height]){
                    cylinder(r2=height-wall,r1=height+wall,h=height);}}
            union(){
                sphere(r=height-wall);}
                translate([-radius_can,0,0]){
                    cylinder(r=radius_can+tolx,h=height);}
                translate([-radius_can,-height/2,0]){
                    cube([2*radius_can-wall+tolx,height,height]);}
                translate([-radius_can,0,-height+tolx]){
                    cylinder(r=radius_can+tolx,h=height);}
            }
        }
   }





translate([radius_can+wall,radius_can+wall,0]){

    chute(28.25,15,radius_can,wall);
}