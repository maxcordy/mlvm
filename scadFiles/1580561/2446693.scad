/***********************************************************************
Name ......... : screwJack.scad
Description....: Parametric Screw Jack
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/05/21
Licence ...... : GPL
***********************************************************************/

//Part Display Options 
part = 0; //[0:All, 1:Base, 2: Jack Top, 3: Nut, 4: Bolt]


//Settings for Jack Base
//Diameter of Jack Base
baseDiameter = 50;
//Total Height of Jack Base
baseTotalHeight = 50;
//Height of Jack base Taper
baseTaperHeight = 25;
//Base taper ratio of total base height
baseTaper = 0.5;

//Settings for Jack Top
//Diameter of Jack Top
jackTopDiameter = 20;
//Height of Jack Top
jackTopHeight = 30;
//Jack Top Option
jackTopOption = 1; //[0:Flat Jack Top, 1: Swivel Top]
swivelClearance = 1;

//Number of knurls around Knob Diameter
boltKnobKnurlNum = 20;
//Depth of knurls
boltKnobKnurlDepth = 1.5;
//Width of knurls
boltKnobKnurlWidth = 1.5;
//Angle of knurling
boltKnobKnurlAngle = 120;

//Screw Hole Scaling Factor-overside base hole to allow screw clearance
boltHoleScale = 1.1;
//Dimensions of Nut and Bolt
//Diameter of bolt
boltDiameter = 8.25;
boltLength = baseTotalHeight;
echo("required bolt length:",baseTotalHeight);

//Width of nut- measure corner to corner distance on nut
nutWidth = 14.75;
//Nut thickness- measure thickness of nut
nutThickness = 7.0;

//****************************************************************************** 
//Base of the Screw Jack 
//******************************************************************************
module screwJackBase()
{
    difference(){
    translate([0,0,baseTaperHeight*0.5]){
    union(){
    cylinder(r1 = baseDiameter*0.5, r2=baseDiameter*0.5*baseTaper, h = baseTaperHeight, center = true);
    translate([0,0,baseTaperHeight]){
    cylinder(r = baseDiameter*0.5*baseTaper, h = baseTotalHeight - baseTaperHeight, center = true);
    }
    }
    }
    translate([0,0,baseTotalHeight-nutThickness*0.5]){
        
        cylinder(r=nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    }
    
    translate([0,0,baseTotalHeight*0.5]){
    cylinder(r = boltDiameter*0.5*boltHoleScale, h = baseTotalHeight, center = true);
    }
    }
    
}

//****************************************************************************** 
//Jack Top- two options: 0-no swivel top 1: swivel top 
//******************************************************************************

module jackTop()
{
    if (jackTopOption ==0)
    {
    difference(){
    cylinder(r = jackTopDiameter*0.5, h = jackTopHeight, center = false);
    
    cylinder(r=nutWidth*0.5, h = nutThickness, center = false, $fn=6);
        
     for (i = [1:1:boltKnobKnurlNum]){   
    //add knurling to jack top   
    rotate([0,0,360*i/boltKnobKnurlNum])
    {
        
        linear_extrude(height = jackTopHeight*2, center = true, twist = boltKnobKnurlAngle){
            translate([jackTopDiameter*0.5, 0,0]){
        square(size = [boltKnobKnurlDepth,boltKnobKnurlWidth], center = true);
            }
        }
        
        linear_extrude(height = jackTopHeight*2, center = true, twist = -boltKnobKnurlAngle){
            translate([jackTopDiameter*0.5, 0,0]){
        square(size = [boltKnobKnurlDepth,boltKnobKnurlWidth], center = true);
            }
        }
    } 
    }
        
    }
    }
    if (jackTopOption == 1){
        difference(){
    cylinder(r = jackTopDiameter*0.5, h = jackTopHeight*0.5, center = false);
    
    cylinder(r=nutWidth*0.5, h = nutThickness, center = false, $fn=6);
    //add knurling to jack top    
     for (i = [1:1:boltKnobKnurlNum]){   
        
    rotate([0,0,360*i/boltKnobKnurlNum])
    {
        
        linear_extrude(height = jackTopHeight*2, center = true, twist = boltKnobKnurlAngle){
            translate([jackTopDiameter*0.5, 0,0]){
        square(size = [boltKnobKnurlDepth,boltKnobKnurlWidth], center = true);
            }
        }
        
        linear_extrude(height = jackTopHeight*2, center = true, twist = -boltKnobKnurlAngle){
            translate([jackTopDiameter*0.5, 0,0]){
        square(size = [boltKnobKnurlDepth,boltKnobKnurlWidth], center = true);
            }
        }
    } 
    }
        
    }
    
    translate([0,0,jackTopHeight*0.5+jackTopDiameter*0.4*0.6])
    {
    sphere(r = jackTopDiameter*0.4);
    }
          
    translate([0,0,jackTopHeight*0.5 + swivelClearance]){
    %difference(){
    cylinder(r = jackTopDiameter*0.5, h = jackTopHeight*0.5, center = false);
    translate([0,0,jackTopDiameter*0.45*0.5])
        {
    sphere(r = jackTopDiameter*0.45); 
    }
    }   
    }
    
    }
    
    
}

//****************************************************************************** 
//Nut 
//*********************************************************************************
module nut()
{
    difference(){
    cylinder(r=nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    
    cylinder(r = boltDiameter*0.5, h=nutThickness, center = true);
    }
    
}

//****************************************************************************** 
//Bolt 
//********************************************************************************
module bolt()
{
    
    cylinder(r=boltDiameter*0.5, h = boltLength, center = true);
    
    translate([0,0,boltLength*0.5]){
    cylinder(r=nutWidth*0.5, h = nutThickness, center = true, $fn=6);
    }
    
}

//*******************************************************************************
//Rendering and Display of Parts
//********************************************************************************
$fn = 60;
if (part == 0)
{
//Display screw jack base
screwJackBase();
    

//Display Nut
translate([0,0,baseTotalHeight-nutThickness*0.5]){
color("red")
nut();
}

//Display Bolt
translate([0,0,baseTotalHeight]){
color("blue")
bolt();
}

//Jack Top
translate([0,0,baseTotalHeight+boltLength*0.5-nutThickness*0.5]){
color("green")
jackTop();
}
}

if (part == 1)
{
//Display screw jack base
screwJackBase();
    
}

if (part == 2)
{
    //Display Jack Top
    jackTop();

    
}

if (part == 3)
{
    //Display screw jack base
    nut();
    
}

if (part == 4)
{
    //Display bolt
    bolt();
    
}