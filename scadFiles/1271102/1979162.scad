//The lense diameter in mm, not HALF
lensediameter = 30;
//The led diameter in mm, not HALF
leddiameter = 5.8;
//The focus in mm
focus = 25;
//The tubediameter in mm
tubediameter = 30;
//The lense height
lenseheight = 4;
//Edge to bet generated AROUND the lense, because sometimes you have to adjust the lense.
lenseedge = 5;
//This is the amount of mm increased to the focus, because the led do not emit light at Z=0, the TSAL6100 in this case @ 4.4mm, please look in the datasheet of the TSAL6100 emitter to know what i mean
ledmmstartradiation = 4.4; //4.4 if you use a TSAL6100

//Make extrapipe* ZERO do deactivate it. This adds a extra pipe to the main cylinder.
extrapipe = 20;
extrapipe_innerdiameter = 5;



height = focus + ledmmstartradiation;


difference() {

cylinder(h = height, r1 = tubediameter , r2 = tubediameter, center=true);
    cylinder(h = height, r1 = leddiameter / 2, r2 = lensediameter / 2, center=true);
}

translate([0,0,height / 2 + lenseheight / 2]) {
difference() {

cylinder(h = lenseheight , r1 = tubediameter , r2 = tubediameter, center=true);
    cylinder(h = lenseheight, r1 = lensediameter / 2 + lenseedge, r2 = lensediameter / 2 + lenseedge , center=true);
}
}

//Calculate a extra tube
translate([0,0,-(height / 2) - extrapipe / 2]) {
difference() {

cylinder(h = extrapipe , r1 = tubediameter , r2 = tubediameter, center=true);
    cylinder(h = extrapipe, r1 =  tubediameter - extrapipe_innerdiameter, r2 = tubediameter - extrapipe_innerdiameter , center=true);
}
}

