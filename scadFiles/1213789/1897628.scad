// Bracket Width
width = 15; // [13:100]

// Bracket Length
length = 26; // [13:100]

// Gap for Door Slider
door_gap = 3.5; 

// Bracket sidewall thickness
thickness = 2; 

screw_diam_top = 5.7;
screw_diam_bot = 2.9;
screw_head_depth = 2.5;

thickness_bot = screw_head_depth;
side_h = thickness_bot + door_gap + 0.2;


module screw_hole(d1,d2,th) {
    cylinder ($fn=30,d1=d1, d2 = d2, h=th+1);
}

rotate(a = [0, -90, 0]) {
    difference () {
        union() {
            cube ([width,length,thickness_bot]);
            cube ([thickness,length,side_h]);
            translate ([0,0,side_h]) cube ([thickness+4,length,thickness]);
        }
        translate ([width*3/5,length/3,-0.5]) screw_hole(screw_diam_bot,screw_diam_top,thickness_bot);
        translate ([width*3/5,length*2/3,-0.5]) screw_hole(screw_diam_bot,screw_diam_top,thickness_bot);
        
    }
}