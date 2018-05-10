$fn = 32;
c = 0.55;


module fillet(r, h) {
  translate([r / 2, r / 2, 0])

  difference() {
    cube([r + 0.01, r + 0.01, h], center = true);

    translate([r/2, r/2, 0])
    cylinder(r = r, h = h + 1, center = true);

  }
}

module torus(cirlceRadius = 2, cutRadius = 1){
  rotate_extrude() translate([cirlceRadius,0])circle(cutRadius);
}


module base(){
  difference(){
    union(){
      difference(){
        cylinder(h=21.5, r = 79.6/2);
        translate([0,0,-0.1])cylinder(h = 20.6, r = 77.6/2);
        translate([-40,0,21.5/2])rotate(90,[0,1,0])cylinder(h=80,r= 3);
        translate([0,79.6/2,21.5/2])rotate(90,[1,0,0])cylinder(h= 10,r=5);
      }
      translate([0,0,21.5])cylinder(r = 28.2/2, h = 20);
    }
    translate([0,0,20])cylinder(r = 25/2, h = 20);
    translate([0,-(28.2/2-4),21.5+20-5])cylinder(r = 1.5, h = 10);
  }
}

module wireCone(){
  cylinder(h = 13,r1 = 11/2, r2 = 9.5/2);
}

module wire(){
  intersection(){
    translate([0,-100,-9])cube([100,100,18]);
    torus(75,9/2);
  }
  translate([-13,-75,0])rotate(180,[1,0,1])wireCone();
  translate([75,13,0])rotate(90,[1,0,0])wireCone();
}

module glass(){
  difference(){
    intersection(){
      scale([1,1,71.45/(79.25/2)])sphere(79.25/2);
      translate([0,0,40])cube([80,80,80],center = true);
      translate([0,0,30])cube([80,80,70],center = true);
    }
    scale(0.95)scale([1,1,71.45/(79.25/2)])sphere(79.25/2);
  }
}

module prong(){
  union(){
    cylinder(r=1,h=5);
    translate([0,0,5])cylinder(r=1.5,h=0.5);
  }
}

module bulb(){
  color([1,1,1,0.8])difference(){
    scale([1,1,1.3])difference(){
      sphere(46/2);
      translate([0,0,-46/2])cube(46,center=true);
    }
    translate([0,0,-0.1])scale(0.9)scale([1,1,1.3])difference(){
      sphere(46/2);
      translate([0,0,-46/2])cube(46,center=true);
    }
  }
  color([1,1,1,0.8])cylinder(h=2,r=49/2);
  translate([0,0,20])cylinder(h=16,r=8);
  translate([0,3,35])prong();
  translate([0,-3,35])prong();

  translate([0,0,15])scale([0.6,1,1.5])sphere(5);

}


module head(){

  color([c,c,c])cylinder(r= 30/2, h = 32);
  color([c,c,c])difference(){
    translate([0,0,32])scale([1,1,(1/30)*10])sphere(r=30/2);
    translate([0,0,40])cube([30,30,10], center= true);
  }
  color([c,c,c])translate([0,0,35])cylinder(r=6/2,h=40);
  color([1,1,1,0.9])translate([0,0,-65])glass();

  color([c,c,c])difference(){
    translate([-15+6,0,10])rotate(90,[0,-1,0])cylinder(r=15/2, h= 6+6);
    translate([-15-3,0,10])cylinder(r = 1.5, h = 10);
  }
  translate([0,0,-38])bulb();
}


module lamp(){
  color([c,c,c])base();
  color([c,c,c])translate([0,-(21.5/2)-13,75+21.5+20.6/2])rotate(90,[0,1,0])wire();
  translate([0,9-(21.5/2)-12-75,140.8])rotate(90,[0,0,-1])rotate(180,[1,0,1])head();
}

rotate(-90,[1,0,0])lamp();
//lamp();
