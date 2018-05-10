// preview[view:east]

/* [Print] */

part = "both"; // ["both":Arm and Mounting Plate,"plate":Mounting Plate,"arm":Arm]

/* [Mounting Plate] */

arm_y_offset = 5; // [0:30]

arm_orientation = "down"; // ["up":Up,"down":Down]

/* [Bearing Spool] */

spool_hole_depth = 25.0;
spool_hole_diameter = 38.5;

rim_width = 2;
rim_height = 1.5;

// Insert the bearing gears so that they're less than the full width of the spool.
// Very wide bearing gears will not work well unless your printer is very well
// calibrated, so use this for extra-wide spool mounts.
bearing_inset = 0;
// Thickness of the spool support ring with inset bearings. Be careful that this
// is not thick enough to overlap your gears.
spool_support_thickness = 2;

tolerance = 0.15;
number_of_planets = 5; // [2:16]
number_of_teeth_on_planets = 6; // [3:16]
approximate_number_of_teeth_on_sun = 9; // [3:16]

/* [Bearing Arm] */

// Length of the spool arm, from the mounting plate to the center of
// the spool bearing.
arm_length = 42.5; // [0:100]
arm_width  = 10;   // [0:15]
arm_height = 25;   // [0:100]

arm_clip   = 10; // [0:100]

arm_mounting_lip_width = 2; // [0:10]

arm_thickness = 5; // [0:20]

/* [Hidden] */

/***********************
 * Arm triangle module *
 ***********************/

arm_x = arm_length - spool_hole_depth / 2 + bearing_inset + rim_width;
arm_y = arm_width;
arm_z = arm_height;
// arm_clip = 10;

arm_t = arm_thickness;

lip_w = arm_mounting_lip_width;

mounting_slot_tolerance = 0.1;

hypot = sqrt(arm_x * arm_x + arm_z * arm_z);

t_ = arm_t;
b_ = arm_x + arm_clip;
h_ = arm_z;

b2 = b_ / h_ * (h_ - t_) - t_;
h2 = h_ / b_ * (b_ - t_) - t_;

b3 = b2 - t_ * sqrt(b2 * b2 + h2 * h2) / h2;
h3 = h2 - t_ * sqrt(b2 * b2 + h2 * h2) / b2;


module triangle() {
    rotate([0, 270, 0])
    intersection() {
        difference() {
            translate([0, -arm_y/2, 0])
                union() {
                    // Mounting lip
                    translate([0, -$lip_w, 0])
                        rotate([0, 0, 90])
                            intersection() {
                                linear_extrude(height=arm_z)
                                    polygon([[0 ,0],
                                             [arm_y / 2 + $lip_w,
                                              -(arm_y / 2 + $lip_w) * sqrt(2)],
                                             [arm_y + 2 * $lip_w,
                                              0]]);

                                translate([0, -arm_t, 0])
                                    cube([arm_y + $lip_w * 2,
                                          arm_t,
                                          arm_z]);
                            }

                    difference() {
                        // Main arm triangle
                        intersection() {
                            cube([arm_x, arm_y, arm_z]);
                            translate([0, arm_y, 0])
                                rotate([90, 0, 0])
                                    linear_extrude(height=arm_y)
                                        polygon([[0, 0],
                                                 [0, arm_z],
                                                 [arm_x + arm_clip, 0]]);
                        }

                        // Support hole
                        intersection() {
                            cube([arm_x - arm_t, arm_y, arm_z]);
                            translate([arm_t, arm_y, arm_t])
                                rotate([90, 0, 0])
                                    linear_extrude(height=arm_y)
                                        polygon([[0, 0],
                                                 [0, h3],
                                                 [b3, 0]]);
                        }
                    }
                }

            // Rounded nose
            translate([0, 0, arm_z])
                rotate([0, 90 + atan(arm_z / (arm_x + arm_clip)), 0])
                    translate([arm_y / 2, 0, 0])
                        difference() {
                            translate([-arm_y, -arm_y / 2 - 10, 0])
                                cube([arm_y, arm_y + 20, hypot]);
                            cylinder(r=arm_y / 2, h=hypot, $fn=64);
                        }
        }
    }
}

