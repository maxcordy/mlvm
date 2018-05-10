// Customizable MakeItFloat 1.0 by CD PUCK3D, July 2015
// is licensed under the Creative Commons - Attribution - Non Commercial license. 
// please refer the complete license here: http://creativecommons.org/licenses/by-nc/3.0/legalcode

//preview[view:south east, tilt:top diagonal]

/*[General]*/
//Only to show
part=2;//[0:Float,1:Cover,2:Section (only to show)]
//Shell Thickness, in mm
Shell_Thickness=0.9;//[0.5:0.1:3]
//Fluid Density, in gr/cm3
Fluid_Density=1;
//Fialment Density, in gr/cm3
Filament_Density=1.24;

/*[Print Area]*/
//Set Plate Shape (N.B. Circular in under construction...)
Print_Bed=0;//[0:Rectangular,1:Circular]
//If rectangular set Print Area X, in mm
Print_Area_X=250;
//If rectangular set Print Area Y, in mm
Print_Area_Y=200;
//If circular set Print Diameter, in mm
Print_Diameter=200;
//Set Print Area Z, in mm
Print_Area_Z=150;

/*[Coin]*/
//choice a coin
Coin_Type="2€";//[1c:1 Cent Euro,2c:2 Cent Euro,5c:5 Cent Euro,10c:10 Cent Euro,20c:20 Cent Euro,50c:50 Cent Euro,1€:1 Euro,2€:2 Euro,"":Other]
//need for type=Other (eg: $1)
Coin_Value_Custom="";
//need for type=Other, in mm
Coin_Diameter_Custom=0;
//need for type=Other, in mm
Coin_Height_Custom=0;
//need for type=Other, in gr
Coin_Weight_Custom=0;

/*[Float]*/
//Coin Stand
Float_Stand=1;//[0:No,1:Yes]
//Float Cover
Float_Cover=1;//[0:No,1:Yes]

/*[Hidden]*/
$fn=150;
Gap_Vertical=0.1;//between coin and coin, in mm
Gap_Horizontal=0.5;//between coins and float, in mm
Cover_Gap=0.1;//inside joint cover, in mm
Cover_Height=10;//Cover Height, in mm
Text_Size=(Print_Area_X>Print_Area_Y?Print_Area_X>Print_Area_Z?Print_Area_X:Print_Area_Z:Print_Area_Y>Print_Area_Z?Print_Area_Y:Print_Area_Z)/10;// 1/10 of max dimension

// ====================================================================================================
// settaggio delle caratteristiche della singola moneta
 Coin_Value=Coin_Type!=""?Coin_Type:Coin_Value_Custom;
 Coin_Diameter=Coin_Type=="1c"?16.25:Coin_Type=="2c"?18.75:Coin_Type=="5c"?21.25:Coin_Type=="10c"?19.75:Coin_Type=="20c"?22.25:Coin_Type=="50c"?24.25:Coin_Type=="1€"?23.25: Coin_Type=="2€"?25.75:Coin_Diameter_Custom;
 Coin_Height=Coin_Type=="1c"?1.67:Coin_Type=="2c"?1.67:Coin_Type=="5c"?1.67:Coin_Type=="10c"?1.93:Coin_Type=="20c"?2.14:Coin_Type=="50c"?2.38:Coin_Type=="1€"?2.33:Coin_Type=="2€"?2.20:Coin_Height_Custom;
 Coin_Weight=Coin_Type=="1c"?2.30:Coin_Type=="2c"?3.06:Coin_Type=="5c"?3.92:Coin_Type=="10c"?4.10:Coin_Type=="20c"?5.74:Coin_Type=="50c"?7.80:Coin_Type=="1€"?7.50:Coin_Type=="2€"?8.50:Coin_Weight_Custom;
// calcolo del volume di 1 moneta = volume di un cilindro = PI*Raggio^2*altezza
 Coin_Pure_Volume=PI*pow((Coin_Diameter/2),2)*Coin_Height;
// calcolo della densità di 1 moneta = peso/volume
 Coin_Pure_Density=Coin_Weight/Coin_Pure_Volume;
// ====================================================================================================
// GALLEGGIANTE
// calcolo del filamento per il galleggiante = base+(volume_esterno-volume_interno)
 Filament_Float_Volume=Print_Bed==0?(Print_Area_X*Print_Area_Y*Shell_Thickness)+((Print_Area_X*Print_Area_Y*(Print_Area_Z-Shell_Thickness))-((Print_Area_X-Shell_Thickness*2)*(Print_Area_Y-Shell_Thickness*2)*(Print_Area_Z-Shell_Thickness))):(PI*pow(Print_Diameter/2,2)*Shell_Thickness)+((PI*pow(Print_Diameter/2,2)*(Print_Area_Z-Shell_Thickness))-(PI*pow(((Print_Diameter-Shell_Thickness*2)/2),2)*(Print_Area_Z-Shell_Thickness)));
