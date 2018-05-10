/******************************************************************************/
/**********                     INFO                                 **********/
/******************************************************************************/

/*
Adjustable Plano Box stacking holder Rev 1.0 March 2016
by David Buhler

This project is for all those who have stacks of Plano boxes kicking around 
whether you actually use them for fishing lures or fill them with project parts, 
components and the like.  This design is for creating multiple, same width, 
stacking support frames so that bottom boxes can be retrieved with ease and then 
put back.  I needed this as I want this parts in my workshop but when on the road
will fill my toolbox with the appropriate parts I need.

This is version 1 of the design, in version 2 I would like to create a front cross 
brace that will stabilize the front more and also allow for differing width boxes 
to be stacked.

note the back and side parts are printed upside down...

Attribution-NonCommercial 3.0 (CC BY-NC 3.0)
http://creativecommons.org/licenses/by-nc/3.0/

*/

/******************************************************************************/
/**********                     Settings                             **********/
/******************************************************************************/
//adjust the follow to meet your needs,  all measurements in mm.

/* [BUILD PLATE] */
//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Ultimaker,4:Manual,5:Test]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

/* [Support] */
//Height of Plano of storage box
back_height=35;//[12:50]

//Width of Plano Box
back_width= 235;//[150:300]

//Depth of Plano Box
side_length=120;//[100:190]

//How Stong? Wall Thickness
back_thickness=4;//[4:10] 

//tab thickness (supports the plano box above)
tab_thickness=3;//[3:10]

//Support Width (first botton rib on bottom of storage box
tab_width=18;//[5:20]

/* [Pattern] */
//No Holes,hex holes or slots
hole_pattern=2;//[0:No Holes,1:Hex Holes,2:Slots]

//Diameter of hex or slot
hex_dia = 10;//[4:16]

/* [HIDDEN] */
//spacing between holes or slots
spacing = 1.0;//[.5,.6,.7,.8,.9,1.0,1.1,1.2,1.3,1.4]
replicator2=285;
replicator=225;
thingomatic=120;
ultimaker=200;
pin_width=3;//width of the support pin

/******************************************************************************/
/**********                   Variable Calcs                         **********/
/****                     no need to adjust these                      ********/
/******************************************************************************/
/* [HIDDEN] */
hoff = hex_dia+spacing;
voff = sqrt(pow(hoff,2)-pow(hoff/2,2));
link_plate=hex_dia*4;

/******************************************************************************/
/**********                  Make It Happen Stuff                    **********/
/******************************************************************************/

//this section could be done much more elegantly with variables,  this could be streamlined a lot 
if(build_plate_selector == 0){//autofit piece to the buildplate for Replicator 2
    build_plate(replicator2,153);
    if (replicator2<back_width+back_thickness*2)
       {
        split_parts();//one piece to big for printer
       }
    else{
        join_parts();//printer can handle a one piece print
    }
}
if(build_plate_selector == 1){//autofit piece to the buildplate for Replicator
    build_plate(replicator,145);
    if (replicator<back_width+back_thickness*2)
       {
        split_parts();//one piece to big for printer
       }
    else{
        join_parts();//printer can handle a one piece print
    }
}
if(build_plate_selector == 2){//autofit piece to the buildplate for Thingomatic
    build_plate(thingomatic,120);
    if (thingomatic<back_width+back_thickness*2)
       {
        split_parts();//one piece to big for printer
       }
    else{
        join_parts();//printer can handle a one piece print
    }
}
if(build_plate_selector == 3){//autofit piece to the buildplate for Ultimaker
    build_plate(ultimaker,200);   
    if (ultimaker<back_width+back_thickness*2)
       {
        split_parts();//one piece to big for printer
       }
    else{
        join_parts();//printer can handle a one piece print
    }
}
if(build_plate_selector == 4){//autofit piece to the buildplate for manual build piece size
    build_plate(build_plate_manual_x,build_plate_manual_y);
    if (build_plate_manual_x<back_width+back_thickness*2)
       {
        split_parts();//one piece to big for printer
       }
    else{
        join_parts();//printer can handle a one piece print
    }    
}
if(build_plate_selector == 5){//build piece with 0,0,0 ref for design of part
    build_plate(build_plate_manual_x,build_plate_manual_y);
    backandside ("right");
    backandside("left");
 translate ([-150,0,(back_thickness+2)])rotate ([-90,0,0]) joiner();
    }
translate([0,-10,0])cube([pin_width,6,pin_width]); //make pin
translate([10,-10,0])cube([pin_width,6,pin_width]);//make pin
translate([20,-10,0])cube([pin_width,6,pin_width]);//make pin
translate([30,-10,0])cube([pin_width,6,pin_width]); //make pin   

/******************************************************************************/
/**********                         Modules                          **********/
/******************************************************************************/

//rotates part to fit on defined print bed and sits it on z=zero
module split_parts(){
rotate ([180,0,0])translate ([-back_width/3-back_thickness,-side_length/2-5,-back_height-tab_thickness]) backandside ("right");
rotate ([180,0,0])translate ([-back_width+75,-side_length/2+5,-back_height-tab_thickness]) backandside("left");
translate ([-150,0,(back_thickness+2)])rotate ([-90,0,0]) joiner();
}

//join parts together to make one piece for printing this reduces the need for the joiner piece below
module join_parts(){
rotate ([180,0,0]) translate ([-back_width/2-back_thickness,-side_length/2,-back_height-tab_thickness])backandside ("right");
rotate ([180,0,0]) translate ([-back_width/2-back_thickness,-side_length/2,-back_height-tab_thickness])backandside("left");
}

