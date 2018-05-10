inch = 25.4*1;
$fn=32*1;

TEST_MODE = 0*1;

/* [Shaft 1] */

// Shape of shaft 1 (the lower part of the coupler).
s1_type = "HEX"; // [HEX,SQUARE,ROUND,ROUND+KEY,ROUND+1FLAT,ROUND+2FLAT]

// Gender of shaft 1.
s1_gender = "MALE"; // [MALE,FEMALE]

// Diameter of shaft 1 (mm). For SQUARE and HEX, this is measured across the flats.
s1_dia  = 10;

// For ROUND+KEY, this is the size of the keyway (mm). For ROUND+1FLAT and ROUND+2FLAT, this is the amount of the round shaft that is shaved off to make the flat (mm).
s1_cutout = 2;

// Length of the coupler on the shaft 1 side (mm).
s1_length = 12;

// Tolerance percentage -- how much to shrink a male shaft or how much to grow a female receiver (percentage).
s1_tol_pct = 5; // [0:15]





/* [Shaft 2] */

// Shape of shaft 2 (the upper part of the coupler).
s2_type = "ROUND+KEY"; // [HEX,SQUARE,ROUND,ROUND+KEY,ROUND+1FLAT,ROUND+2FLAT]

// Gender of shaft 2.
s2_gender = "FEMALE"; // [MALE,FEMALE]

// Diameter of shaft 1 (mm). For SQUARE and HEX, this is measured across the flats.
s2_dia  = 10;

// For ROUND+KEY, this is the size of the keyway (mm). For ROUND+1FLAT and ROUND+2FLAT, this is the amount of the round shaft that is shaved off to make the flat (mm).
s2_cutout = 2;

// Length of the coupler on the shaft 1 side (mm).
s2_length = 12;

// Tolerance percentage -- how much to shrink a male shaft or how much to grow a female receiver (percentage).
s2_tol_pct = 5; // [0:15]





/* [General settings] */

// For male/female couplers, how much of the middle area to fill in for structural strength (mm). This doesn't add to the coupler length, rather it just "fills in" some of the two sides with solid matter.
middle_length = 3;

// For ROUND FEMALE couplers, diameter of side holes for set screws (mm).
set_screw_dia = 3;

// How much to "back off" the keyway depth. A value of 0.50 would mean that half the key is in the male shaft and half is in the female receiver. Higher values give more play for the key, and are a form of tolerance.  
keyway_depth_factor = 0.70*1;

// For couplers where shaft 1 is male, shaft 2 is female, and shaft 1 is significantly larger than shaft 2, we'll attempt to make a "single form" coupler, wherein shaft 2 goes entirely inside of the coupler, basically adapting it to become the size of shaft 1. If this behavior is undesired, set this to "Yes", and a standard two-sided coupler will be generated.
disable_single_form = 0; // [0:No, 1:Yes]

attempt_single_form = !disable_single_form;

// For female receivers, minimum amount of plastic on the outside for strength (mm).
min_thickness = 3;

// For female ROUND types, minimum amount of plastic on the outside -- the setscrew will go through this material, so it's typically a bit more than just min_thickness
thickness_for_setscrews = 6;




// take the measure across the flats and make it into the measure across the points
function flats2points(form,d) = 
    form=="HEX"    ? d*(2/sqrt(3)) : 
    form=="SQUARE" ? d*(2/sqrt(2)) : 
    form=="TRIANGLE" ? d*(sqrt(2)) : 
    d; // < round forms have no change

module hexagon(dia_flats) {
    circle($fn=6,d=flats2points("HEX",dia_flats));
}