// calcolo del peso del galleggiante = volume*densità (/1000 per cm3)
 Filament_Float_Weight=Filament_Float_Volume*(Filament_Density/1000);
// ====================================================================================================
// SCOMPARTI
// calcolo del volume di filamento per la sede di 1 moneta = volume_esterno-volume_interno
 Filament_Stand_Volume=PI*pow((Coin_Diameter+Gap_Horizontal*2+Shell_Thickness*2)/2,2)*(Coin_Height+Gap_Vertical)-PI*pow((Coin_Diameter+Gap_Horizontal*2)/2,2)*(Coin_Height+Gap_Vertical);
// calcolo del peso del filamento per la sede di 1 moneta = volume*densità (/1000 per cm3)
 Filament_Stand_Weight=Filament_Stand_Volume*(Filament_Density/1000);
// calcolo volume di 1 moneta con sede = volume cilindro
 Float_Stand_Volume=PI*pow((Coin_Diameter+Gap_Horizontal*2+Shell_Thickness*2)/2,2)*(Coin_Height+Gap_Vertical);
// calcolo densità di 1 moneta con sede = (peso_moneta+peso_filamento)/(volume_moneta+volume_filamento)
 Float_Stand_Density=(Coin_Weight+Filament_Stand_Weight)/(Coin_Pure_Volume+Filament_Stand_Volume);
// ====================================================================================================
// COPERCHIO
// calcolo del filamento per il coperchio = base+(volume_esterno-volume_interno)
 Filament_Cover_Volume=Print_Bed==0?(Print_Area_X*Print_Area_Y*Shell_Thickness)+(((Print_Area_X-Shell_Thickness*2-Cover_Gap*2)*(Print_Area_Y-Shell_Thickness*2-Cover_Gap*2)*(Cover_Height-Shell_Thickness))-((Print_Area_X-Shell_Thickness*4-Cover_Gap*4)*(Print_Area_Y-Shell_Thickness*4-Cover_Gap*4)*(Cover_Height-Shell_Thickness))):(PI*pow(Print_Diameter/2,2)*Shell_Thickness)+((PI*pow((Print_Diameter-Shell_Thickness*2-Cover_Gap*2)/2,2)*(Cover_Height-Shell_Thickness))-(PI*pow((Print_Diameter-Shell_Thickness*4-Cover_Gap*4)/2,2)*(Cover_Height-Shell_Thickness)));
// calcolo del peso del coperchio = volume*densità (/1000 per cm3)
 Filament_Cover_Weight=Filament_Cover_Volume*(Filament_Density/1000);
// ====================================================================================================
// QUANTE MONETE?
// VM = (PF-PP)/DM
// calcolo del volume di fluido = volume area di stampa
 Fluid_Volume=Print_Bed==0?Print_Area_X*Print_Area_Y*Print_Area_Z:PI*pow((Print_Diameter/2),2)*Print_Area_Y;
// calcolo del peso del fluido = volume*densità (/1000 per cm3)
 Fluid_Weight=Fluid_Volume*(Fluid_Density/1000);
// calcolo del volume di filamento = volume float + cover S/N
 Filament_Volume=Filament_Float_Volume+(Float_Cover==1?Filament_Cover_Volume:0);
// calcolo del peso del filamento = volume*densità (/1000 per cm3)
 Filament_Weight=Filament_Volume*(Fluid_Density/1000);
// settaggio del volume di 1 moneta = se con sede o meno
 Coin_Volume=Float_Stand==1?Float_Stand_Volume:Coin_Pure_Volume;
// settaggio della densità di 1 moneta = se con sede o meno
 Coin_Density=Float_Stand==1?Float_Stand_Density:Coin_Pure_Density;
// calcolo del volume di tutte le monete = (peso del fluido - peso del filamento ) / densità moneta
 Coins_Volume=(Fluid_Weight-Filament_Weight)/Coin_Density;
// calcolo del numero di monete = volume totale / volume di 1 moneta
 Coins_Quantity=floor(Coins_Volume/Coin_Volume);
// ====================================================================================================
// QUANTE SEDI?
// calcolo dell'altezza di tutte le monete = quantità monete * (altezza moneta + gap_V)
 Coins_Height=Coins_Quantity*(Coin_Height+Gap_Vertical);
