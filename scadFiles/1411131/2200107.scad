/*Filament spool holder By Jkk79
*/

// preview[view:south, tilt:top]

// Holder type... Well, you're going to get all the types as STL's, no matter what you choose here, just ignore the ones you dont need.
part="hole"; // [left:Left side with pin, right:Right side with pin,hole:Just a hole for bolt]

//Spool diameter.
spoolDiam=200; 

//Spool center hole diameter.
SpoolCenterHoleDiam=53; 

//Frame thickness, 6mm default, change this if you have something else and feel adventurous.
frameThickness=6;

//Frame upper part height, 40mm default, change this if you have something else and feel adventurous.
frameHeight=40;

//Mount's thickness, I dont know how sturdy it will be below 6mm. Reduce if extruder can't fit past them at max printing heights.
mountThickness=6;//[2,3,4,5,6]

//Holder's "hook's" length.
hookLenght=6;// [1,2,3,4,5,6,7,8,9,10]

//The angle of the arm. 66 seems to work well.
angle=66; //[40:80]

//Thickness of the holder. 10mm seems to work well.
holderThickness=10; 

//Diameter of the pin, or the hole. 8,5mm for 8mm bolt?
pinWidth=10;

/*[For pin type holder only]*/
//Height of the pin.
pin1Height=10; 

//Height of the second part of the pin that sits on top of the first pin.
pin2Height=10; 

//Width of the top of the second part of the pin, you can make it a cone shape, so the spool won't fall off even if either side fails for any reason.
pin2TopWidth=29; //29

//-----------
spoolCenterX=cos(angle)*((spoolDiam/2)+(SpoolCenterHoleDiam/2))+frameThickness; //calculates the X-coordinate.
spoolCenterY=sin(angle)*((spoolDiam/2)+(SpoolCenterHoleDiam/2))+frameHeight;    //and the Y-coordinate.

module print_part(){
    if(part=="left"){
        holder(); 
        translate([spoolCenterX,spoolCenterY,0])cylinder(holderThickness+pin1Height,pinWidth/2,pinWidth/2);
        translate([spoolCenterX,spoolCenterY,holderThickness+pin1Height])cylinder(pin2Height,pinWidth/2,pin2TopWidth/2);
        translate([0,0,-1])%spoolShape();
    } 
    else if(part=="right"){
        mirror([1,0,0])translate([0,0,0]){
            holder();
            translate([spoolCenterX,spoolCenterY,0])cylinder(holderThickness+pin1Height,pinWidth/2,pinWidth/2);
            translate([spoolCenterX,spoolCenterY,holderThickness+pin1Height])cylinder(pin2Height,pinWidth/2,pin2TopWidth/2);
            translate([0,0,-1])%spoolShape();
        }
    }
    else if(part=="hole"){    
        difference(){
            union(){
                holder();
                translate([spoolCenterX,spoolCenterY,0])cylinder(holderThickness,3+pinWidth/2,3+pinWidth/2);
            }
            translate([spoolCenterX,spoolCenterY,-1])cylinder(holderThickness+2,pinWidth/2,pinWidth/2);
        }
        translate([0,0,-1])%spoolShape();
    }
}

module spoolShape(){
    difference(){
            translate([spoolCenterX,spoolCenterY+pinWidth/2-SpoolCenterHoleDiam/2,0])cylinder(1,spoolDiam/2,spoolDiam/2);
            translate([spoolCenterX,spoolCenterY+pinWidth/2-SpoolCenterHoleDiam/2,-1])cylinder(3,SpoolCenterHoleDiam/2,SpoolCenterHoleDiam/2);
    }
}

module rounding(r,angle){ 
     rotate([0,0,angle]){
        difference(){
                translate([-r,-r,-1])cube([r+1,r+1,holderThickness+2]);
                translate([-r,-r,-1])cylinder(holderThickness+2,r,r,$fn=32);
        }
    }
}

module holder(){ 
    difference(){
        linear_extrude(height=holderThickness, convexity=10)polygon(points=[[0,0],[frameThickness,0],[frameThickness,hookLenght],[frameThickness+mountThickness,hookLenght],[frameThickness+mountThickness,-mountThickness],[-mountThickness,-mountThickness],[-mountThickness,frameHeight+mountThickness],[spoolCenterX-2,spoolCenterY+2],[spoolCenterX+2,spoolCenterY-2],[frameThickness+1,frameHeight-1],[frameThickness,frameHeight-1],[frameThickness,frameHeight],[0,frameHeight]]);
        translate([-mountThickness,-mountThickness,0])rounding(mountThickness,180);
        translate([frameThickness+mountThickness,-mountThickness,0])rounding(mountThickness,-90);
        translate([frameThickness+mountThickness,hookLenght,0])rounding(mountThickness/2,0);
        translate([frameThickness,hookLenght,0])rounding(mountThickness/2,90);
        translate([mountThickness/12,mountThickness/12,-1])cylinder(holderThickness+2,mountThickness/6,mountThickness/6,$fn=32);
        translate([frameThickness-mountThickness/12,mountThickness/12,-1])cylinder(holderThickness+2,mountThickness/6,mountThickness/6,$fn=32);
        translate([mountThickness/12,frameHeight-mountThickness/12,-1])cylinder(holderThickness+2,mountThickness/6,mountThickness/6,$fn=32);
    }
}

print_part();