module shaft_form(form, gender, d, tol, cutout=0) {
    tol_factor = gender=="MALE" ? (1-tol) : (1+tol);
    dd = d*tol_factor;
    if      (form=="HEX") hexagon(dd);
    else if (form=="TRIANGE") circle($fn=3,d=dd);
    else if (form=="PENT") circle($fn=5,d=dd); // << aint nobody gonna need this
    else if (form=="SQUARE") square(dd,center=true);
    else if (form=="ROUND") circle(d=dd);
    else if (form=="ROUND+1FLAT" || form=="ROUND+2FLAT") {
        difference() {
            circle(d=dd);
            for (m = form=="ROUND+2FLAT" ? [0,1] : [0]) {
                mirror([0,m,0]) translate([-dd/2, (d/2-cutout)*tol_factor]) square([dd,dd]);
            }
        }
    }else if(form=="ROUND+KEY") {
        if (gender=="FEMALE") {
            circle(d=dd);
            rotate(90) translate([-cutout/2,0]) square([cutout,d/2+cutout*keyway_depth_factor]);
        } else {
            difference() {
                circle(d=dd);
                translate([-cutout/2,d/2-cutout*keyway_depth_factor]) square([cutout,cutout]);
            }
        }
    }
}

// types: ["HEX","SQUARE","ROUND","ROUND+KEY","ROUND+1FLAT","ROUND+2FLAT"]
//    also valid, but may have bugs for certain geometries: ["TRIANGLE","PENT"]
// genders: ["MALE","FEMALE"]
module coupler(
    s1_type, s1_gender, s1_dia, s1_cutout, s1_tol_pct, s1_length, 
    s2_type, s2_gender, s2_dia, s2_cutout, s2_tol_pct, s2_length, 
    set_screw_dia = 3, 
    keyway_depth_factor = 0.70, 
    attempt_single_form = true, 
    min_thickness = 3, 
    thickness_for_setscrews = 6) {
        
    //echo(">>",s1_type, s1_gender, s1_dia, s1_cutout, s1_tol_pct, s1_length,     s2_type, s2_gender, s2_dia, s2_cutout, s2_tol_pct, s2_length);

    s1_tol = s1_tol_pct/100;
    s2_tol = s2_tol_pct/100;
    s1_dia_max = flats2points(s1_type, s1_dia);
    s2_dia_max = flats2points(s2_type, s2_dia);

    // all-in-one mode?
    if (attempt_single_form && s1_gender=="MALE" && s2_gender=="FEMALE" && s1_dia/2-s2_dia/2>=min_thickness) {
        
        color("cyan") difference() {
            linear_extrude(s1_length+s2_length, convexity=5) difference() {
                shaft_form(s1_type, s1_gender, s1_dia, s1_tol, s1_cutout);
                shaft_form(s2_type, s2_gender, s2_dia, s2_tol, s2_cutout);
            }
        
            // we do s2 set screws only, since it doesnt make sense to do the s1 set screw holes, since s1 is male by definition here
            
            // s2 set screws
            if (s2_type=="ROUND") {
                set_screw_angles = 
                    s1_type=="HEX" ? [30,150,270] : 
                    s1_type=="ROUND+KEY" ? [0,180,270] : 
                    [0,90,180,270];
                for (theta = set_screw_angles) {
                    rotate(theta) translate([0,0,s1_length+s2_length/2]) rotate([0,90,0]) cylinder(d=set_screw_dia, h=s1_dia+1);
                }
            }
        }
        
    } else {
        // normal two-sided thing
        
        // thickness is valid for female only, but needed for below general calculation
        thickness1 = 
            s1_type=="ROUND"?thickness_for_setscrews:
            s1_type=="ROUND+KEY"?min_thickness+s1_cutout:
            min_thickness;
        od1 = s1_dia_max + (s1_gender=="FEMALE" ? thickness1 : 0);

        thickness2 = 
            s2_type=="ROUND"?thickness_for_setscrews:
            s2_type=="ROUND+KEY"?min_thickness+s2_cutout:
            min_thickness;
        od2 = s2_dia_max + (s2_gender=="FEMALE" ? thickness2 : 0);
        
        od = max(od1,od2);

        if (s1_gender=="MALE") {
            linear_extrude(s1_length, convexity=5) {
                shaft_form(s1_type, s1_gender, s1_dia, s1_tol, s1_cutout);
            }
        } else { // s1_gender FEMALE
            difference() {
                linear_extrude(s1_length, convexity=5) difference() {
                    circle(d=od);
                    shaft_form(s1_type, s1_gender, s1_dia, s1_tol, s1_cutout);
                }
                if (s1_type=="ROUND") {
                    set_screw_angles = [0,90,180,270];
                    for (theta = set_screw_angles) {
                        rotate(theta) translate([0,0,s1_length/2]) rotate([0,90,0]) cylinder(d=set_screw_dia, h=od);
                    }
                }
            }
        }
        
        if (s1_gender!=s2_gender) {
            translate([0,0,s1_length-middle_length/2]) {
                cylinder(d=od, h=middle_length);
            }
        }
        
        translate([0,0,s1_length]) {
            if (s2_gender=="MALE") {
                linear_extrude(s2_length, convexity=5) {
                    shaft_form(s2_type, s2_gender, s2_dia, s2_tol, s2_cutout);
                }
            } else { // s2_gender FEMALE
                difference() {
                    linear_extrude(s2_length, convexity=5) difference() {
                        circle(d=od);
                        shaft_form(s2_type, s2_gender, s2_dia, s2_tol, s2_cutout);
                    }
                    if (s2_type=="ROUND") {
                        set_screw_angles = [0,90,180,270];
                        for (theta = set_screw_angles) {
                            rotate(theta) translate([0,0,s2_length/2]) rotate([0,90,0]) cylinder(d=set_screw_dia, h=od);
                        }
                    }
                }
            }
            
            
        }
            
    }
}

