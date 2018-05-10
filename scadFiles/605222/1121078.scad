/*[[Parameters]]*/
//knob height
KnobHeight = 6;
//Number of rimpels of the Knob
NumberOfSides=24;
//Radius of the knob
radius=25;
//rimple from 0.5 to ......
rimple=0.6; 
//Height of the axel
heightAxel = 24;
//Outer diameter of Axel
OuterDiameter = 14;
//Inner diameter of axel
InnerDiameter = 8;


/*[[Extra Nut settings]]*/
InsertExtraNut = 0;
//Nut Diameter
NutDiameter = 13;
//NutHeight
NutHeight = 4.6;



$fn=72;
Cr =radius*sin(180/NumberOfSides);
offset= sqrt(pow(radius,2)-pow(Cr,2));

echo(Cr);
echo(offset);

module oval()
{
    scale([rimple,1,1])
    circle(r=Cr);
}

module knob()
{
linear_extrude(height=KnobHeight)
difference(){
    union(){
        circle(r=radius,$fn=NumberOfSides);
        for(a=[0:360/NumberOfSides*2:360])
        {
            rotate(a,0,0)translate([offset,0,0])oval();
        }
    }
    for(a=[360/NumberOfSides:360/NumberOfSides*2:360])
    {
       rotate(a,0,0)translate([offset,0,0])oval();
    }
}
}

module Main(){
    render(10)
    difference(){
        union(){
        knob();
        cylinder(r=OuterDiameter,h=heightAxel);
        };
        cylinder(r=InnerDiameter,h=heightAxel);
        if (InsertExtraNut==1){
        translate([0,InnerDiameter+1.25,heightAxel-5.4])NutInMaterial();
        mirror([0,1,0])
        translate([0,InnerDiameter+1.25,heightAxel-5.4])NutInMaterial();
        }
        difference(){
            cylinder(r=NutDiameter, h=NutHeight, $fn=6);
            cylinder(r=InnerDiameter+0.5,h=NutHeight);
        
    }
    };
    
}

module NutInMaterial()
{
  rotate([-90,0,0])
    union(){
    cylinder(r=2.7,h=2.3,$fn=6, center=true);  
    translate([0,-3.2,0])cube([5.4,6.4,2.3],center=true);
    translate([0,0,-2.7])cylinder(r=1.65, h=10, $fn=24);
    }
}

//NutInMaterial();
Main();

