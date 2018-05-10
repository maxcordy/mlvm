diameter=50;

difference(){
    pot(diameter);
    translate([0,0,2]) linear_extrude(height=160) scale([0.7,0.7,0]) wall(diameter,false);
}
module base(diameter){
    circle(diameter);
    translate([diameter*2/3,0,0]) circle(30);
    translate([0,diameter*(2/3),0]) circle(30);
    translate([-(diameter*(2/3)),0,0]) circle(30);
    translate([0,-(diameter*(2/3)),0]) circle(30);
}

module wall(diameter,hollow){
    if(hollow){
        difference(){
            base(diameter);
            base(diameter-3);
        }
    }
    else if(!hollow){
        base(diameter);
    }
}

module pot(diameter){
    linear_extrude(height=2) wall(diameter,false);
    linear_extrude(height=20,scale=1.5) wall(diameter,false);
    translate([0,0,20]) linear_extrude(height=50,scale=1.1) scale([1.5,1.5,0]) wall(diameter,false);
    translate([0,0,70]) linear_extrude(height=60,scale=0.5) scale([1.65,1.65,0]) wall(diameter,false);
    translate([0,0,130]) linear_extrude(height=30,scale=1.3) scale([0.825,0.825,0]) wall(diameter,true);
}