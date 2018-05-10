/* [Global] */

// Which part would you like to see?
part = "everything"; // [spinner:Spinner,halfhub:Half-hub,hub:Full hub (not recommended),everything:Everything together (for preview only)]

/* [Hidden] */

// Render O-ring and split ring as transparent overlays?
show_extras = 1; // [1:Yes,0:No]

/* [Hub] */

// Inner diameter of the split ring (mm) (32.5 for a 1.5" split ring)
splitring_id = 32.5; // 

// Outer diameter of the split ring (mm) (38 for a 1.5" split ring)
splitring_od = 38; // 

// Height/thickness of the split ring (mm) (3.3 for a 1.5" split ring)
splitring_height = 3.3;

// Diameter of the center hole (mm)
hub_center_hole_od = 3; // 

// Number of additional holes in the hub:
hub_side_holes_count = 4; // [0:16]

// Distance from the center for the additional holes (mm)
hub_side_holes_dist = 6; // 

// Diameter of the additional holes (mm)
hub_side_holes_dia = 3;  // 

// What fraction of the hub is the inner flat part vs. the tapered? Setting to 0 means very tight fit, setting to 100 means very loose fit (no taper at all!) 
hub_flat_percentage = 50; // [0:100]
hub_flat_ratio = hub_flat_percentage/100;

/* [Spinners] */

// Number of spinners
num_spinners = 10; // [0:32]

// Inner diameter of the rubber O-ring (mm)
oring_id = 8; // 

// Outer diameter of the rubber O-ring (mm)
oring_od = 13; // 

// Excess margin beyond the split ring to widen the spinner's hole (mm)
spinner_hole_margin = 0.5;

// How much wider should the hub slots be than the spinners? 0.2 means 20% wider. Wider means reduced chance of friction, but reduced strength, and the possibility of the spinners rocking laterally.
spinner_margin_theta = 0.2;

// How much deeper should the hub slots be than the spinners? 0.3 means 30% deeper. Deeper means reduced chance of friction, but reduced strength.
spinner_margin_r = 0.3;

splitring_cd = (splitring_od+splitring_id)/2;
splitring_width = (splitring_od-splitring_id)/2;
oring_cd = (oring_od+oring_id)/2;
oring_width = (oring_od-oring_id)/2;

if (part == "spinner") {
    $fn=40;
    spinner();
} else if (part == "halfhub") {
    $fn=30;
    rotate([180,0,0]) halfhub();
} else if (part == "hub") {
    $fn=30;
    hub(); 
} else if (part == "everything") {
    $fn=15;
    hub();
    multi_spinners();
}

module halfpiece(d1,d2,h,hole_od) {
    difference() {
        cylinder(d1=d1, d2=d2, h=h/2);
        translate([0,0,-1]) cylinder(h=h+1, d=hole_od);
    }
}
module piece(d1,d2,h,hole_od) {
    halfpiece(d1,d2,h,hole_od);
    scale([1,1,-1]) halfpiece(d1,d2,h,hole_od);
}

module spinner() {
    piece(oring_id,oring_cd,oring_width,max(splitring_height,splitring_width)+spinner_hole_margin*2);
    if (show_extras) %oring();
}

module oring() {
    rotate_extrude(convexity=10) translate([oring_cd/2,0,0]) circle(d=oring_width);
}

module splitring() {
    //rotate_extrude(convexity=10) translate([splitring_cd/2,0,0]) circle(d=splitring_width);
    rotate_extrude(convexity=10) translate([splitring_cd/2,0,0]) 
        polygon([
            [-splitring_width/2,0],
            [0, +splitring_height/2],
            [+splitring_width/2,0],
            [0, -splitring_height/2]
        ]);
}


module spinner_with_oring(dx=0,dy=0) {
    oring();
    translate([0,0,-oring_width/2]) cylinder(d=oring_cd, h=oring_width);
    
}

module at_spinnerpoints() {
    for (i = [0:num_spinners-1]) {
        rz = i/num_spinners*360;
        rotate([0,0,rz]) translate([splitring_cd/2,0,0]) rotate([90,0,0]) children();
    }
}

module multi_spinners() {
    at_spinnerpoints() spinner();
}

module halfhub() {
    difference() {
        union() {
            //cylinder($fn=$fn*2, d1=splitring_id, d2=splitring_cd, h=splitring_height/2);
            halfhub_flat_height = splitring_height/2 * hub_flat_ratio;
            halfhub_angle_height = splitring_height/2 * (1-hub_flat_ratio);
            cylinder($fn=$fn*2, d=splitring_id, h=halfhub_flat_height);
            translate([0,0,halfhub_flat_height]) 
                cylinder($fn=$fn*2, d1=splitring_id, d2=splitring_cd, h=halfhub_angle_height);
        }
        translate([0,0,-1]) cylinder(h=splitring_height+1, d=hub_center_hole_od);
        at_spinnerpoints() 
            scale([1+spinner_margin_r,1+spinner_margin_r,1+spinner_margin_theta]) spinner_with_oring();
        for (i = [0:hub_side_holes_count-1]) {
            rz = i/hub_side_holes_count*360;
            rotate([0,0,rz]) translate([hub_side_holes_dist,0,-1]) cylinder(h=splitring_height+1, d=hub_side_holes_dia);
        }
    }
}

module hub() {
    halfhub();
    scale([1,1,-1]) halfhub();
    if (show_extras) %splitring();
}
//hub();
//multi_spinners();
//spinner_with_oring();