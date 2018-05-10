/* [Quad size] */
//Prop clearance
PropDia=34;//30+4
FootDia=9.4;//8.8+0.6
PropSpacing=32;
BaseWidth=18.6;//18+0.6
BaseHeight=4.5;
QuadHeight=20;
/* [Box size] */
LidHeight=3;
//Walls
w=4;
//Nozzle Dia
n=0.4;
//Wiggle Room (Lid) X
WiggleRoomX=0.5;
//Wiggle Room (Lid) Z
WiggleRoomZ=0.2;

//-----------
wt=w*n;//Wall Thickness
$fn=128;

box();
quadRests();
lidSupport();
rotate([180,0,0])translate([0,PropSpacing+PropDia+wt*6,-QuadHeight-wt-LidHeight])lid();
%lid();

module quadRests(){
    translate([-PropSpacing/2,-PropSpacing/2,wt])
    for (x=[0:1]){for (y=[0:1]){
    translate([x*PropSpacing,y*PropSpacing,0])
        difference(){
            cylinder(d=FootDia+wt*2,h=BaseHeight);
            cylinder(d=FootDia,h=BaseHeight+1);
        }
    }}
    difference(){
        translate([-(BaseWidth+wt*2)/2,-(BaseWidth+wt*2)/2,wt])
        cube([BaseWidth+wt*2,BaseWidth+wt*2,BaseHeight]);
        translate([-BaseWidth/2,-BaseWidth/2,wt])
        cube([BaseWidth,BaseWidth,BaseHeight+1]);
    }
    /*for (s=[0:4]){
        rotate([0,0,45+90*s])translate([13,-wt/2,wt])cube([5,wt,BaseHeight]);
    }*/
}

module box(){
    difference(){
        //Outer
    hull()translate([-PropSpacing/2,-PropSpacing/2,0]){
    for (x=[0:1]){for (y=[0:1]){
    translate([x*PropSpacing,y*PropSpacing,0])
        cylinder(d=PropDia+wt*2,h=QuadHeight+wt);
    }}}
        //Inner
    hull()translate([-PropSpacing/2,-PropSpacing/2,wt]){
    for (x=[0:1]){for (y=[0:1]){
    translate([x*PropSpacing,y*PropSpacing,0])
        cylinder(d=PropDia,h=QuadHeight+wt);
    }}}
    
    }
}

module lid(wr=WiggleRoomX){
    outerD=PropDia+(wt*6);
    lipHeight=wt*2;
    totalLidHeight=lipHeight-WiggleRoomZ+LidHeight;
    
    difference(){
        //top
    hull()translate([-PropSpacing/2,-PropSpacing/2,QuadHeight+wt]){
    for (x=[0:1]){for (y=[0:1]){
    translate([x*PropSpacing,y*PropSpacing,-lipHeight+WiggleRoomZ])
        cylinder(d=outerD,h=totalLidHeight);
    }}}
        //support
        lidSupport(hollow=false,wr=wr);
        translate([PropSpacing,0,0])lidSupport(hollow=false,wr=wr);
    }
}

module lidSupport(hollow=true,wr=0){
    bevelD=PropDia+(wt*4)+wr;
    difference(){
    //Lip
    hull()translate([-PropSpacing/2,-PropSpacing/2,QuadHeight-wt]){
    for (x=[0:1]){for (y=[0:1]){
    translate([x*PropSpacing,y*PropSpacing,0]){
        cylinder(d1=PropDia+wt*2+wr,d2=bevelD,h=wt);
        translate([0,0,wt])cylinder(d1=bevelD,d2=PropDia+wt*2+wr,h=wt);}
    }}}
    //Inner
    if (hollow){
    hull()translate([-PropSpacing/2,-PropSpacing/2,QuadHeight-wt-1]){
    for (x=[0:1]){for (y=[0:1]){
    translate([x*PropSpacing,y*PropSpacing,0])
        cylinder(d=PropDia,h=(wt*2)+2);
    }}}
    }
    }
}