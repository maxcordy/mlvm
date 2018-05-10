$fn=100;
difference() {
    translate ([-8,-4,-.5])minkowski() {
        hull () {
            cube([16,2,1]);
            translate ([6,45,0]) cube([4,2,1]);
        }                    
        sphere(r=3.5);
    }
    scale([1,1,.7]) {
        minkowski() {
            cube([.1,24,.5]);
            sphere(r=7);
        }
    }
    translate ([0,38,-5])rotate ([0,0,0]) cylinder(r=2.5,h=30);
}