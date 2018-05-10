/*
* Blind_Slat_Sleeve.scad
*
* Project: Joining sleeve for fixing blind slats
* Copyright (c) 2016 Shelby Merrick
* http://www.forkineye.com
*
*  This program is provided free for you to use in any way that you wish,
*  subject to the laws and regulations where you are using it.  Due diligence
*  is strongly suggested before using this code.  Please give credit where due.
*
*  The Author makes no warranty of any kind, express or implied, with regard
*  to this program or the documentation contained in this document.  The
*  Author shall not be liable in any event for incidental or consequential
*  damages in connection with, or arising out of, the furnishing, performance
*  or use of these programs.
*
*/

/******************************/
/***** USER CONFIGURATION *****/
/******************************/

blind_width = 51;       // Width of blind
blind_thickness = 2.75; // Thickness of blind
sleeve_width = 20;      // Width of sleeve    
sleeve_thickness = .8;  // Wall thickness of sleeve



/*************************************/
/***** END OF USER CONFIGURATION *****/
/*************************************/

// Globals - Don't change
$fn = 60;
radius = blind_thickness / 2;
width = blind_width - radius;

linear_extrude(height = sleeve_width) {
    difference() {
        hull() {
            circle(radius + sleeve_thickness);
            translate([width,0,0]) circle(radius + sleeve_thickness);
        }

        hull() {
            circle(radius);
            translate([width,0,0]) circle(radius);
        }
    }
}