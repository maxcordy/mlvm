// mathgrrl function bracelet - TRI MODEL

/////////////////////////////////////////////////////////
// resolution parameters

$fn = 24*1;
step = .25*1;  // smaller means finer

// Thickness, in mm (recommend between .2 and .8)
th = .4;

/////////////////////////////////////////////////////////
// size parameters

// Diameter of the bracelet, in mm (should exceed the wide diameter of your wrist so that you can get the bracelet over your hand)
diameter = 60; 

radius = diameter/2;

// Height of the bracelet, in mm (along your wrist)
height = 20;

// Amplitude of the wave, in mm (suggest between 4 and 8, with higher numbers being more flash but less practical; higher amplitude can allow smaller diameters)
amplitude = 4; 

/////////////////////////////////////////////////////////
// define the wrapped wave function

function g(t) =  
   [ (radius+amplitude*(1+sin(3*t)))*cos(t),
     (radius+amplitude*(1+sin(3*t)))*sin(t),
     0
   ];

/////////////////////////////////////////////////////////
// renders

// the bracelet
linear_extrude(height=height,twist=30,slices=height/.4)
 function_trace(rad=th, step=step, end=360);

/////////////////////////////////////////////////////////
// module for tracing out a function

module function_trace(rad, step, end) {
 for (t=[0: step: end+step]) {
  hull() {
   translate(g(t)) circle(rad);
   translate(g(t+step)) circle(rad);
       }
   }
};