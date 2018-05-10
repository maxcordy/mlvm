length = 50;
shape = 1.6;
height = 1.588;
width = .8;
thickness = 1.1;
brimthickness = .3;
reverse = false;

function f(x) = pow(x,shape);
module aerofoil(a,b,w,h,res) {
    xscale = (b-a)/res;
    for(x = [a:xscale:b]) {
        translate([x*x,x,0]) {
            rotate([0,0,45]) cube([xscale,w,h]);
        }
    }
}

scaler = length/sqrt(2);

scale(scaler) {
    if(!reverse) {
        aerofoil1(0,2,width/scaler,thickness/scaler,31); //top
        aerofoil1(0,2,height/scaler,brimthickness/scaler,31); //bottom
    }
    else {
        rotate([0,180,0]) {
            translate([0,0,-thickness/scaler]) aerofoil1(0,2,width/scaler,thickness/scaler,31); //top
            translate([0,0,-brimthickness/scaler]) aerofoil1(0,2,height/scaler, brimthickness/scaler,31); //bottom
        }
    }
}

//rotate([0,0,45]) cube([.4,1.6,1.1]);
//translate([scaler-1.2, scaler-2.2,0]) rotate([0,0,45]) cube([.4,1.6,1.1]);
module aerofoil1(a,b,w,h,res) {
    xscale = (b-a)/res;
    list = [for(x=[a:xscale:b]) x < (b-a)/2 ?  [x, f(x)] : [2-x-w/sqrt(2), f(2-x)+w/sqrt(2)]];
    rotate([0,0,45]) linear_extrude(h) {polygon(list);}
}


