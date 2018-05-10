inner_diameter=41; 
outer_diameter=inner_diameter+15;
Thickness=10;
Handle_length=90; 
Handle_tip_diameter=15;
Screw_diam=5;

difference(){
    union(){
        hull(){
            cylinder(Thickness,d=outer_diameter,center=false);
            translate([-Handle_length,0,0])cylinder(Thickness,d=Handle_tip_diameter,center=false);
        }
        translate([inner_diameter/2,-Screw_diam*2,0])cube([Screw_diam*4,Screw_diam*4,Thickness]);
}
union(){
    cylinder(Thickness,d=inner_diameter,center=false);
    translate([inner_diameter/3,-Screw_diam/2,0])cube([3*inner_diameter,Screw_diam,Thickness]);
    translate([inner_diameter/2+Screw_diam*2,-Screw_diam/2,Thickness/2])rotate([90,0,0])cylinder(Screw_diam*6,d=Screw_diam,center=true);
}
}