//creates a piece that will join the two halves of the box stacker works best with the hole or slot versions of the stacker
module joiner(){
    difference() {
    translate([(back_width+back_thickness)/2-link_plate/2+hex_dia/2,0.1,1])cube([link_plate,back_thickness+2,back_height]);
    backandside ("right");
    backandside("left");
    }
    
}
//creates the back pieces and side pieces along with call to make holes
module backandside (side) {

if (side=="right"){
    difference(){//create back and cut holes
        translate([back_thickness-0.01,0,0])cube ([back_width/2,back_thickness,back_height+tab_thickness]);//back 1/2 panel  
        holes(back_width/2,back_height-tab_thickness,0,hole_pattern);
        }
    difference(){//make pin holes for alignment   
       union(){
         difference(){//create side and cut holes
            cube ([back_thickness,side_length+back_thickness,back_height+tab_thickness]); //side panel
            rotate([0,0,90]) translate([hoff/2,0,0]) holes(side_length-7,back_height-tab_thickness,0,hole_pattern);   
            }
         translate([0,0,back_height]) //box support bar
            cube ([tab_width,side_length+back_thickness,tab_thickness]);       
        }
          translate([(back_thickness-pin_width)/2,side_length-5,back_height]) 
            cube ([pin_width,pin_width,10]);//pin hole top front
          translate([(back_thickness-pin_width)/2,side_length-5,-7]) 
            cube ([pin_width,pin_width,10]);  //pin hole botton front
          translate([(back_thickness-pin_width)/2,5,back_height]) 
            cube ([pin_width,pin_width,10]);//pin hole top back
          translate([(back_thickness-pin_width)/2,5,-7]) 
            cube ([pin_width,pin_width,10]);  //pin hole bottom back
          }
    }

    else {//left side

        difference(){//create back and cut holes
            translate ([back_width/2+back_thickness-.02,0,0])//add a back_width/2-.01 to get rid of artifact
                cube ([back_width/2,back_thickness,back_height+tab_thickness]);//back 1/2 panel  
            holes(back_width,back_height-tab_thickness,back_width/hoff/2+spacing,hole_pattern);
        }
            
        difference(){//make pin holes for alignment    
            
            union(){  
                difference() {//create side and cut holes
                    translate ([back_width+back_thickness-0.1,0,0])
                        cube ([back_thickness,side_length+back_thickness,back_height+tab_thickness]); //side panel
                    rotate([0,0,90]) translate([hoff/2,-back_width,0]) holes(side_length-7,back_height-tab_thickness,0,hole_pattern);
                }
                translate([back_width-tab_width+back_thickness*2-0.1,0,back_height]) //box support bar
                    cube ([tab_width,side_length+back_thickness,tab_thickness]);
             }   
            translate([back_width+back_thickness-0.15+(back_thickness-pin_width)/2,side_length-5,back_height]) 
                cube ([pin_width,pin_width,10]);//pin hole top front
            translate([back_width+back_thickness-0.15+(back_thickness-pin_width)/2,side_length-5,-7]) 
                cube ([pin_width,pin_width,10]);//pin hole botton front
            translate([back_width+back_thickness-0.15+(back_thickness-pin_width)/2,5,back_height]) 
                cube ([pin_width,pin_width,10]);//pin hole botton back
            translate([back_width+back_thickness-0.15+(back_thickness-pin_width)/2,5,-7]) 
                cube ([pin_width,pin_width,10]);//pin hole top back
        }
    }
}

//makes the holes or slots in the back and side pieces this is modofied code from original code found on 
//thingverse called Customizable drawer box by Gian Pablo Villamil http://www.thingiverse.com/thing:684386/#files
module holes(width,height,shift,slot) {//shift allows the second base part to have holes assigned only for that section not at a 0,0,0 reference
	cols = (width / hoff);
	rows = (height / voff);
	translate([hoff-hex_dia/4,10,voff-2])
	for (i=[0:rows-1]) {
		for (j=[shift:cols-1]){
			translate([(j*hoff+i%2*(hoff/2)),0,i*voff])
			if (slot==0){
                //do nothing for now, no holes to make.  Will add a hole for joiner at some point
                }
            if (slot==1){
                if ((j*hoff+i%2*(hoff/2)+hex_dia<width)){
                    translate([(j*hoff+i%2*(hoff/2)),0,i*voff])
                        rotate([90,90,0]) cylinder(h=25,r=hex_dia/2,$fn=6); //rotate([90,90,0]) rotate([0,0,0])
                }
            }
            if (slot==2){
                hull(){//create cube with rounded corners to subtract from back and side walls
                   translate([j*hoff,-25,back_height-back_height/4-hex_dia/2])
                        rotate([90,90,90]) cube([back_height-back_height/4-hex_dia/2,25,hex_dia/2]);//h=25,r=hex_dia/2,$fn=6)
                   translate([j*hoff+hex_dia/4,0,back_height-back_height/4-hex_dia/2])
                       rotate([90,90,0]) cylinder(h=25,r=hex_dia/4,$fn=40);//([back_height-back_height/4,25,hex_dia/2]);
                   translate([j*hoff+hex_dia/4,0,back_height/4-hex_dia+1])
                       rotate([90,90,0]) cylinder(h=25,r=hex_dia/4,$fn=40);//([back_height-back_height/4,25,hex_dia/2]);
               }
           }
       }
	}
}

//display build plate on screen for reference modified thingverse code to allow above auto part placement
module build_plate(manX,manY){
	translate([0,0,-.52]){
      %cube([manX,manY,1],center = true);
    }
	translate([0,0,-.5]){
        for(i = [-(floor(manX/20)):floor(manX/20)]){
            translate([i*10,0,0])
                %cube([.5,manY,1.01],center = true);
        }
        for(i = [-(floor(manY/20)):floor(manY/20)]){
            translate([0,i*10,0])
                %cube([manX,.5,1.01],center = true);
        }
	}
}