// Custom polybowl

radius = 16;
sides = 7;
bodyHeight = 50;
baseHeight = ;
rimHeight = 1;
bodyTwist = 30;
bodyFlare = 1.8;
thickness = 1.5;

///////////////////////////////// RENDERS

//base
linear_extrude( height=baseHeight )
    polyShape( solid="yes" );


//body
translate([0,0,baseHeight])
linear_extrude( height=bodyHeight, twist=bodyTwist, scale=bodyFlare, slices=2*bodyHeight )
polyShape( solid="no" );

//rim
translate([0,0,baseHeight+bodyHeight])
rotate(-bodyTwist)
scale(bodyFlare)
linear_extrude( height=rimHeight )
polyShape( solid="no" );

///////////////////////////////// MODULES

module polyShape(solid){
difference(){
    //outside shape first
    offset( r=5, $fn=48 )
    circle( r=radius, $fn=sides );
    //take away inside shape
    if (solid=="no"){
    offset( r=5, $fn=48 )
    circle( r=radius-thickness, $fn=sides );
}
}
}