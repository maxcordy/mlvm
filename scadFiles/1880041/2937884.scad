/* Scan of Ball holding statue (Atlas), scanned in framework of  of the Scan the world.
// Source: //https://www.myminifactory.com/object/atlas-at-arcevia-italy-17047
// Artist:  Bruno D'Arcevia

Edited by Mixomycetes, in 3 steps:
1: Opened File in Meshlab to lower polygon count (300k to 50k to 5k)
2. Removed the ball & parameterized scale to desired ball size by using a diff.
3. rescale to wanted size
// uploaded as customizer, as rendering takes AGES! */

//Rescales statue to fit a ball of this size (mm)
Wanted_ball_diameter = 50; //[10:1000]

$fn=30;
STL_ball_diameter = 61.0; // with high FN, diameter is 61 mm.
STL_ball_position = [45.1,29.1,100.5];

rescaling_factor = Wanted_ball_diameter/STL_ball_diameter;

// simple rescale and diff.
scale(rescaling_factor){ 
    difference(){
    union(){
import("Atlas_Original_WITH_bal_50kfaces.stl", convexity=6);
		//Atlas_Original_WITH_bal_50kfaces
        //Atlas_Original_WITH_bal_5kfaces
        //Atlas_Original_WITH_ball_Fixed is original size (30Mb, fails on my PC)
        };
translate(STL_ball_position)sphere(d=STL_ball_diameter);// source:
}; 
}


// original size.
original_size = [89.4, 72.6, 156];
// (approximated) new object size:
new_size_w_ball = original_size*rescaling_factor; //w/o the ball, but hands are a bit above half.
approx_size_without_ball = original_size*rescaling_factor-[1,1,1]*4/5*STL_ball_diameter; //w/o the ball, but hands are a bit above half.

echo("Approximate size of customized statue (in mm):");
echo(approx_size_without_ball); //mm

