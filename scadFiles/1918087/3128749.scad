// Element to be generated
Element="Set";
// [Set, Drawer1, Drawer2, Drawer4, Left_Corner, Right_Corner, Left_Edge, Right_Edge,
// Horizontal_Plug_Length, Horizontal_Plug_Width, Horizontal_Plug_Middle,
//Vertical_Plug, Vertical_Plug_Top, Vertical_Plug_Middle, Shelf]

// Nuber of Elements, when Element=Set or Drawer1,2,4 the Number of generated elements is limited to 1
Number=1; // [1:1:8]

// Width of the drawer, Width of Box = drawer_width + 2*plug_width
drawer_width=116; // [50:1:160]

// Length of the drawer, Length of Box = drawer_length
drawer_length=132; // [50:1:160]

// Height of the drawer
drawer_height=27; // [16:1:160]

// Thickness of the drawer walls
drawer_thickness=0.8; // [0.4:0.1:2]

// Width of the plugs
plug_width=8; // [4:0.5:20]

// Adjustment value for correction when using differences in OpenSCAD
adjustment=0.7; // [0.1:0.05:1]

// Height of the ledge in a horizontal connector
plug_ledge=1.4; // [0.4:0.1:2]

// Radius of the corners on the front panel of a drawer
cornerradius=4; // [0.5:0.5:6]

// Number of fragments, see OpenSCAD documentation for details
$fn=40;

if (Element=="Drawer1" || Element=="Drawer2" || Element=="Drawer4" || Element=="Set" || Element=="Shelf") {Number=1;}

// Drawing the selected Element
for (i=[0:Number-1]) {
  if (Element=="Set") {
    corner("l",[(1*3+2)*plug_width-drawer_length,-plug_width+drawer_height,0]);
    corner("l",[(2*3+2)*plug_width-drawer_length,-plug_width+drawer_height,0]);
    corner("r",[(3*3+2)*plug_width-drawer_length,-plug_width+drawer_height,0]);
    corner("r",[(4*3+2)*plug_width-drawer_length,-plug_width+drawer_height,0]);
    for (j=[0:1]) {connector(type="h",con_length=drawer_length-2*plug_width,pos=[-drawer_length/2,j*3*plug_width+2*drawer_height+3*plug_width,0]);}
    for (j=[0:1]) {connector(type="h",con_length=drawer_width,pos=[-drawer_width/2,-j*3*plug_width-2*drawer_height+3*plug_width,0]);}
    for (j=[0:1]) {connector(type="v",con_length=drawer_length,con_height=drawer_height,pos=[0,j*(2*plug_width+drawer_height),0],rot=[0,0,90]);}
  }
  else if (Element=="Drawer1"){drawer(1);}
  else if (Element=="Drawer2") {drawer(2);}
  else if (Element=="Drawer4") {drawer(4);}
  else if (Element=="Left_Corner") {
    // preview[view:south, tilt:top]
    corner("l",[i*3*plug_width,0,0]);}
  else if (Element=="Right_Corner") {corner("r",[i*3*plug_width,0,0]);}
  else if (Element=="Left_Edge") {corner("le",[i*4*plug_width,0,0]);}
  else if (Element=="Right_Edge") {corner("re",[i*4*plug_width,0,0]);}
  else if (Element=="Horizontal_Plug_Length") {connector(type="h",con_length=drawer_length-2*plug_width,pos=[0,i*3*plug_width,0]);}
  else if (Element=="Horizontal_Plug_Width") {connector(type="h",con_length=drawer_width,pos=[0,i*3*plug_width,0]);}
  else if (Element=="Horizontal_Plug_Middle") {connector(type="m",con_length=drawer_length-2*plug_width,pos=[0,i*4*plug_width,0]);}
  else if (Element=="Vertical_Plug") {connector(type="v",con_length=drawer_length,con_height=drawer_height,pos=[i*(2*plug_width+drawer_height),0,0]);}
  else if (Element=="Vertical_Plug_Top") {connector(type="vt",con_length=drawer_length,con_height=drawer_height,pos=[i*(2*plug_width+drawer_height),0,0]);}
  else if (Element=="Vertical_Plug_Middle") {connector(type="vm",con_length=drawer_length,con_height=drawer_height,pos=[i*(2*plug_width+drawer_height),0,0]);}
  else if (Element=="Shelf") {shelf();}
}

