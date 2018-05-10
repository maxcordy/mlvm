/******************************************************************************/
/**********                     INFO                                 **********/
/******************************************************************************/
/*
Parametric Board Game Card Holder Rev 1.1 April 2016
by David Buhler

Baggies, lots of baggies or ziplocks are in your future if you play a lot of the 
current board games.  Most don't come with any organizer for the cards and tokens
so they lay strewn about the table and bagged when not. I search Thingiverse and 
found a couple designs for the tokens, great designs but not for the various 
size cards.  This design was to create some order for the cards and is customizable
to fit the diverse needs of all the decks out there.  

When you measure the deck size it is best to do so with calipers and add a few mm
to the width and depth of the cards, if you are doing this by tape measure be picky.
Boxes on the small side will not fit the cards, but a slight larger box will. 

Base defaults are for the smaller Star Wars Imperial Assault Decks


Attribution-NonCommercial 3.0 (CC BY-NC 3.0)
http://creativecommons.org/licenses/by-nc/3.0/

SW imperial Assault 43x65, 58x90, 

Version 1.1
fixed wall thickness and placements

*/

/******************************************************************************/
/**********                     Settings                             **********/
/******************************************************************************/
//adjust the follow to meet your needs,  all measurements in mm.

/* [BUILD PLATE] */
//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

/* [Deck Size] */
//Max number of cards in one stack
cards=22;//[5:70]

//Individual Card Thickness (0.3 seems normal)
card_thickness=0.3;//[0.1,0.2,0.3,0.4,0.5]

//Width of Cards
card_width= 43;//[30:105]

//Depth of Cards
card_depth=65;//[50:140]

//Box Edge Thickness
thickness=1;//[1:5] 

//Number of Card Trays
card_trays=6;//[1:10] 

//Back to Back?
backtoback=1;//[0:No,1:Yes]

//Text high  (only one caracter per row)
brand1="S";
//Text low  (only one caracter per row)
brand2="W";

/******************************************************************************/
/**********                   Variable Calcs                         **********/
/****                     no need to adjust these                      ********/
/******************************************************************************/
/* [HIDDEN] */
base_thickness=2;
tray_height=cards*card_thickness+base_thickness+3;//cards are about 0.3mm thick the +3 is a "looseness" addon



/******************************************************************************/
/**********                  Make It Happen Stuff                    **********/
/******************************************************************************/
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
rotate([0,0,90])translate([-card_width/(backtoback+1)*card_trays/2,-card_depth-thickness*3/2,0])//fit to center of buildplate
    if (backtoback==0){//one row or two    
        build_tray(card_trays);
        }
    else {//back to back routine, two rows
        build_tray(ceil(card_trays/2));
        translate([(card_width+thickness)*ceil((card_trays)/2)+thickness,(card_depth+thickness*2)*2-thickness,0])
            rotate([0,0,180])
            build_tray(ceil(card_trays/2));
    }

/******************************************************************************/
/**********                         Modules                          **********/
/******************************************************************************/
//builts the basic tray then replicates that with offset for the next ones
module build_tray(slots){
    for (i=[0:slots-1]){
        difference() {
            translate ([(card_width+thickness)*i,0,0])
                cube([card_width+thickness*2,card_depth+thickness*2,tray_height]);//base box
            translate ([thickness+(card_width+thickness)*i,thickness,base_thickness]) 
                cube([card_width,card_depth,tray_height]);//hollow up the insides
            translate ([thickness+4+(card_width+thickness)*i,-1,base_thickness]) 
                cube([card_width-8,card_depth,tray_height]);//make the slot to pick up cards
            translate ([(thickness+(card_width+thickness)*i)+(card_width+thickness)/2,card_depth/2,-1])
                linear_extrude(base_thickness+5) 
                    text(brand1,size=card_width/2,font="ariel:style=Bold",halign="center");//add text
            translate ([(thickness+(card_width+thickness)*i)+(card_width+thickness)/2,5,-1])
                linear_extrude(base_thickness+5) 
                text(brand2,size=card_width/2,font="ariel:style=Bold",halign="center");//add text
            }

    }
}

//display build plate on screen for reference modified thingverse code to allow above auto part placement
module build_plate(bp,manX,manY){

		translate([0,0,-.52]){
			if(bp == 0){
				%cube([285,153,1],center = true);
			}
			if(bp == 1){
				%cube([225,145,1],center = true);
			}
			if(bp == 2){
				%cube([120,120,1],center = true);
			}
			if(bp == 3){
				%cube([manX,manY,1],center = true);
			}
		
		}
		translate([0,0,-.5]){
			if(bp == 0){
				for(i = [-14:14]){
					translate([i*10,0,0])
					%cube([.5,153,1.01],center = true);
				}
				for(i = [-7:7]){
					translate([0,i*10,0])
					%cube([285,.5,1.01],center = true);
				}	
			}
			if(bp == 1){
				for(i = [-11:11]){
					translate([i*10,0,0])
						%cube([.5,145,1.01],center = true);
				}
				for(i = [-7:7]){
					translate([0,i*10,0])
						%cube([225,.5,1.01],center = true);
				}
			}
			if(bp == 2){
				for(i = [-6:6]){
					translate([i*10,0,0])
						%cube([.5,120,1.01],center = true);
				}
				for(i = [-6:6]){
					translate([0,i*10,0])
						%cube([120,.5,1.01],center = true);
				}
			}
			if(bp == 3){
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
}