tubeSize = 4.0; //4 mm external diam for 1.75mm filament
              //6 mm external diam for 3mm filament

modelSize = 6.0; //the original size
scale([tubeSize/modelSize, tubeSize/modelSize, tubeSize/modelSize]) {

difference() {
import("Feeder_V8.stl", convexity=3);

translate([5, -40, -40])
   cube([10,80,80]);
}
}


