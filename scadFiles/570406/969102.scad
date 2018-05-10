/* [Options] */

// Part
part=0; // [0:Preview, 1:Left, 2:Right]

// Support thickness
support = 1; // 0 = no support, 0.5 = easy to remove

/* [print bed dimensions] */

// Print bed size, side-to-side
bedX = 225; // Replicator 225, FlashForge 230
// Print bed size, front-to-back
bedY = 154; // Replicator 154, FlashForge 154
// Print bed thickness
bedZ = 5.25; // Replicator 5.25 FlashForge 9
// From edge to center of corner screw
screwInset = 4; // Replicator 4, FlashForge 4
// Diameter of screw
screwD = 2.85;
screwR = screwD/2;
// Diameter of nut
nutD = 6.5;
nutR = nutD/2;

echo(str("Bed dimensions [",bedX,", ", bedY,", ",bedZ,"]"));

/* [Glass plate dimensions] */
// Long edge
glassX = 254; // 10 in = 254 mm
// Short edge 
glassY = 203.2; // 8.5 in = 203.2 mm
// Thickness
glassZ = 2.38125; // 3/32 in = 2.38 mm

// Hidden stuff (from Customizer)

// clip above glass
clipLen = 0*0;
clipHeight = 0*0;

// clip thickness beyond edge of glass
cornerThick = 3*1;
cornerThin=1.5*1;
cornerHeight = cornerThick+bedZ+glassZ+clipHeight;

g = 0.01*1;
// Clearance between parts
gap=0.4*1;

if (part==0) {
	%printerStuff();
	for (xm=[0:1])
		mirror([xm,0,0]) 
		for (ym=[0:1]) 
			mirror([0,ym,0]) 
				color("blue") cornerClip();
	}
if (part==1) translate([bedX/2,bedY/2,0]) cornerClip();
if (part==2) mirror([1,0,0]) translate([bedX/2,bedY/2,0]) cornerClip();

//magnetHolder();

module magnetHolder() {
	difference() {
		union() {
			cube([12,75,3],center=true);
			translate([0,75/2,0]) cylinder(h=3, r=4+2, center=true);
		}
	translate([0,75/2,-.5]) cylinder(h=4, r=4+.4);
	}
}

module printerStuff() {
	color("grey") translate([0,0,bedZ/2]) cube([bedX+2*gap,bedY+2*gap,bedZ+g], center=true);
	translate([0,0,bedZ+glassZ/2]) cube([glassX+2*gap,glassY+2*gap,glassZ+g+gap], center=true);
	translate([0,0,bedZ+glassZ]) cube([glassX-2*clipLen,glassY-2*clipLen+g,glassZ], center=true);
	
	screw();
	mirror([1,0,0]) screw();
	mirror([0,1,0]) screw();
	mirror([0,1,0]) mirror([1,0,0]) screw();
	}

module screw() {
	color("silver") translate([-bedX/2+screwInset,-bedY/2+screwInset,-5]) {
		cylinder(r=screwD/2+gap, h=10, $fn=32);
		translate([0,0,0-cornerThin]) cylinder(r=nutD/2+gap, h=5, $fn=6);
		}
	}

module cornerClip() {
	difference() {
		clip();
		printerStuff();
		}
	}

module clip() {
	lenY = glassY/2-bedY/2+screwInset+cornerThick;
	lenX = glassX/2-bedX/2+screwInset+cornerThick;
	translate([-bedX/2+screwInset,-bedY/2+screwInset,-cornerThick+cornerHeight/2]) {
		difference() {
			cube([20,2*lenY,cornerHeight+gap], center=true);
		translate([-20+support,-2*lenY+support,-(cornerHeight+gap)]/2) 
			cube([20-support,lenY-10-support/2,bedZ+1]);
		}
		difference() {
			cube([2*lenX,20,cornerHeight+gap], center=true);
		translate([-2*lenX+support,-20+support,-(cornerHeight+gap)]/2) 
			cube([lenX-10-support/2,20-support,bedZ+1]);
		}
	}
	}