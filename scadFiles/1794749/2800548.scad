part = "bubbler"; // [bubbler, lid]

// stem outside diameter
stemod = 11;

// stem length
steml = 35;

// body diameter
bubbled = 40;

// body length
bubbleh = 70;

// wall thickness
wall = 2;

// lid diameter
lidd = 35;

// lid length
lidl = 15;

stemid = stemod - 2*wall;

$fn=72;

module lid(d,h,w) {
   maxclearance = 1.2;
   minclearance = 0.5;
   difference() {
      cylinder(d2=d+2*w+maxclearance,d1=d+2*w+minclearance, h=h);
      translate([0,0,w]) union() {
         cylinder(d2=d+maxclearance,d1=d+minclearance,h=h);
         for(a = [0:60:359]) {
            rotate(a=[0,0,a]) translate([d*0.35,0,-w-0.1])
               cylinder(d=2.5,h=w*2);
         }
      }
   }
}

module body(d,h) {
   hull() {
      // stretching the bottom vertically gives a steeper slope on
      // most of the overhang, which should seal better.
      scale([1,1,1.2]) translate([0,0,d/2]) sphere(d=d);
      translate([0,0,h-d/2]) sphere(d=d);
   }
}

module bubbler() {
   difference() {
      union() {
         body(bubbled+2*wall,bubbleh+2*wall);
         
         translate([0,0,bubbleh-bubbled/2])
            cylinder(d=lidd,h=lidl+bubbled/2);
         
         // stem with a slightly tapered tip
         translate([-stemod/2,0,-steml+wall])
         hull() {
            cylinder(d=stemod,h=steml+bubbled/2-wall);
            translate([0,0,-wall]) cylinder(d=stemod-wall,h=0.1);
         }
      }
      union() {
         difference() {
            // we're basically doubling the thickness of the bottom... it
            // prints upside down and without support one wall is probably
            // not 100% liquid proof.
            translate([0,0,2*wall]) body(bubbled,bubbleh-wall);
            union() {
               translate([-wall/2,-bubbled/2,0])
                  cube([wall,bubbled,bubbleh+wall*2]);
               translate([-stemod/2,0,-steml])
                  cylinder(d=stemod,h=steml+bubbleh+wall);
            }
         }
         
         // top vent
         translate([0,0,bubbleh-bubbled/2+0.1])
         difference() {
            cylinder(d=lidd-2*wall,h=lidl+bubbled/2);
            translate([-lidd/2+wall,-lidd/2,0])
            hull() {
               translate([0,0,lidl+bubbled/2])
                  cube([0.1,lidd,0.1]);
               cube([lidd/2-wall/2,lidd,bubbled/2]);
            }
         }
         
         // stem to upper chamber port
         translate([-stemod/2,0,-steml-0.1])
            cylinder(d=stemid,h=steml+bubbleh+0.2);
         
         // upper port between stem and chamber
         translate([-stemod,0,bubbleh-3*wall])
            rotate([0,90,0]) cylinder(d=stemid,h=stemod/2);
         
         // lower ports between chambers
         translate([-wall*2,-stemod/2-stemid/2,stemod])
            rotate([0,90,0]) cylinder(d=stemid,h=stemid);
         translate([-wall*2,stemod/2+stemid/2,stemod])
            rotate([0,90,0]) cylinder(d=stemid,h=stemid);
            
         
         // cutout for dev purposes
         *translate([-bubbled,0,-steml+lidl/2]) 
            cube([bubbled*2,bubbled*2,bubbleh+steml]);
      }
   }
}

if( part == "lid" ) {
   lid(lidd,lidl,wall);
}
if( part == "bubbler" ) {
   bubbler();
}