module corner(type="l",pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) union() {
    if (type=="l" || type=="le" || type=="re") {
      if (type=="le") {
        hole("v",[0,0,0],[0,-90,0]);
        hole("o",[0,0,plug_width],[0,-90,0]);
      }
      else {
        hole("v",[0,0,0],[0,90,0]);
        hole("o",[0,0,plug_width],[0,90,0]);
      }
    }
    if (type=="r") {
      hole("o",[0,0,plug_width],[0,90,-90]);
      hole("v",[0,0,0],[0,90,-90]);
    }
    hole("h",[-plug_width,0,0]);
    hole("h",[0,plug_width,0],[0,0,-90]);
    if (type=="le" || type=="re") {
      hole("h",[plug_width,0,0],[0,0,180]);
    }
  }
}

module drawer(type=1,pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) union() {
    if (type==1 || type==2 || type==4) {
      //bottom
      cube([drawer_width-adjustment,drawer_length,drawer_thickness], center=true);
      // left wall
      translate([-drawer_width/2+drawer_thickness/2+adjustment/2,0,drawer_height/2-drawer_thickness/2])
        cube([drawer_thickness,drawer_length,drawer_height], center=true);
      // right wall
      translate([+drawer_width/2-drawer_thickness/2-adjustment/2,0,drawer_height/2-drawer_thickness/2])
        cube([drawer_thickness,drawer_length,drawer_height], center=true);
      // back wall
      translate([0,+drawer_length/2+drawer_thickness/2,drawer_height/2-drawer_thickness/2])
        cube([drawer_width-adjustment,drawer_thickness,drawer_height], center=true);
      // front wall
      translate([0,-drawer_length/2-drawer_thickness/2,drawer_height/2+plug_width/2-drawer_thickness/2])
        minkowski() {
          cube([drawer_width,drawer_thickness,drawer_height], center=true);
          rotate([90,0,0]) cylinder(r=cornerradius,h=drawer_thickness);
        }
      // handle
      translate([0,-drawer_length/2-drawer_thickness-3,drawer_height/2-drawer_thickness/2])
        cube([4,6,drawer_height], center=true);
      translate([0,-drawer_length/2-drawer_thickness-6,drawer_height/2-drawer_thickness/2])
        cylinder(d=6,h=drawer_height, center=true);
    }
    if (type==2 || type==4) {
      translate([0,0,drawer_height/2-drawer_thickness/2])
        cube([drawer_thickness,drawer_length,drawer_height], center=true);
    }
    if (type==4) {
      translate([0,0,drawer_height/2-drawer_thickness/2])
        cube([drawer_width-adjustment,drawer_thickness,drawer_height], center=true);
    }
  }
}

module connector(type="h",con_length=drawer_width,con_height=drawer_height,pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) union() {
    if (type=="h" || type=="m") {
      cube([con_length-2*plug_width,plug_width,plug_width], center=true);
      plug("h",[+con_length/2-plug_width/2,0,0]);
      plug("h",[-con_length/2+plug_width/2,0,0],[0,0,180]);
      ledge(con_length-2*plug_width,[0,-plug_width,0]);
      if (type=="m") {
        ledge(con_length-2*plug_width,[0,+plug_width,0],[0,0,180]);
      }
    }
    if(type=="v") {
      cube([con_height-plug_width,plug_width,plug_width], center=true);
      plug(type,[+con_height/2,0,0]);
      plug(type,[-con_height/2,0,0],[0,0,0]);
      translate([0,con_length-plug_width,0]) {
        cube([con_height-plug_width,plug_width,plug_width], center=true);
        plug(type,[+con_height/2,0,0]);
        plug(type,[-con_height/2,0,0],[0,0,0]);
      }
      translate([0,-plug_width/2,0]) ledge(con_length-2*plug_width+2*adjustment,[0,con_length/2,0],[0,0,90]);
    }
    if(type=="vt") {
      cube([con_height-plug_width,plug_width,plug_width], center=true);
      plug("v",[+con_height/2,0,0]);
      translate([0,con_length-plug_width,0]) {
        cube([con_height-plug_width,plug_width,plug_width], center=true);
        plug("v",[+con_height/2,0,0]);
      }
      translate([0,-plug_width/2,0]) ledge(con_length-2*plug_width+2*adjustment,[0,con_length/2,0],[0,0,90]);
    }
    if(type=="vm") {
      translate([0,plug_width,-plug_ledge/2]) cube([con_height-plug_width,plug_width,plug_width-plug_ledge], center=true);
      translate([0,con_length-2*plug_width,-plug_ledge/2]) cube([con_height-plug_width,plug_width,plug_width-plug_ledge], center=true);
      translate([0,-plug_width/2,0]) ledge(con_length-4*plug_width+2*adjustment,[0,con_length/2,0],[0,0,90]);
    }
    if(type=="t") {
      plug(type,[-con_length/2-plug_width/2,0,0],[0,0,180]);
      translate([0,drawer_length+3*plug_width,0]) {
        cube([con_length,plug_width,plug_width], center=true);
        plug("t",[-con_length/2-plug_width/2,0,0],[0,0,180]);
      }
      translate([0,plug_width*3/2,plug_width-plug_ledge]) ledge(drawer_length+2*plug_width+2*adjustment,[0,drawer_length/2,0],[0,0,90]);
    }
  }
}

