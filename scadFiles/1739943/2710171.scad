/* [Geometry *] */
// Diameter of rim of lid
RimDiameter=97;
// inner diameter of narrowest part of the rim of the teapot
InnerDiameter=75.5;
// How deep is the narrowest part of the rim below the top?
Height=30;
// How much space do thumb and index-finger plus the grip need?
GripholeDiameter=45;
// If you want to avoid support, say no here and get a cone-shaped grip-hole.
GripholeBallshape=1; // [0:no, 1:yes]
// Depth of grip-hole
GripholeDepth=22.5;
// wall thickness
wt=2;
// a polygon describing the profile of the grip.
GripProfile=[[5,0],[5,2],[1,2],[1,7],[-1,7],[-1,2],[-5,2],[-5,0]];
/* [Resolution and tolerance] */
// resolution of roundings in steps/360°
fn = 128; // [8,16,32,64,128,256]
/* [Printing] */
// Only say yes here, if you want to have a sectioned view
show_sectioned=0;// [0:no, 1:yes]


/*[hidden]*/
function sqr(x)=x*x;
tol=0.01;
r_grip=GripholeDiameter/2;
gripangle = GripholeBallshape ? asin((r_grip-GripholeDepth)/r_grip) : atan2(GripholeDepth,r_grip);
gripangle_i = GripholeBallshape ? asin(((r_grip+wt)-GripholeDepth)/(r_grip+wt)) : gripangle;
beta = 90-gripangle;
dxu = wt * sqr(sin(gripangle));
dyo = gripangle<90?(wt/cos(gripangle)):wt;

difference()
{
    main();
    if (show_sectioned)
    {
        translate([-RimDiameter/2-tol,0,-tol])
            cube([RimDiameter+2*tol,RimDiameter/2+2*tol,max(Height,GripholeDepth+dyo)+2*tol]);
    }
}

Vo = GripholeBallshape ?
concat
(
    verschiebe2D(kreislinie(r=r_grip, sw=90, w=gripangle, fn=-fn),[0,-(r_grip-GripholeDepth)]),
    [[RimDiameter/2,0],[RimDiameter/2,wt],[InnerDiameter/2,wt],[InnerDiameter/2,Height]]
)
:
    [
        [0,GripholeDepth],
        [r_grip,0],
        [RimDiameter/2,0],
        [RimDiameter/2,wt],
        [InnerDiameter/2,wt],
        [InnerDiameter/2,Height]
    ]
;

Vi = GripholeBallshape ?
concat
(
    [[InnerDiameter/2-wt,Height],[InnerDiameter/2-wt,wt]],
    verschiebe2D(kreislinie(r=GripholeDiameter/2+wt, sw=gripangle_i, w=90, fn=fn),[0,-(r_grip-GripholeDepth)])
)
:
    [
        [InnerDiameter/2-wt,Height],
        [InnerDiameter/2-wt,wt],
        [min(InnerDiameter/2-wt,r_grip+dxu),wt],
        [0,GripholeDepth+dyo]
    ]
;

module main()
{
    rotate_extrude(convexity=12, $fn=fn)
    {
           polygon(concat(Vo,Vi));
    }
    difference()
    {
       translate([0,r_grip,0])
            rotate([90,0,0])
                linear_extrude(height=GripholeDiameter,convexity=8)
                    polygon(GripProfile);
        rotate_extrude(convexity=12, $fn=fn)
        {
            polygon(verschiebe2D(concat(Vi,[[0,Height]]), [tol,-2*tan(90-gripangle)*tol]));
        }
    }
}

function verschiebe2D(V,D) = [ for (v=V) v+D ];

function kreislinie(r,sw,w,fn) = 
	let(
		step = 360/fn,
		startw = sw,
		endw = (w*fn < startw*fn) ? w+360 : w
	)
	concat([ for (a=[startw : step:endw-step]) 
		[ cos(a)*r, sin(a)*r ]],[[cos(w)*r, sin(w)*r] ]);
