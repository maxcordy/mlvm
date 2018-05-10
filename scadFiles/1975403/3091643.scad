
// Height (outside of box)
H     = 60;

// Width  (outside of box)
W     = 85;

// Length (outside of box)
L     = 85;

// Thickness of material
t     = 5;

// Height of legs
Hleg  = 9;

// Length of legs (length that touches surface)
Lleg  = 14;

// Length of legs at top of leg (greater than Lleg)
LlegT = 18; 

//Number of tabs across the smaller of the front or side.
Ntabs = 5; 

DISPLAY=1; //[1:Flat Pattern (2D), 0:Assembly (3D)]

// interfearance (bigger number makes tighter fit)
interfearance = 0;

//Explode Factor (multiple of thickness
explode_factor =0;


if (DISPLAY)
{
    box_flat_pattern();
}
else
{
    box_assembly();
}

/////////////////////
// END USER INPUTS //
/////////////////////


$fn=100;
echo("inside dimensions:",(W-2*t),(L-2*t),(H-2*t-Hleg));

Lavail_front = W-2*max(LlegT,Lleg);
Lavail_side  = L-2*max(LlegT,Lleg);
Lavail_min = min(Lavail_front,Lavail_side);
Wtab = Lavail_min/(Ntabs*2-1);
Wpin = Wtab; // Width of the tab used as a pin in the hinge joint

// Define colors components 
gamma = 1; // transparency level (value between 0.0 and 1.0)
Color_front  = [1.0,0.5,0.5,gamma];
Color_back   = [0.5,1.0,0.5,gamma];
Color_side_1 = [0.5,0.5,1.0,gamma];
Color_side_2 = [1.0,1.0,0.5,gamma];
Color_bottom = [0.5,1.0,1.0,gamma];
Color_top    = [1.0,0.5,1.0,gamma];

// Calculate the Effective diameter of the pin tab  
Dpin     = sqrt(Wtab*Wpin + t*t);

// Calculate the position of the pin tab hole
Xhole    = L/2-Dpin/2-t;

// dH is how muh needs to be cut off from the back to
// provide clearance for the lid to open
Rswing = sqrt( (L/2-Xhole)*(L/2-Xhole) + (t/2)*(t/2) );
xswing = L/2-Xhole-t;
yswing = Rswing*sin(acos(xswing/Rswing));
swing_fudge  = 1; //Additional clearance just to be sure
dH = yswing-t/2+swing_fudge;

Lavail_edge = H-2*(dH+t);

// Calculate the Radius and center location for
// the cut that make the arc in the legs
x1   = Wtab*(Ntabs*2-1)/2;   //Wtab*2.5;
y1   = Hleg;
x2   = ( min(W,L)-Lleg*2 )/2;
yc   = -(y1*y1 + x1*x1 - x2*x2) / (2*y1);
Rleg =  sqrt(x2*x2+yc*yc);

/////////////////////////////
//Start Module Definitions //
/////////////////////////////

module box_flat_pattern()
{
    fsep=1.05;
    Hsep1 = (H-t)*fsep;
    Hsep2 = L*fsep;
    Hsep3 = W*fsep;
    Hsep4 = (W/2)*fsep;
    color(Color_front) translate([ Hsep3*0 , 0       ]) front();
    color(Color_back)  translate([ Hsep3*1 , 0       ]) back();
    color(Color_side_1)translate([ 0       , Hsep1*1 ]) side(flip=false);
    color(Color_side_2)translate([ Hsep2*1 , Hsep1*1 ]) side(flip=true);
    color(Color_bottom)translate([ L/2     ,-Hsep4*1 ]) rotate(90) bottom();
    color(Color_top)   translate([ Hsep2*1 ,-Hsep4*1 ]) top();
}

module box_assembly()
{
    e = explode_factor*t;
    
    color(Color_front)
    translate([0,-L/2+t-e,0])rotate([90,0,0])linear_extrude(t)front();

    color(Color_back)
    translate([0, L/2-0+e,0])rotate([90,0,0])linear_extrude(t)back();

    color(Color_side_1)
    translate([W/2-t+e, 0,0])
        rotate([0,90,0])
            linear_extrude(t)
                rotate(90) side(flip=false);
    color(Color_side_2)
    translate([-W/2+t-e, 0,0])
        rotate([0,90,180])
            linear_extrude(t)
                rotate(90)side(flip=true);
    
    color(Color_bottom)
    translate([0, -L/2,Hleg])
        linear_extrude(t)
            bottom();
    