module TEST_ALL() {
    // test all combinations and lay them out in a big array
    types = ["HEX","SQUARE","ROUND","ROUND+KEY","ROUND+1FLAT","ROUND+2FLAT"];
    genders = ["MALE","FEMALE"];
    dias1 = [15];
    dias2 = [9]; //dias1;
    cutout = 2;
    tol = 5;
    s_length = 10;
    for (s1_type_i = [0:len(types)-1]) {
        s1_type = types[s1_type_i];
        
        for (s1_gender_i = [0:len(genders)-1]) {
            s1_gender = genders[s1_gender_i];
            
            for (s1_dia_i = [0:len(dias1)-1]) {
                s1_dia = dias1[s1_dia_i];
                
                for (s2_type_i = [0:len(types)-1]) {
                    s2_type = types[s2_type_i];
                    
                    for (s2_gender_i = [0:len(genders)-1]) {
                        s2_gender = genders[s2_gender_i];
                        
                        for (s2_dia_i = [0:len(dias2)-1]) {
                            s2_dia = dias2[s2_dia_i];
                            
                            x = (s1_type_i*len(genders)+s1_gender_i)*len(dias1)+s1_dia_i;
                            y = (s2_type_i*len(genders)+s2_gender_i)*len(dias2)+s2_dia_i;
                            echo(x,y, 
                                s1_type,s1_gender,s1_dia,cutout,tol,s_length,
                                s2_type,s2_gender,s2_dia,cutout,tol,s_length);
                            
                            translate([30*x,30*y]) coupler(
                                s1_type,s1_gender,s1_dia,cutout,tol,s_length,
                                s2_type,s2_gender,s2_dia,cutout,tol,s_length
                            );
                        }
                    }
                }
            }
        }
    }
}


if (TEST_MODE) {
    TEST_ALL();
    
} else {
    coupler(
        s1_type, s1_gender, s1_dia, s1_cutout, s1_tol_pct, s1_length, 
        s2_type, s2_gender, s2_dia, s2_cutout, s2_tol_pct, s2_length, 
        set_screw_dia, 
        keyway_depth_factor, 
        attempt_single_form, 
        min_thickness, 
        thickness_for_setscrews);
}