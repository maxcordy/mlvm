//number of lines
quantx=2; //[1:100]
//number of columns
quanty=3; //[1:100]
module lego(){
    difference(){
        cube([7.8*quantx,7.8*quanty,9.6]);
        translate([1.45,1.45,0])
            cube([7.8*quantx-2.9,7.8*quanty-2.9,8.4]);
    }
    for(countx=[1:1:quantx]){
        for(county=[1:1:quanty]){
            translate([countx*7.8,county*7.8,0])
                pino();
            if ( (countx >1) && (county >1) ){
            translate([-7.8+countx*7.8,-7.8+county*7.8,0])
                pinoinf();
               
            } 
        }
    
    }    
    }
module pino(){
    translate([-3.9,-3.9,9.6])
        cylinder(1.5,2.4,2.4,$fn=20);
    translate([-3.9,-3.9,11.1])
        cylinder(.3,2.4,1.8,$fn=20);
}
module pinoinf(){
    difference(){
        union(){
            translate([0,0,.3])
                cylinder(9,3.25,3.25,$fn=20);
            cylinder(.3,2.25,3.25,$fn=20);
        }
        cylinder(9.3,2.25,2.25,$fn=20);
    }
}
lego();
//pino();