    color(Color_top)
    translate([0, 0,H-t])
        linear_extrude(t)
            rotate(-90)
            top();
}

module front()
{
    difference()
    {
        translate([-W/2,0]) square([W,H-t]);
        difference()
        {
            union()
            {
                delta = (W-min(W,L))/2;
                translate([ delta,-yc]) circle(r=Rleg);
                translate([-delta,-yc]) circle(r=Rleg);
                square([2*delta,Hleg*2],center=true);
            }
            translate([-L/2,Hleg]) square([L,H]);
        }
        translate([ W/2,H/2]) tabs(Length_in=Lavail_edge);
        translate([-W/2,H/2]) tabs(Length_in=Lavail_edge);
        rotate(90)
        {
            translate([Hleg,0]) slots(Length_in=Lavail_front);
        }
    }
}

module back()
{
    difference()
    {
        front();
        translate([0,H-t])square([W*2,dH*2],center=true);
    } 
}

module side(flip=false)
{
    Xhole_loc=(flip?-Xhole:Xhole);

    difference()
    {
        union()
        {
            translate([-L/2,0]) square([L,H]);
            difference()
            {
                translate([Xhole_loc,H-t/2])circle(r=Rswing);
                translate([L/2,0])square([L,H]);
            }
            
        }
        difference()
        {
            union()
            {
                delta = (L-min(W,L))/2;
                translate([ delta,-yc]) circle(r=Rleg);
                translate([-delta,-yc]) circle(r=Rleg);
                square([2*delta,Hleg*2],center=true);
            }
            translate([-L/2,Hleg]) square([L,H]);
        }
        translate([-L/2,H/2]) slots(Length_in=Lavail_edge);
        translate([ L/2,H/2]) slots(Length_in=Lavail_edge);
        rotate(90)
        {
            translate([Hleg,0]) slots(Length_in=Lavail_side);
        }
        translate([Xhole_loc,H-t/2])circle(d=Dpin);
    }
}

module bottom()
{
    difference()
    {
        translate([-W/2,0]) square([W,L]);
        translate([ W/2,L/2]) tabs(Length_in=Lavail_side);
        translate([-W/2,L/2]) tabs(Length_in=Lavail_side);
        rotate(90)
        {
            translate([ 0,0]) tabs(Length_in=Lavail_front);
            translate([ L,0]) tabs(Length_in=Lavail_front);
        }
    }
}

module top()
{
    difference()
    {
        square([L,W],center=true);
        rotate(90)
        {
            translate([ W/2,Xhole]) top_tabs();
            translate([-W/2,Xhole]) top_tabs();
        }
        //rotate(90) heart_pattern(size=min(L,W)/2); //heart(5);
    }
}

module tabs(Length_in=0)
{
    Nt = floor(max((Length_in/Wtab+1)/2,1));  
    start = -(Nt-1)/2;  
    difference()
    {
        square([2*t,max(H,W,L)*1.1],center=true);          
        for (i=[0:Nt-1])
        {
            pos = (start+i)*Wtab*2;
            translate([0,pos]) square([4*t,Wtab+interfearance*2],center=true);
        }
    }
}

module slots(Length_in=0)
{
    Nt = floor(max((Length_in/Wtab+1)/2,1)); 
    start = -(Nt-1)/2;
    for (i=[0:Nt-1])
    {
        pos = (start+i)*Wtab*2;
        translate([0,pos]) square([2*t,Wtab],center=true);
    }
}

module top_tabs()
{
    difference()
    {
        square([2*t,max(H,W,L)*2],center=true);        
        translate([0,i*Wtab*2])
            square([4*t,Wtab],center=true);
    }
}



module heart(size=10)
{
    resize([size,size])
    {
        radius=100/8;
        w=radius*.8;
        h=radius*2.5;
        fn=10;
        Rsmall = .1;
        shift = -(radius-(h+Rsmall))/2;
        translate([0,shift])
        {
            hull()
            {
                translate([w,0])circle(r=radius);
                translate([0,-h])circle(r=Rsmall,$fn=fn);
            }
            hull()
            {
                translate([-w,0])circle(r=radius);
                translate([0,-h])circle(r=Rsmall,$fn=fn);
            }
        }
    }
}

module heart_pattern(size=10)
{
    difference()
    {
        heart(size);
        step = 20;
        for (i=[step:step:180-step])
            rotate(i)square([1,100],center=true);
        heart(size-5);
    }
}