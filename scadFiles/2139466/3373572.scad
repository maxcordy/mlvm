//! Multicolor key snake.
//! Remixed from  Key snake by Arco van Geest <arco@appeltaart.mine.nu>
//! with some modifications for better rendering, better performances
//! and the possibility to export each part as a separate object.
//! To get a multicolored object, export each object separatelly using 
//! the draw_part variable and combine them in Repetier for example.
//! The partnumber variable allows you to display each part of the body
//! individually when [Body] is selected in the [Draw part] variable.
//! @copyright 2017 P. Morel for Thilab
//! @license  Creative Commons - Attribution - Non-Commercial https://creativecommons.org/licenses/by-nc/3.0/

//! @date 20170227 First remixed version with separate eyes, tongue, head,
//! body parts and tail
//

/*[Body parts]*/
// Number of body parts
parts=3;
//Part to draw
draw_part="All"; //[All,Eyes,Tongue,Head,Body,Tail]
//Main body part to draw (when Body is selected above)
partnumber=3;


/* [Hidden] */
//$fa=12;
//$fs=1;
$fn=18;

diameter=10;
spacing=0.2;
extra=0;
flat=diameter/20; //(5% flattened)



length=diameter+extra;
dspacing=spacing*2;
ring=((diameter-dspacing)/3)/2;
dd=((diameter)/2)-ring;

echo("Diameter = ",diameter,"mm");
echo("partlength = ",length,"mm");
echo("ring radius = ",ring,"mm");
echo("torus radius = ",dd,"mm");
echo("flatten = ",flat,"mm");

// assembly of the snake
difference(){ 
    union() {
        //place head
        if( draw_part=="Head" || draw_part=="Eyes" || draw_part=="Tongue" || draw_part=="All" ) {
            translate([0,0,(diameter/2)-flat]) head();
        }
        //body parts
        if( draw_part=="All" ) {
            translate([0,0,(diameter/2)-flat]) 
                for(partcount = [0 : parts-1]) {
                    translate([length*partcount,0,0]) rod();
                }
        }
        // Individual body part 
        if( draw_part=="Body") {
            translate([length*(min(parts,partnumber)-1),0,(diameter/2)-flat])
                rod();
        }

        //place tail
        if( draw_part=="Tail" || draw_part=="All" ) {
            translate([length*(parts),0,(diameter/2)-flat]) tail();        
        }    
    }
    //flatten bottom
    translate([-50,-50,-20])cube([1000,1000,20]);
}


module ring(dia=1,d=2) {
rotate_extrude(convexity = 10)
translate([d, 0, 0])
circle(r = dia,center=true);
}

module gaph(){
    translate([-dd,0,0]) {
        hull() {
            rotate([0,-45,0])
                translate([-dd,0,0])  
                    ring(d=dd,dia=ring+spacing); 
            translate([-dd,0,0])  
                ring(d=dd,dia=ring+spacing); 
            rotate([0,45,0]) 
                translate([-dd,0,0])
                    ring(d=dd,dia=ring+spacing); 

        }
    }
}
     
module gapv() {
 rotate([90,180,0]) 
    gaph();
    }

module endv() {
translate([-dd,0,0]) rotate([90,180,0]) endh();
}

module endh() {

    union() {
       // Ring to attach to the body
        translate([ring*2+spacing/2,0,0])
            rotate([90,0,0])   
                ring(d=dd,dia=ring);

        difference() {
                // Main part
                rotate([0,90,0])
                    minkowski() {
                        cylinder(d=diameter-4,h=(length-4),center=true  );
                        sphere(r=2.3);
                    }
            // Make room for rotation
            translate([length+dd,0,0]) 
                rotate([0,180,0])
                    gapv();
            // Remove rounded face
            translate([-(2.3)/2-length/2+2,0,0]) 
                cube([2.3,diameter+1,diameter+1],center=true);

        }
    }    
} //endh

