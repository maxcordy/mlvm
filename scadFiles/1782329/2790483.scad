//Journal Pen Holder
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"journal_pen_holder" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//21/9/2016 - Released
//22/9/2016 - Updates
//- Code cleanup
//- Added print option
//24/9/2016 - bug fix, small gap between cover and pen clip

/* [Options] */
// preview[view:south, tilt:side]
// Journal cover thickness.   
Cover_thickness=2.8; // [1:5]
// Diameter of the pen.
Pen_diameter=8; // [5:20]
// Width of the holder.
Holder_width=15; // [10:30]
// Increase thickness at the tip of the clip to improve retention.
Retention_factor=0.2;
// Position for printing.
Print=0; // [0:No, 1:Yes]

/* [Hidden] */
coverT=Cover_thickness;
clipT=2;
clipL=25;
clipW=Holder_width;
clipH=clipT*2+coverT;
penD=Pen_diameter;
penR=penD/2;
apex=Retention_factor;
print=Print;

epsilon=0.1;
$fn=40;

module ocylinder(R1,R2,H) {
    difference() {
        cylinder(r=R1,h=H,center=true);
        cylinder(r=R2,h=H+epsilon,center=true);
    }
}

module cover(L=clipL*2,e=0,apex=0) {
    //%cube([L+e,clipW*4,coverT],center=true);
    hull() {
        translate([1/2-L/2,0,0]) cube([1,clipW*4,coverT],center=true);
        translate([-1/2+L/2+e,0,0]) cube([1,clipW*4,coverT-apex],center=true);
    }
}



module holder() {
    //journal clip
    difference() {
        cube([clipL+clipT,clipW,clipH],center=true);
        translate([clipT/2,0,0]) cover(L=clipL,e=epsilon,apex=apex);
    }
    translate([-clipT/2-penR,0,-clipT/2-coverT/2]) cube([clipL,clipW,clipT],center=true);
    
    //pen clip
    holderAngle=260;
    holderR1=penR+clipT;
    translate([-holderR1-(clipL-clipT)/2,0,holderR1-clipH/2]) rotate([90,0,0]) difference() {
        ocylinder(holderR1,penR,clipW);
        hull() {
            rotate([0,0,180-holderAngle/2]) translate([2,holderR1,0]) cube([4,holderR1*2,clipW+epsilon],center=true);
        rotate([0,0,180+holderAngle/2]) translate([-2,holderR1,0]) cube([4,holderR1*2,clipW+epsilon],center=true);
        }
    }
}

rotX = print?90:0;
 rotate([rotX,0,0]) union() {
    %translate([clipT/2+clipL/2,0,0]) cover();
    holder();
}