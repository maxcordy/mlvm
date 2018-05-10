use <rail.scad>;


$fn = 200;

wheel_diameter = 20;
wheel_diameter_inner = wheel_diameter - 6;

wheel_width = 5;
wheel_width_inner = wheel_width - 2.5;

length = 65;
width  = 20;
height = 15;

rod_diameter = 5;
hole_diameter = 5.5;

module wheel(cover = false) {

    difference() {
        union() {
//            translate([0,0,-1])
//            cylinder(h = 1, d = 6);
            cylinder(h = wheel_width_inner, d = wheel_diameter);
            cylinder(h = wheel_width      , d = wheel_diameter_inner);
            
            if(cover == true) {
            intersection() {
                translate([0,0,-wheel_diameter_inner+7])
                sphere(d =wheel_diameter_inner * 2);
                cylinder(h = wheel_width +2     , d = wheel_diameter_inner);
            
                }
            }
        }
        translate([0,0,-5])
        if(cover == true) {
            cylinder(d = hole_diameter, h = 10);
        }
        else {
            cylinder(d = hole_diameter, h = 11);
        }
    }
}

module body(center = true) {

    difference() {
    union() {
        translate([0,0,16])
        polyhedron(
            points = [
                [0,-4,0],
                [length-2, -4,0],
                [length-2, width+4, 0],
                [0, width+4, 0],
        
                [10,5,height],
                [length-10, 5,height],
                [length-10, width-5, height],
                [10, width-5, height]

            ],
            faces = [
                [0,1,3],
                [1,2,3],
                [0,3,4],
                [4,3,7],
                [1,0,5],
                [0,4,5],
                [2,1,5],
                [2,5,6],
                [3,2,7],
                [2,6,7],
                [5,4,6],
                [6,4,7]
            ]
        );

        cube([length, width, 16]);

        translate([0,-4,15])
        difference() {
            cube([width * 1.2, width *1.4, 24]);
            translate([-1,3,3])
            cube([width * 1.2+2, width *1.4-6, 24]);
        }
        
        translate([0,-4,15])
        cube([length, width *1.4, 1.5]);


        translate([width, width/2, 22])
        rotate([0,90,0])
        cylinder(d = width*1.2, h = length-3-width);

        translate([length - 15, width /2, 22])
        cylinder(d = 12, h = 20);

        translate([length - 30, width /2, 22])
        cylinder(d = 4, h = 15);

        translate([length - 15, width /2, 36])
        cylinder(d1 = 12, d2 = 16, h = 6);
        
        

        difference() {
            translate([0,width/2, 28])
            scale([1,1.4,1])
            rotate([90,0,90])
            cylinder(h =  width * 1.2, d = width * 1.5);

            translate([-1,-width,15])
            cube([width * 1.2+2, width *4, 22]);

        }
    }
    
    translate([10,-5,3.2])
    rotate([-90,0,0])
    {
        cylinder(h = width + 10, d = hole_diameter);
        translate([0,-1,0])
        cylinder(h = width + 10, d = hole_diameter);
        translate([-hole_diameter/2,-1,0])
        cube([hole_diameter, 1, width + 10]);
    }

    if(center) {
    translate([length/2,-5,3.2])
    rotate([-90,0,0])
    {
        cylinder(h = width + 10, d = hole_diameter);
        translate([0,-1,0])
        cylinder(h = width + 10, d = hole_diameter);
        translate([-hole_diameter/2,-1,0])
        cube([hole_diameter, 1, width + 10]);
    }
}

    translate([length-10,-5,3.2])
    rotate([-90,0,0])
    {
        cylinder(h = width + 10, d = hole_diameter);
        translate([0,-1,0])
        cylinder(h = width + 10, d = hole_diameter);
        translate([-hole_diameter/2,-1,0])
        cube([hole_diameter, 1, width + 10]);
    }
    
            translate([0,-1,18])
            cube([width * 1.2-3, width *1.4-6, 19]);

}
}

module wheels() {
    translate([10,-1,4])
    rotate([90,0,0])
    wheel();

