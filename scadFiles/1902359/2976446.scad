//customizable ruler by Stu121
//Updated by DrLex


/* [General] */
RulerLength=10;//[1:50]
WithHole="yes";//[yes, no]
ReverseDesign="no";//[yes, no]
ShrinkageCompensationFactor=1.0;

/* [Text] */
RulerText="iRuler";
FontSize=10;
BoldFont="no";//[yes, no]
NarrowFont="no";//[yes, no]
TextHeight=1;//[-2.6:.1:5]
TextX=3;
TextY=18;

/* [Numbers] */
NumberSize=7;//[1:15]
BoldNumbers="no";//[yes, no]
NumberHeight=.5;//[-2.6:.1:5]
NumberOffset=2;//[0:.5:4]

/* [Ruler lines] */
CentimeterLineWidth=.5;//[.3:.05:.7]
MillimeterGapWidth=.3;//[.2:.05:.5]

/* [Hidden] */
Font= NarrowFont == "no" ? "Roboto" : "Roboto Condensed";
Font2="Roboto Condensed";
Hole=(WithHole == "yes");
Inverted=(ReverseDesign == "yes");
TextFont = BoldFont == "no" ? Font : str(Font, ":style=Bold");
NumberFont = BoldNumbers == "no" ? Font2 : str(Font2, ":style=Bold");

module numbers() {
    Thickness=abs(NumberHeight) + (NumberHeight < 0 ? 0.1 : 0);
    ZPos=NumberHeight >= 0 ? 2.5 : 2.5+NumberHeight;
    Rot=Inverted ? [0,0,180] : [0,0,0];
    RotCenter=[RulerLength*10/2+5,5.5+NumberSize/2,0];
    translate(RotCenter) rotate(Rot) {
        for (i=[1:1:RulerLength]) {
            NumberOffsetActual=(i > 9) ? NumberOffset-2.5 : NumberOffset;
            translate([(i*10)+NumberOffsetActual,5.5,ZPos]-RotCenter) linear_extrude(Thickness)  text(str(i),NumberSize,font=NumberFont,$fn=24);
        }
        translate([1,5.5,ZPos]-RotCenter) linear_extrude(Thickness)  text("CM",5,font=NumberFont,$fn=24);
    }
}

module label() {
    Thickness=abs(TextHeight) + (TextHeight < 0 ? 0.1 : 0);
    ZPos=TextHeight >= 0 ? 2.5 : 2.5+TextHeight;
    Rot=Inverted ? [0,0,180] : [0,0,0];
    RotCenter=[RulerLength*10/2+5,TextY-1.5+FontSize/2,0];
    translate(RotCenter) rotate(Rot) {
        translate([TextX,TextY,ZPos]-RotCenter) linear_extrude(Thickness)  text(RulerText,FontSize,font=TextFont,$fn=24);
    }
}


scale(ShrinkageCompensationFactor) difference() {
    union() {
        hull() {
            translate([0,5,0]) cube([(RulerLength*10)+10,25,2.5]);
            translate([0,-5,0])  cube([(RulerLength*10)+10,1,1]);
        }

        for (i=[0:10:RulerLength*10]) {  //centimeter lines
            translate([i+5-CentimeterLineWidth/2,-4.9,0.6]) rotate([8.5,0,0]) cube([CentimeterLineWidth,10,.7]);
        }
        
        if(NumberHeight > 0) {
            numbers();
        }
        if (TextHeight > 0) {
            label();
        }
    }

    for (i=[1:1:RulerLength*10]) {  //millimeter lines. These are recessed to improve printability with thicker nozzles.
        if(i % 10) {
            GapLength=(i % 5) ? 5 : 6.5;
            translate([i+5-MillimeterGapWidth/2,-4.95,0.5]) rotate([8.5,0,0]) cube([MillimeterGapWidth,GapLength,.7]);
        }
    }
    if (TextHeight < 0) {
        label();
    }
    if(NumberHeight < 0) {
        numbers();
    }
    if (Hole) {
        HoleX = Inverted ? 10 : RulerLength*10;
        translate([HoleX,18,2])  cylinder(10, 2.5, 2.5, true);
    }
}
