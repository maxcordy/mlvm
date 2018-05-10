part = "all"; // [all, clip, loop]

handled = 35;  // diameter (width) of the tool grip
handlel = 52;   // length of the tool grip
boltd = 5;  // diameter of the through bolt
nutd = 10;  // diameter of the nut
nuth = 3.5; // thickness of the nut

loopt = 4;  // thickness of the loop/clip

handleoff = 10;   // horz offset from handle
handlea = 40;     // angle offset towards battery

cliph = 20; // width of the clip body
clipl = 40; // length of the belt clip section
clearance = 1.5;  // between the clip part and the handle loop

bits = 5;         // number of bit holders in the clip
bittight = 0.98;  // bit holder scaling/tightness factor

//---------------------------------------------------
looph = nutd+3;
clipw = looph; // width of the clip barrel
barrell = cliph+max(loopt*2,nuth*4)+clearance;
ho = handleoff + ((bits>0) ? 10 : 0);

$fn=72;

module loop(w) {
   d = handled+w*2;
   h = looph;
   tx = (handlel-handled)/2;
   hull() {
      translate([-tx,0,0]) cylinder(d=d,h=h + (w?0:1));
      translate([tx,0,0]) cylinder(d=d,h=h + (w?0:1));
   }
}

module bitholder() {
   w = 2.5;
   k = 7.8+w;
   difference() {
      hull() {
         translate([-(k*.9)/2,k/2,0]) cube([k*0.9,0.1,cliph]);
         rotate([0,0,30]) cylinder(d=k, h=cliph, $fn=6);
      }
      union() {
         // this needs to be slightly tight
         rotate([0,0,30]) cylinder(d=7.8*bittight, h=cliph+0.1, $fn=6);
         
         translate([-1,-7.8,-0.05])
            cube([2,7.8,cliph+0.1]);
      }
   }
}

module clip() {
   
   translate([clipl-loopt+.95,loopt/2-0.58,0])
   rotate([0,0,handlea])
   translate([0,-ho-clipw/2,0])
   difference() {
      union() {
         rotate([0,-90,-handlea]) intersection() {
            translate([barrell/2,0,0]) barrel();
            rotate([0,90,0]) cylinder(d=looph*2,h=cliph);
         }
         cube([loopt,ho+clipw/2,cliph]);
      }
      translate([0,0,-1]) cylinder(d=boltd,h=cliph*2);
   }
   
   union() {
      if( bits > 0 ) {
         for(i=[1:bits]) {
            translate([clipl-8.4*i+7.8/2,-loopt, 0]) bitholder();
         }
      }
      cube([clipl,loopt,cliph]);
      translate([0,clipw/2,0]) difference() {
         cylinder(d=looph,h=cliph);
         hull() {
            cylinder(d=clipw-loopt*2,h=cliph);
            translate([clipw/2,-(clipw-loopt*2)/2,0])
               cube([0.1,clipw-loopt*2,cliph]);
         }
      }
      hull() {
         translate([0,clipw-loopt,0]) cube([0.1,loopt,cliph]);
         translate([clipl,clipw-loopt*1.5,0])
            cube([0.1,loopt,cliph]);
      }
      hull() {
         intersection() {
            translate([clipl,loopt,0])
               cube([clipl,clipw,cliph]);
            union() {
               translate([clipl,clipw-loopt*1.5,0])
                  cube([0.1,loopt,cliph]);

               l = loopt*1.25;
               translate([clipl*1.25+l/2,clipw-loopt/2,cliph/2])
                  rotate([0,-15,25]) cylinder(d=l,h=cliph/2*1.5);
               translate([clipl*1.25+l/2,clipw-loopt/2,cliph/2])
                  mirror([0,0,1])
                  rotate([0,-15,25]) cylinder(d=l,h=cliph/2*1.5);
            }
         }
      }
   }
}

module barrel() {
   translate([-barrell/2,0,0])
   hull() {
      rotate([0,90,0]) cylinder(d=looph,h=barrell*.95);
      translate([-handled*.025,-boltd-loopt,-looph/2])
         cube([barrell,0.05,looph]);
   }
}

module body() {
   difference() {
      hull() {
         loop(loopt);
         translate([0,handled/2+loopt+boltd,looph/2]) barrel();
      }
      union() {
         translate([0,0,-0.01]) loop(0);

         sp = cliph+clearance+loopt*2;
         xo = handlel-handled;
         translate([-sp/2,handled/2+loopt+boltd,looph/2])
            rotate([0,90,0]) 
         union() {
            cylinder(d=boltd,h=sp);
            translate([0,0,-handlel+0.1])
               cylinder(d=nutd,h=handlel,$fn=6);
            translate([0,0,sp-0.1])
               cylinder(d=nutd,h=handlel);
         }
         
         translate([-cliph/2,0,-0.01])
            cube([cliph+clearance,handled,looph+1]);
      }
   }
}

if( part == "loop" ) {
  body();
} else if( part == "clip" ) {
   translate([0,50,0]) clip();
} else if( part == "all" ) {
   %body();
   translate([(clearance-cliph)/2,ho+handled/2+10,clipl+looph])
      rotate([0,90,0]) clip();
}