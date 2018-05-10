//*******************************************************
// ********** Prusa Rounded Clip by MacFly **************
// **            made dec 02 2015                      **
//*******************************************************

//--------------------------------------------------------------------------------------//
/* [cylinder] */
// Cylinder height mm - Hauteur du cylindre en mm. Default 20
CYLINDER_HEIGHT = 20;   // [10:100]         
// Cylinder radius mm - Rayon du cylindre en mm. Default 17.6mm (8.80 x 2 )
CYLINDER_RADIUS = 8.80; //[6:0.01:10]   
/* [Tab] */
//  Tab length - Longueur de la languette en mm. Default 15
TAB_LENGTH = 15;   // [10:1:100]         
// 5mm thickness - Epaisseur de la languette. Default 5
TAB_THICKNESS = 5;  // [5:0.5:10 ]     
// Tab width mm - Largeur de la languette en mm
TAB_WIDTH = 10; // [5:1:20]   
/* [Screw] */
// screw hole radius - Rayon du trou pour la vis
SCREW_HOLE_RADIUS = 1.5; //[0:0.1:5]
// tab screw hole 5mm from the edge - distance du trou 5mm du bord extérieur
SCREW_HOLE_OFFSET = 5; // [1:100 ]
/* [Body] */
// Default 1.4mm shell thickness |  Epaisseur de la coque du cylindre
SHELL_THICKNESS = 1.4; 

/* [Hidden] */
$fn = 100;
EXTRUSION_THICKNESS = CYLINDER_RADIUS - SHELL_THICKNESS * 2;

module cylindre()
    {
    difference()
        {
                cylinder(r=CYLINDER_RADIUS, h=CYLINDER_HEIGHT);
                translate([0,0,5]) extruCylinder();
        }
    }
    
module extruCylinder()
    {
                cylinder(r=EXTRUSION_THICKNESS, h=CYLINDER_HEIGHT - 10);  
    }
    
module  tab()
    {
     difference() {
                  
            translate([0,0,0]) rotate([90,90,0]) cube([TAB_LENGTH,TAB_WIDTH,TAB_THICKNESS]);
            translate([TAB_WIDTH/2, 75, -SCREW_HOLE_OFFSET - 1.5]) rotate([90,90,0]) cylinder(r=SCREW_HOLE_RADIUS,h=150);
     }
  }

cylindre();
translate([-TAB_WIDTH/2,TAB_THICKNESS/2,CYLINDER_HEIGHT + TAB_LENGTH]) tab();

