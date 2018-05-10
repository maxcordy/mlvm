//*********************************************
//   2.4GHz Antenna boom holder for Eachine 250 FPV racer
//             (W) Henning Stöcklein  04.10.2016
//                 Free for non commercial use
//*********************************************

// Rotation angle of antennas (30 for Eachine 250)
antangle = 30; // [20:60]

// Hole diameter of antenna tube (3.5 for bowden tube)
ant_d = 3.5 ;

// Antenna tube length (11 for Eachine 250)
ant_len = 11 ; // [6:0.5:20]

// Block height (7 for Eachine 250)
block_h = 7 ; // [5:10]

// Block width (6.5 for Eachine 250)
block_w = 6.5 ; // [5:0.1:10]

// Weight reduction slots (on/off)
oval_hole = 1 ; // [0:No, 1:Yes]

// Screw distance (30 for Eachine 250)
screw_dist = 30 ; // [20:40]

// Screw hole diameter (2.8 for M3 driller)
M3_d = 2.8 ; // [2:0.1:4]

// X position of antennas (53 for Eachine 250)
antpos_x = 53 ; // [40:60]

// y position of antennas (3 for Eachine 250)
antpos_y = 3 ; // [1:0.1:4]

// Show baseplate tail of Eachine 250?
show_tail = 0 ; // [0:No, 1:Yes]

// * End of customizable parameters
// ******************************************

module antholder()
{
    difference()
    {
       // Body frame 
       union()
       {
         intersection()
         {
            translate ([0,3,0]) cube ([100, block_w, 10], center=true) ;
            hull ()
            {
                 translate ([+antpos_x,-antpos_y,0]) rotate ([0,90,-antangle]) 
                        cylinder (r=block_h/2, h=50, $fn=30, center=true) ;
                 translate ([-antpos_x,-antpos_y,0]) rotate ([0,90,antangle])
                        cylinder (r=block_h/2, h=50, $fn=30, center=true) ;
            } // hull
         } // intersection

        // Antenna tube cylinders
        translate ([+antpos_x,-antpos_y,0]) rotate ([0,90,-antangle])  translate ([0,0,-6]) 
            cylinder (r=block_h/2, ant_len, $fn=30, center=true) ;
        translate ([-antpos_x,-antpos_y,0]) rotate ([0,90,+antangle])  translate ([0,0,+6]) 
            cylinder (r=block_h/2, ant_len, $fn=30, center=true) ;
       
        } // union
                   
       // Screw holes
       translate ([screw_dist/2, 3, 0]) cylinder (r=M3_d/2, h=20, $fn=20, center=true) ;
       translate ([-screw_dist/2, 3, 0]) cylinder (r=M3_d/2, h=20, $fn=20, center=true) ;

       // Weight reduction slots
       if (oval_hole == 1)
       {
         hull () {                // middle
            translate ([-screw_dist/2+6, 3, 3]) cylinder (r=block_w/2-1.5, h=10, $fn=20, center=true) ;
            translate ([+screw_dist/2-6, 3, 3]) cylinder (r=block_w/2-1.5, h=10, $fn=20, center=true) ;
         }
         hull () {
            translate ([screw_dist/2+6, 3, 3]) cylinder (r=block_w/2-1.5, h=10, $fn=20, center=true) ;
            translate ([screw_dist/2+18, 3, 3]) cylinder (r=block_w/2-1.5, h=10, $fn=20, center=true) ;
         }
         hull () {
            translate ([-screw_dist/2-6, 3, 3]) cylinder (r=block_w/2-1.5, h=10, $fn=20, center=true) ;
            translate ([-screw_dist/2-18, 3, 3]) cylinder (r=block_w/2-1.5, h=10, $fn=20, center=true) ;
         }
       }
       
       // Antenna tube holes
%    translate ([+antpos_x,-antpos_y,0]) rotate ([0,90,-antangle]) cylinder (r=ant_d/2, h=70, $fn=30, center=true) ;
%    translate ([-antpos_x,-antpos_y,0]) rotate ([0,90,antangle]) cylinder (r=ant_d/2, h=70, $fn=30, center=true) ;
    }
}

module eachtail()
{
    color ("Dimgrey") translate ([0,90, -1.7/2])
    difference()
    {
       cube ([70, 180, 1.8], center=true) ;
       translate ([70/2,-90-20,-5]) rotate([0,0,45]) cube ([20,20,10]);
       translate ([-70/2,-90-20,-5]) rotate([0,0,45]) cube ([20,20,10]);
    }

    // MPX plug
    difference () {
      color ("Green") translate ([27, 26, 11/2]) cube ([7, 16, 11], center=true) ;
      translate ([27, 26, 5+11/2]) cube ([5, 14, 10], center=true) ;
      translate ([24, 26, 5+11/2]) cube ([8, 9, 10], center=true) ;
    }
    
    // LED bar
    color ("Dimgrey") translate ([0, 6, 11/2]) cube ([81, 4, 13], center=true) ;
    color ("White") 
       for (px = [-37.5:10:37])                   // 8 Neopixel LEDs
           translate ([px, 3.5, 4]) cube ([5,2,5])  ;
    
}

if (show_tail == 1) eachtail() ;

translate ([0,10,block_h/2]) antholder() ;
