twidth=3.5*25.4;
bwidth=(5*25.4)-2;
height=50;
theight=5;
bheight=15;
mheight=height-theight-bheight;
width=2;
lip=5;

union()
{translate([0,0,bheight+mheight]){
difference()
{
    cylinder(h=theight,r=twidth/2+lip);
    translate([0,0,-.5])
    cylinder(h=theight+1,r=(twidth/2)-width);
}}
translate([0,0,bheight]){
difference()
{
    cylinder(h=mheight,r1=(bwidth/2+width),r2=(twidth/2)+(lip/2));
    translate([0,0,-.5])
    cylinder(h=mheight+1,r1=(bwidth/2),r2=(twidth/2)-width+(lip/2));
}
}
difference()
{
    cylinder(h=bheight,r=bwidth/2+width);
    translate([0,0,-.5])
    cylinder(h=bheight+1,r=(bwidth/2));
}
}

