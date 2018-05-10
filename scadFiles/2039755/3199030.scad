///////////////////////////////////////////////////////////////////////////////
///
///  In-Circuit Analyzing & Programming Clip for DIP ICs
///
///  This file generates a contact clip for in-circuit analyzing and
///  programming of standard DIP ICs with 0.1" pin spacing.
///
///  The pin contacts are made from standard pin headers. The bridge in the clip
///  tweezers provides a spring to firmly clamp the contacts to the IC.  Small
///  gaps between the pins allow each pin contact to move individually, so that
///  the contact force is spread to all pins evenly.   The lead wires are fed
///  from the inner rear of the clip through three holes to the outer front of
///  the clip where they are soldered to the contacts headers.
///
///  For printing, ABS is preferred in order for the plastic to provide the
///  necessary elasticity.  To allow printing despite of the --in printing
///  position horizontal-- gaps between the pin arms, explicit supports are
///  generated (drawn in red) which need to be cut away with a razor blade or a
///  narrow knife.  As the arms should move freely agains each other, sometimes 
///  it is necessary to "clean" the gaps with thin sandpaper.
///
///  STL files for the standard 8-, 14-, 16-, 20- and 28-pin narrow DIP ICs 
///  as well as for 28- and 40-pin wide DIP ICs are provided.  Other sizes
///  can be easily obtained by modifying the fully parametrized SCAD file.
///
///////////////////////////////////////////////////////////////////////////////
///
///  2015-03-04 Heinz Spiess, Switzerland
///  2017-01-15 Juergen Weigert (ESP8622 variants added, Makefile added)
///
///  released under the following licence:
///  Creative Commons - Attribution - Share Alike licence (CC BY-SA)
///////////////////////////////////////////////////////////////////////////////

eh=0.252;          // extrusion height
ew=0.56;           // extrusion width

// construct an incircuit contact clip for dual-inline-pins ICs
module dipclip(
   pins = 8,       // number of pins
   pdist = 2.54,   // pin distance
   width = 1,      // forcefree opening with of clamp
   wire = 1.2,     // lead wire diameter (redrill with 1.3mm)
   contact = 0.8,  // pin contact diameter (redrill with 0.8mm)
   length = 60,    // lever length
   wall = 6*ew,    // wall thickness
   angle = 24,     // opening angle between levers
   pivd = 2.5,     // thickness of pivoting spring
   pivl = 0.66,    // location of pivoting spring
   clip = 5.7,     // clip length
   gap = 2*eh,      // gap in plastic for free moving pins
   eps = 0,        // small increase in x/y size for support generation
   withgaps = true // generate gaps between pins
){
   na = 8;         // number of steps for sping bridge
   height = pins/2*pdist;  // total height of clip

   // local module to construct one lever
   module lever(){

      difference(){
         
         // main body
         union(){
	    // tail of lever
            translate([clip,-eps,0])cube([length-clip,wall+2*eps,height]);
	    // clip part of lever
	    hull(){
               translate([-eps,-eps,0])cube([clip+2*eps,wall*0.6+2*eps,height]);
               translate([clip-eps,-eps,0])cube([0.1+2*eps,wall+2+2*eps,height]);
            }
	    // springy bridge between levers
            for(n = [0:na-1])
	       hull()for(i=[0,1])assign(a=(n+i)*angle/2/na)rotate(-a)
                  translate([length*pivl-wall*pow((angle-2*a)/angle,2),(n+i==na)?-width/2-0.1:0,0])
	             cube([2*wall*pow((angle-2*a)/angle,3)+pivd,0.1,height]);
         }

         // pin related cavities
	 if(withgaps)gaps();  // gaps between pins to allow free movement of each contact
	 for(pin=[1:pins/2])
	     translate([-0.1,0,height/2-(pin-pins/4)*pdist+gap/2]){

		    // pin contact holes
		    rotate(angle)translate([-1,0.7,pdist/2-gap/2])
		       rotate([0,90,0])rotate(45){
		          %color("grey")cylinder(r=contact/2,h=11,$fn=4);
		          cylinder(r=contact/2,h=3*wall,$fn=4);
                       }

		    // front wire holes
		    translate([2*clip+1,-wall,pdist/2-gap/2])
		       rotate(120)rotate([0,90,0])rotate(45)
		          cylinder(r=wire/2,h=3*wall,$fn=4);

		    // middle wire holes
		    translate([length*pivl-2*wall,-wall,pdist/2-gap/2])
		       rotate(60)rotate([0,90,0])rotate(45)
		          cylinder(r=wire/2,h=wall*5,$fn=4);

		    // rear wire holes
		    translate([length*pivl+2.5*wall,-wall,pdist/2-gap/2])
		       rotate(120)rotate([0,90,0])
		          rotate(45)cylinder(r=wire/2,h=wall*5,$fn=4);
	     } 
      }

   }

   // local module to cut gaps between pins
   module gaps(lift=0){
      for(pin=[1:pins/2-1])
         translate([-0.1,-wall,height/2-(pin-pins/4)*pdist+gap/2+lift]){
	    translate([-1,0,-gap])cube([length/3+1,3*wall+0.2,gap-lift]);
         }
   }

   // local module to generate supports for printing gaps
   module supports(supw=1.2*ew){
       intersection(){
          lever(withgaps=false,eps=0.2);
	  gaps(lift=eh);
          for(x=[-0.1,supw,clip-supw,clip-2*supw,0.15*length,0.21*length,0.27*length])
	     translate([x,-1,-1])cube([supw,2*wall+0.2,height+2]);
       }

   }

   // assemble left and right levers to complete clip
   for(sy=[1,-1])
      scale([1,sy,1])
         translate([0,width/2,0])
	    rotate(angle/2){
	       color("red")supports();
	       lever(withgaps=true);
            }
  

}

module DipClip8() // AUTO_MAKE_STL
{
     dipclip(pins=8);
}

module DipClip14() // AUTO_MAKE_STL
{
     dipclip(pins=14);
}


module DipClip16() // AUTO_MAKE_STL
{
     dipclip(pins=16);
}


module DipClip20() // AUTO_MAKE_STL
{
     dipclip(pins=20);
}

module DipClip28() // AUTO_MAKE_STL
{
     dipclip(pins=28);
}

module DipClip28W() // AUTO_MAKE_STL
{
     dipclip(pins=28,width=8,pivd=3.5);
}

module DipClip40W() // AUTO_MAKE_STL
{
     dipclip(pins=40,width=8,pivd=3.5);
}


module DipClipESP8266_02() // AUTO_MAKE_STL
{
    dipclip(pins=8, pdist=2.54,
        width=14.2-5,
        length=72, pivd=2.0, pivl=0.6);
}

module DipClipESP8266_03() // AUTO_MAKE_STL
{
    dipclip(pins=14, pdist=2.0,
        gap=2*0.4, wall=8*ew, width=12.2-5,
        length=72, pivd=2.0, pivl=0.6);
}

module DipClipESP8266_07() // AUTO_MAKE_STL
{
    dipclip(pins=16, pdist=2.0, 
        gap=2*0.4, wall=8*ew, width=16.0-5,
        length=72, pivd=2.0, pivl=0.6);
}



// dipclip();
DipClipESP8266_07();