module rod() {
    //body part
    union() {
        //ring h
        translate([ring*2+spacing/2,0,0]) 
            rotate([0,0,0])   
                ring(d=dd,dia=ring);
        //ring v
        translate([-ring*2-spacing/2,0,0]) 
            rotate([90,0,0])   
                ring(d=dd,dia=ring);


        difference() {
            // Main body part
            translate([0,0,0])
                rotate([0,90,0])
                    minkowski() {
                        cylinder(d=diameter-4,h=(length-4),center=true  );
                        sphere(r=2.3);
                    }
            // Make room for rotation
            translate([length+dd,0,0]) 
                rotate([90,180,0])
                    gapv();
            // Make room for rotation
            translate([-length-dd,0,0]) 
                rotate([90,180,0])
                    gaph();
        }
    }
} //rod


module head() {
    if( draw_part=="Head" || draw_part=="All") {
        difference() {
            union() {
                //connection
                    translate([-length-dd,0,0])
                    rotate([0,0,180])
                        endv();
                //head main
                    translate([-dd,0,0])
                    union() {
                        translate([-(1.7*diameter),0,0]) scale([2.5,1.5,1.5]) 
                            sphere(d=diameter);
                    //lip
                        translate([-(1.9*diameter)-diameter*.25,0,-(diameter*.5)+flat]) scale([1.5,1,.4]) 
                            sphere(d=diameter);
                    }
            }
            // Make room for the tongue
            translate([-diameter*2.5,0,-diameter*0.3]) 
                rotate([0,90,0]) 
                    rotate([0,0,45]) 
                        cube([diameter/3+dspacing,diameter/3+dspacing,diameter*3],center=true);
            // Make room for the tongue cube
            translate([-diameter*1.5,0,0]) 
                rotate([0,90,0])  
                    cube([diameter/2+dspacing,diameter/3+dspacing,diameter],center=true);
        
       } //difference
   }
    //eyes
    if( draw_part=="Eyes" || draw_part=="All") {
        translate([-dd,0,0]) {
            translate([-(2.2*diameter),-diameter*.4,diameter*.5]) 
                sphere(d=diameter/2);
            translate([-(2.2*diameter),diameter*.4,diameter*.5]) 
                sphere(d=diameter/2);
        }
    }
    //tongue
    if( draw_part=="Tongue" || draw_part=="All") {
        translate([-dd,0,0])
        difference() {
            translate([-diameter*2-dspacing,0,-diameter*0.3]) 
                rotate([0,90,0]) rotate([0,0,45]) 
                    cube([diameter/3,diameter/3,diameter*2],center=true);
            translate([-diameter*3.3,0,diameter*.2]) 
                rotate([0,45,0]) 
                    rotate([0,0,45]) 
                        cube([diameter,diameter,diameter],center=true);
            translate([-diameter*2.6,0,diameter*.3]) 
                rotate([0,75,0]) 
                    rotate([0,0,0]) 
                        cube([diameter,diameter,diameter],center=true);
        }
        translate([-diameter*1.3-dspacing,0,0]) 
            rotate([0,90,0])  
                cube([diameter/2-dspacing,diameter/3,diameter/2],center=true);
    }
    
    
}

module tail() {
    //joint
    rotate([0,0,180])
    union() {
        translate([ring*2+spacing/2,0,0])
            rotate([90,0,0])   
                ring(d=dd,dia=ring);
        //Main part of the tail
        difference() {
            hull() {
                // Cylindrical part
                rotate([0,90,0])
                    minkowski() {
                        cylinder(d=diameter-4,h=(length-4),center=true  );
                        sphere(r=2.3);
                    }
                    // Sphere to create the end of the tail
                    translate([-diameter*2,0,-3])
                        sphere(r=1.5,center=true);
                }
            // Make room for the rotation
            translate([length+dd,0,0]) 
                rotate([0,180,0])
                    gapv();
        }
    } 

    //key ring
    translate([diameter*2.1+dspacing*2,0,-diameter*.3]) 
        rotate([0,0,0])   
            ring(d=dd,dia=ring);
} //tail




