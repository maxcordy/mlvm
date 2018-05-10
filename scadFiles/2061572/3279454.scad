// 'use' won't work since it "hides" global variables in the module
include <U_Box_V104_plus.scad>;

//
// U_Box_V104_plus.scad
//
FootDia = 4;
FootHole = 2;

HexGrid = 1;
Vent_extra = 1; // Extra ventilation on top
Vent_width = 2;

PCBAdapter = 1; // This will create place for the PCB base
PCBLock    = 1; // To secure the adapter in its place
PCBPosX = -2; PCBPosY = 1;
PCBLength = 70; // 70 ≈ length of Arduino UNO (WeMos D1 R2)
PCBWidth = 54; // 54 ≈ width of Arduino UNO (WeMos D1 R2)
$PCBFeetXY=
  [
    [undef, undef] // optional dummy coordinates to mark the start of array
/*    
  // Arduino, WeMos D1 R2
  , [15 + 0,  2 + 0]
  , [15 + 52, 2 + 5]
  , [15 + 52, 2 + 5 + 28]
  , [15 + 1,  2 + 48]
  */
  // LoLin
  , [0,      2 + 48 - 25]
  , [0 + 52, 2 + 48 - 25]
  , [0 + 52, 2 + 48]
  , [0,      2 + 48] // +Amica
  // Amica
  , [0,      2 + 48 - 21] // conflicts with LoLin
  , [0 + 44, 2 + 48 - 21]
  , [0 + 44, 2 + 48]
  , [0,      2 + 48] // +LoLin
  ];


IFeet();
if (PCBAdapter)
  ILock();
IShellBottom();
//IShellTop();
IPanelBack()
{
  ICut()
  {
    LText(1,100,10,"Arial Black",6,"Back");
//  <- Cutting shapes from here ->  
    SquareHole  (1,20,20,15,10,1); //(On/Off, Xpos,Ypos,Length,Width,Filet)
    SquareHole  (1,40,20,15,10,1);
    SquareHole  (1,60,20,15,10,1); 
    CylinderHole(1,27,40,8);       //(On/Off, Xpos, Ypos, Diameter)
    CylinderHole(1,47,40,8);
    CylinderHole(1,67,40,8);
    SquareHole  (1,20,50,80,30,3);
    CylinderHole(1,93,30,10);
    SquareHole  (1,120,20,30,60,3);
//  <- To here -> 
  }
  IAdd()
  {
    SquareZ (1,80,5,15,10,1,3); // Square "button"
    SquareZ (1,130,5,15,10,1,-3); // Square "button" on over side
    Cylinder(1,80,10,8,-10); // Cylindrical "button" on other side
    CylinderWithHole(1,130,10,8,10,5); // Cylindrical foot
//   <- Adding text from here ->          
    LText(1,20,83,"Arial Black",4,"Digital Screen");//(On/Off, Xpos, Ypos, "Font", Size, "Text")
    LText(1,120,83,"Arial Black",4,"Level");
    LText(1,20,11,"Arial Black",6,"  1     2      3");
    CText(1,93,29,"Arial Black",4,10,180,0,"1 . 2 . 3 . 4 . 5 . 6");//(On/Off, Xpos, Ypos, "Font", Size, Diameter, Arc(Deg), Starting Angle(Deg),"Text")
//  <- To here ->
  }
}
IPanelFront()
{
  ICut()
  {
    LText(1,100,10,"Arial Black",6,"Front");
//  <- Cutting shapes from here ->  
    SquareHole  (1,20,20,15,10,1); //(On/Off, Xpos,Ypos,Length,Width,Filet)
    SquareHole  (1,40,20,15,10,1);
    SquareHole  (1,60,20,15,10,1); 
    CylinderHole(1,27,40,8);       //(On/Off, Xpos, Ypos, Diameter)
    CylinderHole(1,47,40,8);
    CylinderHole(1,67,40,8);
    SquareHole  (1,20,50,80,30,3);
    CylinderHole(1,93,30,10);
    SquareHole  (1,120,20,30,60,3);
//  <- To here -> 
  }
  IAdd()
  {
    SquareZ (1,80,5,15,10,1,3); // Square "button"
    SquareZ (1,130,5,15,10,1,-3); // Square "button" on over side
    CylinderWithHole(1,80,10,8,-10,6); // Cylindrical foot on other side
    Cylinder(1,130,10,8,10); // Cylindrical "button"
//   <- Adding text from here ->          
    LText(1,20,83,"Arial Black",4,"Digital Screen");//(On/Off, Xpos, Ypos, "Font", Size, "Text")
    LText(1,120,83,"Arial Black",4,"Level");
    LText(1,20,11,"Arial Black",6,"  1     2      3");
    CText(1,93,29,"Arial Black",4,10,180,0,"1 . 2 . 3 . 4 . 5 . 6");//(On/Off, Xpos, Ypos, "Font", Size, Diameter, Arc(Deg), Starting Angle(Deg),"Text")
//  <- To here ->
  }
}
