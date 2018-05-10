
//CUSTOMIZER VARIABLES

/* [Mold] */
//Thickness
shape = 1; // [1:Thin, 3:Thick]

//Number of vessels
X = 1;
Y = 4;

//Brick size
x = 3;
y = 2;

/* [OTHERS] */
H=9.6;
L=8.0;
R=2.4;
Rh=1.7;
thick=1.5;


$fn=40;
module Lego(M,N,O){
    for(x=[1:M]){
        for(y=[1:N]){
            translate([(x-0.5)*L,(y-0.5)*L,-0.01]){
                cylinder(r1=R,r2=R-0.2,h=Rh+0.01);
            }
        }
    }
    translate([M*L/2,N*L/2,-H*O]){
        linear_extrude(height=H*O,convexity=10,scale=0.98){
            translate(-[M*L/2,N*L/2]){
                square([M*L,N*L]);
            }
        }
    }
}


module LegoFrame(M,N,O){
    for(x=[1:M]){
        for(y=[1:N]){
            translate([(x-0.5)*L,(y-0.5)*L,0]){
                cylinder(r=R+thick,h=Rh+thick);
            }
        }
    }
    translate([-thick,-thick,-H*O+0.01]){
        cube([M*L+thick*2,N*L+thick*2,H*O+thick]);
    }
    translate([-L*0.5-thick,-L*0.5-thick,-H*O+0.01]){
        cube([(M+1)*L+thick*2,(N+1)*L+thick*2,thick]);
    }
}

module LegoMold(M,N,O){
    rotate([180,0,0])
    difference(){
        LegoFrame(M,N,O);
        Lego(M,N,O);
    }
}


for(i=[0:X-1]){
    for(j=[0:Y-1]){
        translate([i*L*(x+1),j*L*(y+1),0]){
            LegoMold(x,y,shape/3);
        }
    }
}
