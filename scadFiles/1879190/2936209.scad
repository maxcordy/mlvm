nut=.48; //measured point to point (not flat to flat)
boltdia=.25;

boltcircle=1;
handlecircle=.5;
distance=1.25;

materialthick=.2;

res=60;

module bottom(){
    difference(){
        circle(d=boltcircle, $fn=res);
        circle(d=boltdia, $fn=res);
    }
}

module middle(){
    difference(){
        hull(){
            circle(d=boltcircle, $fn=res);
            translate([distance,0]) circle(d=handlecircle, $fn=res);
        }
        circle(d=nut, $fn=6);
    }
}

module top(){
    difference(){
        hull(){
            circle(d=boltcircle, $fn=res);
            translate([distance,0]) circle(d=handlecircle, $fn=res);
        }
        circle(d=boltdia, $fn=res);
    }
}

scale([25.4, 25.4])
//bottom();
middle();
//top();