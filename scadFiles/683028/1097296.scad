// Case to protect a deck of cards and tuck box containing them.

//mm
DeckHeight=91;
//mm
DeckWidth=65;
//mm
DeckThickness=17.5;
// inches.... nah, mm
WallThickness=2;
//This will ABSOLUTELY not look right in the preview but it comes out right in a full render.
DiamondPattern=0;//[0:No,1:Yes]

/* [Hidden] */

GripAngle=0;
MajorRadius=DeckHeight;
TagSize=DeckThickness;

P=DeckWidth/15;
P_Width=sqrt(2*pow(P+1,2));
P_Cols=(DeckWidth+WallThickness*2)/P_Width;
P_Rows=2*(DeckHeight+WallThickness*2)/P_Width+1;

tolerance=0.5;
$fn=20;

module star_5(radius=10){
 polygon(points=[
  from_polar(radius, 0),
  from_polar(radius, 72),
  from_polar(radius, 72*2),
  from_polar(radius, 72*3),
  from_polar(radius, 72*4)],
  paths=[[0,2,4,1,3]]);
}

function from_polar(r=1,theta=60) = [r*cos(theta),r*sin(theta)];

module CCTag(Size=10,Thickness=1, DoBorder=true, flush=false,center=false,$fn=10)
{
 Border = Size/30;
 BorderRadius=Size/10;
 ChevronWidth=Size/4;
 ChevronAngle=35;
 
 translate([0,0,flush?-Thickness:center?-Thickness/2:0])
  { 
   if ( DoBorder && Size >= 15 ) 
   { translate([0,0,Thickness/2]) 
    difference(){
     cube([Size,Size,Thickness],center=true);
     cube([Size-Border*2, Size-Border*2, Thickness*2],center=true); 
    }
   } 
   intersection(){
    union(){
     translate([0,-Size/3.5,0]) linear_extrude(height=Thickness) rotate([0,0,90]) star_5(radius=Size/6);
     translate([Size/3.5,Size/3.5,0]) linear_extrude(height=Thickness) rotate([0,0,90]) star_5(radius=Size/6);
     translate([-Size/3.5,Size/3.5,0]) linear_extrude(height=Thickness) rotate([0,0,90]) star_5(radius=Size/6);
     translate([0,ChevronWidth/1.0,0]){
      union(){
       rotate([0,0,-ChevronAngle]) translate([0,-ChevronWidth,0]) cube([Size,ChevronWidth,Thickness]);
       mirror([1,0,0]) rotate([0,0,-ChevronAngle]) translate([0,-ChevronWidth,0]) cube([Size,ChevronWidth,Thickness]);
       }
       }
      }
     cube([Size-Border*3,Size-Border*3, Thickness*2],center=true);
    }
   }
  }

%translate([-DeckWidth/2,-DeckThickness/2,WallThickness]) cube([DeckWidth,DeckThickness,DeckHeight]);

difference(){
// Card Box Wrap
 union(){
  for (j=[0:1])
   mirror([0,j,0])
    for (i=[0:1])
     mirror([i,0,0]){
      translate([DeckWidth/2+WallThickness/2,DeckThickness/2+WallThickness/2]) cylinder(r=WallThickness/2,h=DeckHeight+2*WallThickness);
      translate([DeckWidth/2,-DeckThickness/2,0]) cube([WallThickness,DeckThickness+WallThickness/2,DeckHeight+2*WallThickness]);
     }
  translate([-DeckWidth/2-WallThickness/2,DeckThickness/2,0]) cube([DeckWidth+WallThickness,WallThickness,DeckHeight+2*WallThickness]);

  // Front walls
  for (i=[0:1])
   mirror([i,0,0])
    translate([DeckWidth/2,-DeckThickness/2-WallThickness/2])
     rotate([0,0,-1*abs(GripAngle)])
      translate([-DeckWidth/2,DeckThickness/2+WallThickness/2])
       intersection(){
        translate([MajorRadius,-DeckThickness/2-WallThickness/2,DeckHeight/2+WallThickness])
         rotate([0,0,-1*abs(GripAngle)])
          translate([DeckThickness/2,0,0])
           rotate([90,45,0])
            rotate_extrude($fn=160)
             union(){
              translate([0,-WallThickness/2]) square([MajorRadius-WallThickness/2,WallThickness]);
              translate([MajorRadius-WallThickness/2,0]) circle(r=WallThickness/2);
             }

        translate([-DeckWidth/2-WallThickness/2,-DeckThickness/2-WallThickness,0]) cube([DeckWidth+WallThickness,WallThickness+DeckThickness,DeckHeight+2*WallThickness]);
       }
 }

 translate([DeckWidth/2+WallThickness,0,TagSize/2+WallThickness])rotate([90,0,90]) CCTag(Size=TagSize,Thickness=0.5, center=true);

if (DiamondPattern)
union(){
 for (k=[0:1]) mirror([0,k,0]){
  for (j = [0:P_Rows])
   for (i=[0:P_Cols])
    translate([P_Width*i-DeckWidth/2-WallThickness+(P_Width/2)*(j%2),DeckThickness/2+WallThickness,P_Width/2*j])
     rotate([0,45,0]) cube([P,0.5,P],center=true);
  }
 }
}