// calcolo di quante sedi servono = altezza monete / altezza Z
 Stand_Quantity = ceil(Coins_Height/Print_Area_Z);
// calcolo del diametro di una sede = diamietro moneta + (gap_H * 2) + (spessore stampa * 2)
 Stand_Diameter=Coin_Diameter+Gap_Horizontal*2+Shell_Thickness*2;

// finire CERCHIO?!?
// calcolo max sedi X = X / diametro di una sede
 Stand_Max_X = floor(Print_Area_X/Stand_Diameter);
// calcolo max sedi Y = Y / diametro di una sede
 Stand_Max_Y = floor(Print_Area_Y/Stand_Diameter);

// calcolo quante monete per ogni sede = totale monete / numero di stand totale
 Stand_Coins=floor(Coins_Quantity/(Stand_Max_X*Stand_Max_Y))+1; // ottimizzare +1 !!!
// calcolo dell'altezza di ogni sede = monete per 1 sede * (altezza di una moneta + gap_V)
Stand_Height=Stand_Coins*(Coin_Height+Gap_Vertical);
// ====================================================================================================

print_part();
module print_part(){
 if(Print_Bed==0&&Print_Area_X<50){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Print Area X not < 50",size=Text_Size,halign="center",valign="center");
 }else if(Print_Bed==0&&Print_Area_Y<50){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Print Area Y not < 50",size=Text_Size,halign="center",valign="center");
 }else if(Print_Bed==1&&Print_Diameter<50){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Print Diameter not < 50",size=Text_Size,halign="center",valign="center");
 }else if(Print_Area_Z<50){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Print Area Z not < 50",size=Text_Size,halign="center",valign="center");
 }else if(Coin_Type==""&&Coin_Value==""){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Insert Coin Value",size=Text_Size,halign="center",valign="center");
 }else if(Coin_Type==""&&Coin_Diameter==0){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Insert Coin Diameter",size=Text_Size,halign="center",valign="center");
 }else if(Coin_Type==""&&Coin_Height==0){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Insert Coin Height",size=Text_Size,halign="center",valign="center");
 }else if(Coin_Type==""&&Coin_Weight==0){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Insert Coin Weight",size=Text_Size,halign="center",valign="center");
	}else if(Print_Bed==1&&Float_Stand==1){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Stand with Circular is under construction",size=Text_Size,halign="center",valign="center");
	}else if(Coins_Quantity<1){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Check your input",size=Text_Size,halign="center",valign="center");
 }else{
  if(part==0){
		 Mod_Float();
	 }else if(part==1){
		 Mod_Cover();
	 }else if(part==2){
	 	Mod_Section();
 	}
	}
}
module Mod_Float(){
	if(Print_Bed==0){
  difference(){
   Xe=Print_Area_X;
   Ye=Print_Area_Y;
   Ze=Print_Area_Z;
   translate([-Xe/2,-Ye/2,0])cube([Xe,Ye,Ze]);
   Xi=Print_Area_X-Shell_Thickness*2;
   Yi=Print_Area_Y-Shell_Thickness*2;
   Zi=Print_Area_Z;
   translate([-Xi/2,-Yi/2,Shell_Thickness])cube([Xi,Yi,Zi]);
  }
 }else{
  difference(){
   De=Print_Diameter;
   Ze=Print_Area_Z;
   translate([0,0,0])cylinder(d=De,h=Ze);
   Di=Print_Diameter-Shell_Thickness*2;
   Zi=Print_Area_Z;
   translate([0,0,Shell_Thickness])cylinder(d=Di,h=Zi);
  }
 }
	if(Float_Stand==1){
  Xs=-((Stand_Max_X/2)*(Stand_Diameter-Shell_Thickness))+((Stand_Diameter-Shell_Thickness)/2);
  Ys=-((Stand_Max_Y/2)*(Stand_Diameter-Shell_Thickness))+((Stand_Diameter-Shell_Thickness)/2);
  for (X=[0:Stand_Max_X-1]){
   for (Y=[0:Stand_Max_Y-1]){
    difference(){
     translate([Xs+(X*(Stand_Diameter-Shell_Thickness)),Ys+(Y*(Stand_Diameter-Shell_Thickness)),0])cylinder(d=Stand_Diameter,h=Stand_Height+Shell_Thickness);
     translate([Xs+(X*(Stand_Diameter-Shell_Thickness)),Ys+(Y*(Stand_Diameter-Shell_Thickness)),Shell_Thickness])cylinder(d=Stand_Diameter-(Shell_Thickness*2),h=Stand_Height+Shell_Thickness);
    }
   }
  }
 }
}
module Mod_Cover(){
	if(Float_Cover==0){
  color("red")translate([0,0,0])linear_extrude(height=0.1)text("Cover unselected",size=Text_Size,halign="center",valign="center");
 }else{
  if(Print_Bed==0){
   difference(){
    Xa=Print_Area_X;
    Ya=Print_Area_Y;
    Za=Shell_Thickness;
    translate([-Xa/2,-Ya/2,0])cube([Xa,Ya,Za]);
    Xb=Print_Area_X-(Shell_Thickness*4);
    Yb=Print_Area_Y-(Shell_Thickness*4);
    Zb=Shell_Thickness;
    translate([-Xb/2,-Yb/2,-0.01])cube([Xb,Yb,Zb+0.02]);
   }
   difference(){
    Xe=Print_Area_X-(Shell_Thickness*2)-(Cover_Gap*2);
    Ye=Print_Area_Y-(Shell_Thickness*2)-(Cover_Gap*2);
    Ze=Cover_Height+Shell_Thickness;
    translate([-Xe/2,-Ye/2,0])cube([Xe,Ye,Ze]);
    Xi=Print_Area_X-(Shell_Thickness*4)-(Cover_Gap*2);
    Yi=Print_Area_Y-(Shell_Thickness*4)-(Cover_Gap*2);
    Zi=Cover_Height+Shell_Thickness;
    translate([-Xi/2,-Yi/2,Shell_Thickness])cube([Xi,Yi,Zi]);
   }
  }else{
   difference(){
    Da=Print_Diameter;
    Za=Shell_Thickness;
    translate([0,0,0])cylinder(d=Da,h=Za);
    Db=Print_Diameter-(Shell_Thickness*4);
    Zb=Shell_Thickness;
    translate([0,0,-0.01])cylinder(d=Db,h=Zb+0.02);
   }
   difference(){
    De=Print_Diameter-(Shell_Thickness*2)-(Cover_Gap*2);
    Ze=Cover_Height+Shell_Thickness;
    translate([0,0,0])cylinder(d=De,h=Ze);
    Di=Print_Diameter-(Shell_Thickness*4)-(Cover_Gap*2);
    Zi=Cover_Height+Shell_Thickness;
    translate([0,0,Shell_Thickness])cylinder(d=Di,h=Zi);
   }
  }
 }
}
module Mod_Section(){
 difference(){
  union(){
  	if(Print_Bed==0){
    %Mod_Coin();
   }
   translate([0,0,0])rotate([0,0,0])Mod_Float();
  	if(Float_Cover==1){
    translate([0,0,Print_Area_Z+Shell_Thickness+Cover_Gap+30])rotate([180,0,0])Mod_Cover();
   }
  }
  translate([0,-Print_Area_Y,-Print_Area_Z/2])cube([Print_Area_X,Print_Area_Y,Print_Area_Z*2+30]);
 }
 color("red")translate([0,-Print_Area_Y/2-Text_Size*1,0])linear_extrude(height=0.1)text("Section (only to show)",size=Text_Size,halign="center",valign="center");
 color("red")translate([-10,-Print_Area_Y/2-Text_Size*3,0])linear_extrude(height=0.1)text(str(Coins_Quantity," x ",Coin_Value," = ",Coins_Quantity*Coin_Weight," gr"),size=Text_Size,halign="center",valign="center");
}
module Mod_Coin(){
 Xs=-((Stand_Max_X/2)*(Stand_Diameter-Shell_Thickness))+((Stand_Diameter-Shell_Thickness)/2);
 Ys=-((Stand_Max_Y/2)*(Stand_Diameter-Shell_Thickness))+((Stand_Diameter-Shell_Thickness)/2);
 for (X=[0:Stand_Max_X-1]){
  for (Y=[0:Stand_Max_Y-1]){
   for (i=[0:Stand_Coins-1]){
    translate([Xs+(X*(Stand_Diameter-Shell_Thickness)),Ys+(Y*(Stand_Diameter-Shell_Thickness)),Shell_Thickness+(i*(Coin_Height+Gap_Vertical))])cylinder(d=Coin_Diameter,h=Coin_Height);
   }
   color("black")translate([Xs+(X*(Stand_Diameter-Shell_Thickness)),Ys+(Y*(Stand_Diameter-Shell_Thickness)),Stand_Coins*(Coin_Height+Gap_Vertical)+Shell_Thickness])linear_extrude(height=0.1)text(Coin_Value,size=Coin_Diameter/3,halign="center",valign="center");
  }
 }
}