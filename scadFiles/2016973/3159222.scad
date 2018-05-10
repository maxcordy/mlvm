use <Write.scad>

// AA 
D = 14; L = 50.5;
// AAA 
D = 10.3; L = 44.1;
Writing = "Nuove";
//Writing = "Usate";

N = 8; // total height of the container (together with the mount) in "battery diameters"

T = 1; //wall thickness
hole_for_screws = false; //true;
/******************************************************************************/
Sup_carving_h = hole_for_screws?D:0; //22;

Tolerance = 5.0;
H = (D + Tolerance) * ((hole_for_screws?1:0)+N) + T * 2;
W = L + Tolerance + T * 2;
Depth = (D + Tolerance) + T * 2;


// $fn=0;$fs=12;$fa=2; // default res
$fn=0;$fs=1;$fa=2; // better res

//%color("cyan") translate([T+Tolerance,T+Tolerance,H-2*D]) cylinder(L,D/2,D/2);
%color("lime") translate([T,T,H-Tolerance/2-Sup_carving_h]) 
  cube([Tolerance,Tolerance,Tolerance]);
%color("yellow") translate([T+Tolerance,T+Tolerance,H-D/2-Sup_carving_h]) 
  cube([D,L,D]);

rotate([90,0,0]) 
  union(){ difference(){
        cube([Depth,W,H]); //originale
        translate([T,T,2*T]) { //buco
            cube([Depth - T * 2,W - T * 2,H]);
        };
        if (hole_for_screws) {
          translate([hole_for_screws?T:-T,-T,H-Sup_carving_h]) // Top Hole
            cube([Depth + T * 2,W + T * 2,Sup_carving_h+T]);
        translate([-2,W-6*T ,H-D/2]) { // Hole for wallfix
            rotate(a = [0,90,0])
                cylinder(h = T * 4, r = 1, $fn = 12);
            };        
        translate([-2,6*T ,H-D/2]) {  // Hole for wallfix
            rotate(a = [0,90,0])
                cylinder(h = T * 4, r = 1, $fn = 12);
            };          };
        //translate([hole_for_screws?T:-T,-T,H-Sup_carving_h]) { // Top Hole
        //    cube([Depth + T * 2,W + T * 2,Sup_carving_h+T]);
        //};

        translate([T , -T, T]) { // Down Hole
            cube([Depth-T*2 ,W + T * 2,D - T*2]);
        };
        translate([T , -T, D/2-T]) { // Down Hole part2
            cube([Depth ,W + T * 2,D]);
        };
        }; 
    color("yellow") translate([0,W/2,0])
    rotate([0,0,90]) writecube(Writing,[0,-Depth,H*.7],2*T,h=10,t=2*T,font="orbitron.dxf");
    };	

