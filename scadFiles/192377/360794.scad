//////////////////////////////////////////////////////////////////////////////////////
///
///  Tiltable frame for G4-type SMD LED lamps
///
///  This is a little tiltable and rotatable frame to mount the easily available
///  and inexpensive round G4 type 12V SMD LED lamps.
///
///  The frame consists of two printed part, the LED holder and the base.  These
///  two parts are joined by a conical hinge, so that the angle of the lamp can
///  be adjusted as needed.  The conical hinge holds by friction, but screw holes
///  are also provided in case a firmer grip is needed. The frame has a central
///  screw hole so that it can be attached to any flat surface.  If a washer is
///  used and the screw is not tightened too strongly, the lamp can also be 
///  rotated around the screw, providing full angular coverage.  A hole in one corner
///  of the frame can be used for feeding the cables through.
///  
///  The led carrier is simply pushed into the led holder - it should snap in with
///  a click.
///
//////////////////////////////////////////////////////////////////////////////////////
///
///  2013-11-27 Heinz Spiess, Switzerland
///
///  released under Creative Commons - Attribution - Share Alike licence
//////////////////////////////////////////////////////////////////////////////////////

// The following are defined as parameters of the modules
// ledD = 23.3; // diameter of led carrier
// wall = 1.72; // thickness of walls

// The following are globally parametrized
ledM = 1;       // margin to outermost led
ledH = 3;       // led height
ledP = 0.7;     // position of click
ledC = 0.4;     // depth of click 
ledG = 4;       // gap width
hingeW = 10;    // hinge width
hingeD = 4;     // hinge depth
hingeH = 18;    // hinge height
hingeR = 1.5;   // hinge radius
eps = 0;        // separation between outer and inner parts of hinge
granu = 24;     // angular granularity of hinge

// tiltable circular led holder
module ledholder(ledD=23.3,wall=1.72){
      
    difference(){
        union(){
	   // bottom plate
	   cylinder(r=ledD/2+wall,h=ledH+2*wall);
	   // hinge
	   for(a=[90,270])rotate(a)
	      translate([-ledD/2-hingeD,0,(wall+ledH/2)])
	         rotate([0,90,0])cylinder(r1=hingeR,r2=hingeW/2,h=hingeD,$fn=granu);

        }

        // screw holes in hinge
	for(a=[90,270])rotate(a)
	      translate([-ledD/2-hingeD-0.1,0,(wall+ledH/2)])
	         rotate([0,90,0])cylinder(r=hingeR-eps,h=hingeD-1);

        // cut off top excess part of hinge
	translate([0,0,ledH+2*wall])cylinder(r=ledD/2+wall+hingeD,h=hingeW);
        // cut off bottom excess part of hinge
	translate([0,0,-hingeW])cylinder(r=ledD/2+wall+hingeD,h=hingeW);
	// hole in bottom plate
	translate([0,0,-0.01])cylinder(r=ledD/3,h=wall+0.02);
	// spacer between bottom plate and led carrier
	translate([0,0,wall-0.01])cylinder(r=ledD/2-ledM,h=wall+0.02);
	// seat of led carrier and lower snap-in
	translate([0,0,2*wall-0.01])cylinder(r=ledD/2,r2=ledD/2-ledC,h=ledP*ledH+0.2);
	// upper snap-in
	translate([0,0,2*wall+ledP*ledH-0.01])
	   cylinder(r1=ledD/2-ledC,r2=ledD/2+ledC,h=(1-ledP)*ledH+0.2);
        // cut-out 6 sectors
	for(a=[0:60:359])rotate(a)translate([-ledD,-ledG/2,wall])cube([2*ledD,ledG,2*ledH+wall]);


    }
}

// base of led frame
module ledbase(ledD=23.3,hingeH=18,wall=1.72){
  difference(){
    union(){
        
	   hull(){
	      // rectangular bottom part
              translate([-hingeW/2,-ledD/2-eps-hingeD-wall,0])
	         cube([hingeW,ledD+2*eps+2*hingeD+2*wall,wall+hingeH+1.8]);
              // cylindical top part
	      translate([0,-ledD/2-eps-hingeD-wall,wall+hingeH])rotate([-90,0,0])
	         cylinder(r=hingeW/2,h=2*hingeD+2*wall+ledD+2*eps);
	   }
    }
    // rectangular cut-out
    translate([-hingeW/2-0.01,-ledD/2-eps-wall,wall+0.99])
       cube([hingeW+0.02,ledD+2*eps+2*wall,hingeH+hingeW/2+1]);
    // hinge cut-out
    for(a=[90,270])rotate(a)
       translate([-ledD/2+eps-hingeD,0,wall+hingeH])rotate([0,90,0]){
           // conical part
           cylinder(r1=hingeR,r2=hingeW/2,h=hingeD,$fn=granu);
	   // screw hole
           translate([0,0,-7])cylinder(r=hingeW/8,h=hingeD+9,$fn=12);

       }

    // central hole for mounting screw
    translate([0,0,-1])cylinder(r=4.3/2,h=wall+2,$fn=24);

    // side hole for feeding cables
    translate([0,-ledD/2-eps,wall+1.5])rotate([120,0,0])
           cylinder(r=1.5,h=hingeD+9,$fn=12);
  }
}

// This module composes base and led holder in their final position
// using a given tilt angle of the led holder
// *** Just for illustration - don't use for printing!!! ***
module compose(angle=0,ledD=23.3,hingeH=18,wall=1.72){
  //intersection(){  // use intersection to verify that there is no overlap
  union(){           // use union for normal drawing
    color("red")translate([0,0,hingeH-ledH/2])translate([0,0,+ledH/2+wall/2])rotate([0,angle,0])translate([0,0,-ledH/2-wall/2])ledholder(ledD=ledD,wall=wall);
    color("blue")ledbase(ledD=ledD,hingeH=hingeH,wall=wall);
  }
}


//>>> uncomment exactly *one* of the following lines to choose the proper LED carrier size
//assign(led=6){   // uncomment for 23mm diameter 6 LED carrier 
//assign(led=9){   // uncomment for 24mm diameter 9 LED carrier
assign(led=12){  // uncomment for 30mm diameter 12 LED carrier
//<<<

  if(led==6){
    %compose(angle=85,ledD=23.3);
    translate([30,0,0])ledholder(ledD=23.3);
    translate([60,0,hingeW/2])rotate([0,-90,0])ledbase(ledD=23.3);
  }else if(led==9){
    %compose(angle=30,ledD=24.5,hingeH=24,wall=2.25);
    translate([30,0,0])ledholder(ledD=24.5,wall=2.25);
    translate([70,0,hingeW/2])rotate([0,-90,0])ledbase(ledD=24.5,hingeH=21,wall=2.25);
  }else if(led==12){
    %compose(angle=30,ledD=30.0,hingeH=24,wall=2.25);
    translate([30,0,0])ledholder(ledD=30.0,wall=2.25);
    translate([70,0,hingeW/2])rotate([0,-90,0])ledbase(ledD=30.0,hingeH=24,wall=2.25);
  }
}
