$fn=20;

length2 = 66;
width2= 82;
height2 = 25;
radius = 2;
rand   = 2;
rand6  = 3;
rand2  = 200;
rand3  = 0;
rand5  = 0;
rand4  = 6;

length = length2 + 2*rand;
width= width2 +2*rand6;
height = height2 + 2*rand;


difference(){
translate([0, 0, 0]){ 
   roundedBox(length, width, height, radius);
}
union(){
translate([rand6, rand, rand]){ 
    roundedBox(length - 2*rand, width - 2*rand6, height- 2*rand, radius);
}

translate([rand2, rand2, 2*rand-height ]){ 
    roundedBox(length - 2*rand2, width - 2*rand2, height, 0);
}
//translate([rand4, rand4, height-2*rand]){ 
translate([rand4, 0, height-2*rand]){ 
    roundedBox(length - 0*rand4, width - 2*rand4, height, 0);
}


translate([rand5, -length+rand*2, rand5 ]){ 
    roundedBox(length, width - 2*rand5, height- 2*rand5, 0);
}

translate([rand3,length-rand*2, rand3 ]){ 
    roundedBox(length , width - 2*rand3, height- 2*rand3, 0);
}

}
}

module roundedBox(length, width, height, radius)
{
    dRadius = 2*radius;
    //base rounded shape
translate([radius, radius, radius]){ 
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height-dRadius]);
        sphere(r=radius);
    } 
}
}
