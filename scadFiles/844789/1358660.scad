$fn=100;
difference() {
    translate ([-6,-6,-4])minkowski() {
        cube([12.5,45,5]);                    
        sphere(r=3);
    }
    scale([1,1,.7]) {
        minkowski() {
            cube([.1,24,.5]);
            sphere(r=7);
        }
    }
    translate ([-15,35,-1])rotate ([0,90,0]) cylinder(r=3.5,h=30);
}