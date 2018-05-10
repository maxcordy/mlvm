// Heroscape Terrain Hex Tile Generator

//Type of tile to generate
HexName = "single"; // [single,pair,row3,row4,row5,tri3,diam4,block6,rnd7]

// Type of tile to make
HexType = "ground"; // [ground,water]

// Generate supports for the underside of the tile face
MakeSupports = "yes"; // [yes,no]

// Use a file to generate a texture for the raised hex center
UseFaceTextureFile = "no"; // [yes,no]

// Texture file to use for a ground tile face, 150x150 or larger
FileName = "image-surface.dat"; // [image_surface:150x150]


// Creates a 'clip' that merges the edges of two adjacent tiles
// Parameters:
//	face: Which face of the tile to clip, counting CCW from +X (1-5)
//	full: Whether to draw a full-height clip or not (1:full, 0:half)
module hexclip(face,type)
{
  rotate([0,0,((face-1)*60)-60])
  if (type == "ground")
  {
    translate([-126.925,199.84,-42])
    cube([253.85,40,92]);
  } else {
    translate([-126.925,199.84,0])
    cube([253.85,40,50]);
  }
}

module hex_rim(top)
{
  difference(){
    union(){
      if (top==1)
      {
        translate([0,0,37.5])
        cylinder(12.5,253.75,253.75,$fn=6);
      }
      translate([0,0,25])
      linear_extrude(height=50,center=true, convexity=10)
      {
        difference ()
        {
          circle(253.85,$fn=6);
          circle(236.35,$fn=6);
        };
      }
      for (a = [0:5])
      {
        rotate([0,0,a*60])
        {
          translate([39.575,219.825,0]) {cube([43.175,15,50]);}
          translate([-107.875,192.5,0]) {cube([92.65,20,50]);}
        }
      }
    }
    for (a = [0:5])
    {
      rotate([0,0,a*60])
      {
        translate([-95.375,205,-25]) {cube([67.65,30,100]);}
      }
    }
  }
}

module HexSupports()
{
  for (x=[0:120:240])
  {
    rotate([0,0,x])
    translate([0,100,0])
    {
      translate([-5,-5,-42])
      cube([10,10,80]);
      for (i=[-30:120:300])
      rotate([0,0,i])
      rotate([90,0,0])
      linear_extrude(5)
      polygon([[0,-12],[100,38],[0,38]],[[0,1,2]]);
    }
  }
  for (x=[60:120:300])
  {
    rotate([0,0,x])
    translate([0,210,0])
    rotate([90,0,-90])
    linear_extrude(5)
    polygon([[0,-12],[100,38],[0,38]],[[0,1,2]]);
  }
}

module TerrainHex()
{
  hex_rim(1);
  if (HexType == "ground")
  {
    translate([0,0,-42])
    hex_rim(0);
    if (UseFaceTextureFile == "yes")
    {
      intersection()
      {
        translate([0,0,0])
        cylinder(100,218,218,$fn=6);
        translate([-225,-225,50])
        scale([3,3,20])		// use this scaling on Thingiverse
        surface(file=FileName, convexity=5);
      }
    } else {
      translate([0,0,45])
      cylinder(20,218,218,$fn=6);
    }
    if (MakeSupports == "yes") HexSupports();
  }
}

module TerrainRow(num)
{
  for (i=[1:num])
  {
    translate([0,(i-1)*439.68,0])
    {
      if (i>1) {hexclip(5,HexType);}
      TerrainHex();
    }
  }
}

module TriHex()
{
  TerrainRow(2);
  rotate([0,0,60])
  {
    translate([0,439.68,0])
    rotate([0,0,-60])
    {
      TerrainHex();
      hexclip(1,HexType);
      hexclip(6,HexType);
    }
  }
}

module DblRow(len)
{
  TerrainRow(len);
  rotate([0,0,60])
  translate([0,439.68,0])
  rotate([0,0,-60])
  for (i=[0:(len-1)])
  {
    translate([0,i*439.68,0])
    {
      TerrainHex();
      hexclip(6,HexType);
      if (i<(len-1)) {hexclip(1,HexType);}
      if (i>0) {hexclip(5,HexType);}
    }
  }
}

module WrapCenter(index)
{
  if (index<6)
  {
    translate([0,439.68,0])
    {
      TerrainHex();
      hexclip(5,HexType);
      if (index>0) {hexclip(6,HexType);}
      if (index==0)
      {rotate([0,0,-120]) {WrapCenter(index+1);}}
      else
      {rotate([0,0,-60]) {WrapCenter(index+1);}}
    }
  } else {hexclip(2,HexType);}
}

module SevenHex()
{
  TerrainHex();
  WrapCenter(0);
}

module WaterHex()
{
  hex_rim(1);
}

module Water2Hex()
{
  hex_rim(1);
  translate([0,439.68,0])
  hex_rim(1);
  translate([-126.925,199.84,0])
  cube([253.85,40,50]);
}

module Water3Hex()
{
 Water2Hex();
 rotate([0,0,60])
 {
   translate([0,439.68,0])
   hex_rim(1);
   translate([-126.925,199.84,0])
   cube([253.85,40,50]);
   translate([0,439.68,0])
   rotate([0,0,-120])
   {
     translate([-126.925,199.84,0])
     cube([253.85,40,50]);
   }
 }
}

color("DarkGray")
{
  if (HexType == "ground")
  {
    if (HexName == "single") {TerrainRow(1);}
    else if (HexName == "pair") {TerrainRow(2);}
    else if (HexName == "row3") {TerrainRow(3);}
    else if (HexName == "row4") {TerrainRow(4);}
    else if (HexName == "row5") {TerrainRow(5);}
    else if (HexName == "tri3") {TriHex();}
    else if (HexName == "diam4") {DblRow(2);}
    else if (HexName == "block6") {DblRow(3);}
    else if (HexName == "rnd7") {SevenHex();}
    else {}
  }
  else
  {
    rotate([0,180,0])
    {
      if (HexName == "single") {TerrainRow(1);}
      else if (HexName == "pair") {TerrainRow(2);}
      else if (HexName == "row3") {TerrainRow(3);}
      else if (HexName == "row4") {TerrainRow(4);}
      else if (HexName == "row5") {TerrainRow(5);}
      else if (HexName == "tri3") {TriHex();}
      else if (HexName == "diam4") {DblRow(2);}
      else if (HexName == "block6") {DblRow(3);}
      else if (HexName == "rnd7") {SevenHex();}
      else {}
    }
  }
}