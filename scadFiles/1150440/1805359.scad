
//LABELS FOR CUSTOMIZER

// Adjust parameters here:
Closing_Gap = "smooth"; //[full,smooth]
//Closing_Gap = "full"; //[full,smooth]

squeeze_diameter = 3; //[2:4]
squeeze_position = 29; //[25:32]

/*[Material]*/
tube_diameter = 6.5;

/*[Hidden]*/
clamp_height = tube_diameter * 1.8;
 
difference(){

 color("deeppink") translate([-0, -0, 0]) 
 linear_extrude(center = false, height = clamp_height, convexity = 10) import (file = "tube_clamp_frame.dxf");    
    
    translate([-2,8,clamp_height/2]) rotate([0,90,0]) cylinder(h=10,r=tube_diameter/2, $fn = 60);  
    translate([35,8,clamp_height/2]) rotate([0,90,0]) cylinder(h=10,r=tube_diameter/2, $fn = 60);  
    
    }
 
if(Closing_Gap=="full")
{
  color("pink") translate([squeeze_position+1,13,0]) rotate([0,0,0]) 
    cylinder(h=clamp_height,r=squeeze_diameter, $fn = 60); 
  color("pink") translate([squeeze_position,3,0]) rotate([0,0,0]) 
    cylinder(h=clamp_height,r=squeeze_diameter, $fn = 60); 
}  
 
if(Closing_Gap=="smooth")
{
  difference(){
  color("pink") translate([squeeze_position,3.8,0]) rotate([0,0,0]) scale([2,0.8,1])
    cylinder(h=clamp_height,r=squeeze_diameter*1.5, $fn = 60);    
      
  color("pink") translate([squeeze_position,10.5,-1]) rotate([0,0,0]) 
    cylinder(h=clamp_height+2,r=squeeze_diameter*2, $fn = 60);      
  }
   
  color("pink") translate([squeeze_position+1,13,0]) rotate([0,0,0]) 
    cylinder(h=clamp_height,r=squeeze_diameter, $fn = 60);  
}  

  /*
  color("pink") translate([squeeze_position-2,3,0]) rotate([0,0,0]) 
    cylinder(h=clamp_height,r=squeeze_diameter, $fn = 60);  
  color("pink") translate([squeeze_position+2,3,0]) rotate([0,0,0]) 
    cylinder(h=clamp_height,r=squeeze_diameter, $fn = 60);  
    */
  

    
 

    