module plug(type="h",pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) {
    if(type=="h") {
      translate([0,0,-3/8*plug_width])cube([plug_width,plug_width,plug_width/4], center=true);
      translate([plug_width/4,0,0])cube([plug_width/2,plug_width/3,plug_width/2], center=true);
    }
    if(type=="v") {
      translate([0,0,-plug_width/3])cube([plug_width,plug_width/3,plug_width/3], center=true);
      rotate([0,90,0]) cylinder(d=plug_width/2,h=plug_width, center=true);
    }
    if(type=="t") {
      translate([0,0,-plug_width/3])cube([plug_width,plug_width/3,plug_width/3], center=true);
      rotate([0,90,0]) cylinder(d=plug_width/2,h=plug_width, center=true);
    }
  }
}

module hole(type="h",pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) rotate(0,0,0) difference() {
    cube(plug_width,plug_width,plug_width,center=true);
    if(type=="h") {
      translate([0,0,3/8*plug_width])cube([plug_width+adjustment,plug_width+adjustment,plug_width/4+adjustment], center=true);
      translate([plug_width/4,0,0])cube([plug_width/2+adjustment,plug_width/3+adjustment,plug_width/2+adjustment], center=true);
    }
    if(type=="v") {
      translate([0,0,-plug_width/3-adjustment/2])cube([plug_width+adjustment,plug_width/3+adjustment,plug_width/3+adjustment], center=true);
      translate([-adjustment/2,0,0])rotate([0,90,0]) cylinder(d=plug_width/2+adjustment,h=plug_width+2*adjustment, center=true);
    }
    if(type=="o") {
      translate([0,0,-plug_width/3-adjustment/2])cube([plug_width+adjustment,plug_width/3+adjustment/2,plug_width], center=true);
      rotate([-adjustment/2,90,0]) cylinder(d=plug_width/2+adjustment/2,h=plug_width+2*adjustment, center=true);
    }
  }
}

module shelf(con_width=drawer_width,con_length=drawer_length,pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) difference() {
    cube([drawer_width+2*plug_width,drawer_length,drawer_thickness], center=true);
    translate([-drawer_width/2-plug_width/2,-drawer_length/2+plug_width/2,0]) cube([plug_width,plug_width,plug_width], center=true);
    translate([+drawer_width/2+plug_width/2,-drawer_length/2+plug_width/2,0]) cube([plug_width,plug_width,plug_width], center=true);
    translate([-drawer_width/2-plug_width/2,+drawer_length/2-plug_width/2,0]) cube([plug_width,plug_width,plug_width], center=true);
    translate([+drawer_width/2+plug_width/2,+drawer_length/2-plug_width/2,0]) cube([plug_width,plug_width,plug_width], center=true);
  }
}

module ledge(con_length,pos=[0,0,0],rot=[0,0,0]) {
  translate(pos) rotate(rot) translate([0,0,-plug_width/2+plug_ledge/2]) {
    cube([con_length-2*adjustment,plug_width,plug_ledge], center=true);
    translate([-adjustment,0,-plug_ledge/2]) linear_extrude(height=plug_ledge)
      polygon(points=[[+con_length/2,plug_width/2],[+con_length/2,-plug_width/2],[+con_length/2+plug_width,plug_width/2]]);
    translate([adjustment,0,-plug_ledge/2]) linear_extrude(height=plug_ledge)
      polygon(points=[[-con_length/2,plug_width/2],[-con_length/2,-plug_width/2],[-con_length/2-plug_width,plug_width/2]]);
  }
}