/********************************
 * Emmet's gear bearings module *
 ********************************/

// Planetary gear bearing (customizable)

rim_w = rim_width;
rim_h = rim_height;

d = spool_hole_depth;
h = spool_hole_diameter;

// outer diameter of ring
D = h - 2 * rim_h;
// thickness
T = d + 2 * rim_w - 2 * bearing_inset;
// clearance
tol = tolerance; // 0.15;
// number_of_planets = 5;
// number_of_teeth_on_planets = 6;
// approximate_number_of_teeth_on_sun = 9;
// pressure angle
P = 45;//[30:60]
// number of teeth to twist across
nTwist = 1;
// width of hexagonal hole
w = 6.7;

DR = 0.5*1;// maximum depth ratio of teeth

m = round(number_of_planets);
np = round(number_of_teeth_on_planets);
ns1 = approximate_number_of_teeth_on_sun;
k1 = round(2 / m * (ns1 + np));
k =  k1 * m % 2 !=0 ? k1+1 : k1;
ns = k * m / 2 - np;
echo(ns);

nr = ns+2*np;
pitchD = 0.9*D/(1+min(PI/(2*nr*tan(P)),PI*DR/nr));
pitch = pitchD*PI/nr;
echo(pitch);

helix_angle = atan(2*nTwist*pitch/T);
echo(helix_angle);

phi = $t*360/m;

module arm_bearing() {
    translate([0,0,T/2]){
        union() {
            difference(){
                cylinder(r=D/2,h=T,center=true,$fn=100);
                herringbone(nr,pitch,P,DR,-tol,helix_angle,T+0.2);
                * difference(){
                    translate([0,-D/2,0])rotate([90,0,0])monogram(h=10);
                    cylinder(r=D/2-0.25,h=T+2,center=true,$fn=100);
                }
            }
            rotate([0,0,(np+1)*180/ns+phi*(ns+np)*2/ns])
            difference(){
                mirror([0,1,0])
                    herringbone(ns,pitch,P,DR,tol,helix_angle,T);
                * cylinder(r=w/sqrt(3),h=T+1,center=true,$fn=6);
            }
            for(i=[1:m])rotate([0,0,i*360/m+phi])translate([pitchD/2*(ns+np)/nr,0,0])
                rotate([0,0,i*ns/m*360/np-phi*(ns+np)/np-phi])
                    herringbone(np,pitch,P,DR,tol,helix_angle,T);

            translate([0,0,-T/2 - bearing_inset]) {
                difference() {
                    cylinder(r=D/2 + rim_h, h=rim_w, $fn=512);
                    translate([0, 0, -1])
                    cylinder(r=D/2 - 1,     h=rim_w + 2, $fn=512);
                }
            }

            translate([0, 0, T/2 - rim_w + bearing_inset]) {
                difference() {
                    cylinder(r=D/2 + rim_h, h=rim_w, $fn=512);
                    translate([0, 0, -1])
                    cylinder(r=D/2 - 1,     h=rim_w + 2, $fn=512);
                }
            }

            if (bearing_inset) {
                translate([0, 0, -bearing_inset - T/2])
                    difference() {
                        union() {
                            cylinder(r=D/2, h=bearing_inset + 0.01, $fn=100);
                            translate([0, 0, bearing_inset + T - 0.01])
                            cylinder(r=D/2, h=bearing_inset + 0.01, $fn=100);
                        }
                        translate([0, 0, -1])
                        cylinder(r=D/2 - spool_support_thickness, h=d + 2 * rim_w + 2, $fn=100);
                    }
            }
        }
    }
}

