$fn=100*1;
// Base width (millimeter)
H = 16.3;  //  [4:0.1:100]
// Base length (millimeter)
L = 60; // [30:0.1:90]
// Device thickness (millimeter)
T = 8;  //  [8:0.1:12]
// Device inclination (degree)
A = 103.9;  //  [91:0.1:130]
// Dock thickness (millimeter)
D = 4;  //  [2:0.1:8]
// Backing X (millimeter)
X = 20;  // [0:0.1:30]
// Backing Y (millimeter)
Y = 0;  // [0:0.1:30]
//Y = D/2;  // [0:0.1:30]

module wall(x1,y1,x2,y2,z,t)
{
    dx=x2-x1;
    dy=y2-y1;
    l = sqrt(dx*dx+dy*dy);
    translate([x1,y1,0])cylinder(h=z,r=t/2);
    translate([x2,y2,0])cylinder(h=z,r=t/2);
    translate([x1+dx/2,y1+dy/2,z/2])rotate(atan2(dy,dx),[0,0,1])cube([l,t,z],center=true);
}

difference()
{
    union()
    {
    wall(30-L,D/2,max(24-X-2*T/2.5+Y/tan(A),30-L),Y+D/2,H,D); // base1
    wall(max(24-X-2*T/2.5+Y/tan(A),30-L),Y+D/2,24-2*T/2.5,D/2,H,D); // base2
    wall(24-2*T/2.5,D/2,30,D/2,H,D); // base0
    wall(24-2*T/2.5+23*cos(A),D/2+23*sin(A),max(24-X-2*T/2.5+Y/tan(A),30-L),Y+D/2,H,D); // back    
    wall(30,D/2,6.2*cos(110)+30,6.2*sin(110),H,D); // foot
    
    }
    translate([0,0,-1])wall(26.6-T/2.5,T/2+0.5,26.6-T/2.5+47*cos(A),T/2+0.5+47*sin(A),H+2,T); // base hole        
}