    translate([length-10,-1,4])
    rotate([90,0,0])
    wheel();

    translate([length-10,width+1,4])
    rotate([-90,0,0])
    wheel();
    
    translate([10,width+1,4])
    rotate([-90,0,0])
    wheel();
    
    translate([length/2,width+1,4])
    rotate([-90,0,0])
    wheel();
    
    translate([length/2,-1,4])
    rotate([90,0,0])
    wheel();
}


module train() {

    color("brown")
    body();
    color("silver")
    wheels();


    color("silver")
    translate([1.5,10,7.5])
    rotate([0,-90,0])
    magnet_holder(true);
    
    color("silver")
    translate([length-1.5,10,7.5])
    rotate([0,90,0])
    magnet_holder(true);
}

// translate([-length/2, - width /2 , 8])
// train();

// rail(120);


module assembled_wheel() {
    color("silver")
    {
        rotate([180,0,0])
        wheel();
        
        cylinder(h = width, d = 4);
        
        translate([0,0,width])
        wheel();
    }
}

module rod() {

    cylinder(d = rod_diameter, h = 24);

}


// assembled_wheel();
// wheel();

// body();
// rod();

module magnet_holder(display = false) {
    
    difference() {
        cylinder(d = 14.8, h = 3.8);
        translate([0,0,.8])
        cylinder(d = 13, h = 7);
    }

    tran = display ? [0,0,6]: [16,0,0];
    translate(tran)
    intersection() {
        translate([0,0,-12.5])
    sphere(d = 14.8 * 2);
    cylinder(d = 14.8, h = 9);
    }
    
}

module print() {

    if(false)
    { 
    difference() {
        body();
        translate([-1,-10,14.9])
        cube([length+2,40,32]);
        translate([4,4,8.5])
        cube([length-8, width-8,10]); 
        
        translate([-.5,10,7.5])
        rotate([0,90,0])
        cylinder(d = 14.8, h = 2);
        translate([length-1.5,10,7.5])
        rotate([0,90,0])
        cylinder(d = 14.8, h = 2);
    }

            translate([length/4-.2,0.2,14.8])
            cube([3.6,3.6,3.5]);
            translate([length/4*3+.2,0.2,14.8])
            cube([3.6,3.6,3.5]);
            translate([length/4-.2,16.2,14.8])
            cube([3.6,3.6,3.5]);
            translate([length/4*3+.2,16.2,14.8])
            cube([3.6,3.6,3.5]);
    }

        //translate([0,-30,15])
    if(false)
    difference() {
        translate([0,30,-15])
        body();
        translate([-1,20,-32])
        cube([length+2,40,32]);
        translate([-1,20,21.9])
        cube([length/2,40,32]);

            translate([0,30,-15])
            {
            translate([length/4,0,14.8])
            cube([4,4,4]);
            translate([length/4*3,0,14.8])
            cube([4,4,4]);
            translate([length/4,16,14.8])
            cube([4,4,4]);
            translate([length/4*3,16,14.8])
            cube([4,4,4]);
            }
    }
    
    if(false) {
        if(true) {
    translate([0,0,-22])
    intersection() {
        translate([0,65,-15])
        body();
        translate([-1,55,22])
        cube([length/2,40,32]);
    }
    }
//    translate([5, width+10, 0])
//    rod();
//    translate([15, width+10, 0])
//    rod();

    if(false)
    for(i = [0:2]) {
        translate([10+i*22,-15,0])
        rotate([0,0,0])
        wheel();
        
        translate([10+i*22,-40,0])
        rotate([0,0,0])
        wheel();

    }
    }

    if(true)
    translate([10,-75,0]) {
    magnet_holder();
    translate([0,16,0])
    magnet_holder();
    }
    
    if(false) {
        translate([4,-85,0])
        cube([2,180,.4]);
        
        translate([27,-85,0])
        cube([2,180,.4]);

        translate([46,-85,0])
        cube([2,180,.4]);
    }

}

//print();
train();

if(false) {
    translate([10,-75,0]) {
    magnet_holder();
    translate([0,16,0])
    magnet_holder();
    }
}