module rack(
    number_of_teeth=15,
    circular_pitch=10,
    pressure_angle=28,
    helix_angle=0,
    clearance=0,
    gear_thickness=5,
    flat=false) {

    addendum=circular_pitch/(4*tan(pressure_angle));

    flat_extrude(h=gear_thickness,flat=flat)translate([0,-clearance*cos(pressure_angle)/2])
        union(){
            translate([0,-0.5-addendum])square([number_of_teeth*circular_pitch,1],center=true);
            for(i=[1:number_of_teeth])
                translate([circular_pitch*(i-number_of_teeth/2-0.5),0])
                polygon(points=[[-circular_pitch/2,-addendum],[circular_pitch/2,-addendum],[0,addendum]]);
        }
    }

module monogram(h=1)
    linear_extrude(height=h,center=true)
        translate(-[3,2.5])union(){
            difference(){
                square([4,5]);
                translate([1,1])square([2,3]);
            }
            square([6,1]);
            translate([0,2])square([2,1]);
        }

module herringbone(
    number_of_teeth=15,
    circular_pitch=10,
    pressure_angle=28,
    depth_ratio=1,
    clearance=0,
    helix_angle=0,
    gear_thickness=5) {

    union(){
        gear(number_of_teeth,
            circular_pitch,
            pressure_angle,
            depth_ratio,
            clearance,
            helix_angle,
            gear_thickness/2);
        mirror([0,0,1])
            gear(number_of_teeth,
                circular_pitch,
                pressure_angle,
                depth_ratio,
                clearance,
                helix_angle,
                gear_thickness/2);
    }
}

module gear (
    number_of_teeth=15,
    circular_pitch=10,
    pressure_angle=28,
    depth_ratio=1,
    clearance=0,
    helix_angle=0,
    gear_thickness=5,
    flat=false) {

    pitch_radius = number_of_teeth*circular_pitch/(2*PI);
    twist=tan(helix_angle)*gear_thickness/pitch_radius*180/PI;

    flat_extrude(h=gear_thickness,twist=twist,flat=flat)
        gear2D (
            number_of_teeth,
            circular_pitch,
            pressure_angle,
            depth_ratio,
            clearance);
    
}

module flat_extrude(h,twist,flat) {
        if(flat==false)
            linear_extrude(height=h,twist=twist,slices=twist/6)child(0);
        else
            child(0);
    
}

module gear2D (
    number_of_teeth,
    circular_pitch,
    pressure_angle,
    depth_ratio,
    clearance) {

    pitch_radius = number_of_teeth*circular_pitch/(2*PI);
    base_radius = pitch_radius*cos(pressure_angle);
    depth=circular_pitch/(2*tan(pressure_angle));
    outer_radius = clearance<0 ? pitch_radius+depth/2-clearance : pitch_radius+depth/2;
    root_radius1 = pitch_radius-depth/2-clearance/2;
    root_radius = (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
    backlash_angle = clearance/(pitch_radius*cos(pressure_angle)) * 180 / PI;
    half_thick_angle = 90/number_of_teeth - backlash_angle/2;
    pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
    pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
    min_radius = max (base_radius,root_radius);

    intersection(){
        rotate(90/number_of_teeth)
            circle($fn=number_of_teeth*3,r=pitch_radius+depth_ratio*circular_pitch/2-clearance/2);
        union(){
            rotate(90/number_of_teeth)
                circle($fn=number_of_teeth*2,r=max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2));
            for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth){
                halftooth (
                    pitch_angle,
                    base_radius,
                    min_radius,
                    outer_radius,
                    half_thick_angle);      
                mirror([0,1])halftooth (
                    pitch_angle,
                    base_radius,
                    min_radius,
                    outer_radius,
                    half_thick_angle);
            }
        }
    }
}

module halftooth (
    pitch_angle,
    base_radius,
    min_radius,
    outer_radius,
    half_thick_angle) {

    index=[0,1,2,3,4,5];
    start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
    stop_angle = involute_intersect_angle (base_radius, outer_radius);
    angle=index*(stop_angle-start_angle)/index[len(index)-1];
    p=[[0,0],
        involute(base_radius,angle[0]+start_angle),
        involute(base_radius,angle[1]+start_angle),
        involute(base_radius,angle[2]+start_angle),
        involute(base_radius,angle[3]+start_angle),
        involute(base_radius,angle[4]+start_angle),
        involute(base_radius,angle[5]+start_angle)];

    difference(){
        rotate(-pitch_angle-half_thick_angle)polygon(points=p);
        square(2*outer_radius);
    }
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / PI;

// Calculate the involute position for a given base radius and involute angle.

function involute (base_radius, involute_angle) =
[
    base_radius*(cos (involute_angle) + involute_angle*PI/180*sin (involute_angle)),
    base_radius*(sin (involute_angle) - involute_angle*PI/180*cos (involute_angle))
];

/*************************
 * Mounting plate module *
 *************************/

upside_down = arm_orientation == "up" ? 0 : 1;

$lip_w = lip_w;

xoff = arm_y / 2;

plate_h = 5 + arm_z - (upside_down ? xoff : 0);
plate_w = 5 + 5 + arm_y + 2 * lip_w;

plate_d_i = lip_w + 1;
plate_d_screw = 5;
plate_d = plate_d_screw + plate_d_i;

plate_y_o = upside_down ? arm_y_offset : arm_y_offset + arm_z;

screw_d_head = 4;

mount_w = 57;
mount_h = 10;
mount_d_screw = plate_d_screw - screw_d_head + 1;

module screw() {
    union() {
        // Head
        translate([0, 0, -0.1])
            cylinder(d=5.5, h=4 + 0.1, $fn=64);

        // Threads
        translate([0, 0, -10])
            cylinder(d=3.2, h=10, $fn=64);
    }
}

module screws() {
    translate([mount_h / 2, 0, mount_d_screw])
        union() {
            translate([0, 15, 0])
                screw();
            translate([0, 15 + 36.5, 0])
                screw();
        }
}

/**********
 * Output *
 **********/

// Bearings and arm
module thing_arm() {
    rotate([0, 180, 0])
        translate([0, 0, -T - bearing_inset])
            union() {
                translate([arm_y / 4, 0, -arm_x + 1])
                    triangle();
                arm_bearing();
            }
}

// Mounting plate
module thing_mounting_plate() {
    difference() {
        union() {
            // Mounting plate
            translate([-plate_h / 2, 0, plate_d / 2])
                cube([plate_h, plate_w, plate_d], center=true);

            // Top riser
            translate([0, -plate_w / 2, 0])
                cube([plate_y_o, plate_w, plate_d_screw]);
            
            // Screw strip
            translate([plate_y_o, -plate_w / 2, 0])
                union() {
                    difference() {
                        cube([mount_h, mount_w, plate_d_screw]);

                        // Screw holes
                        screws();
                    }

                    // Phantom screws, because why not.
                    % screws();
                }
        }

        if (upside_down) {
            // Negative space for bracket
            translate([1 - arm_z + xoff, 0, plate_d - plate_d_i])
                assign($lip_w = lip_w + mounting_slot_tolerance) {
                    rotate([0, 0, 180])
                        union() {
                            triangle();
                            translate([-xoff, 0, 0])
                                triangle();
                        }
                }

            // Actual-sized bracket
            translate([0 - arm_z + xoff, 0, plate_d - plate_d_i])
                rotate([0, 0, 180])
                    % triangle();
        } else {
            // Negative space for bracket
            translate([1, 0, plate_d - plate_d_i])
                assign($lip_w = lip_w + mounting_slot_tolerance) {
                    triangle();
                }

            // Actual-sized bracket
            translate([0, 0, plate_d - plate_d_i])
                % triangle();
        }
    }
}

rotate([0, 0, -90])
    union() {
        if (part == "both" || part == "plate") {
            translate([0, h / 2 + plate_w / 2 + 5, 0])
                thing_mounting_plate();
        }
        if (part == "both" || part == "arm") {
            thing_arm();
        }
    }

// vim:se sts=4 sw=4 et:
