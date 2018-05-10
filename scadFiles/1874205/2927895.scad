//All dimensions are in mm

Wall = 1.2;

//Case
//====================================
Case_In_x = 265;
Case_In_y = 180;
Case_In_z = 65;
Case_In_Lvl = Case_In_z / 2; //32.5
//Bridge
//====================================
Bridge_x = 46.5;
Bridge_y = 10.4;
Bridge_z = 26;
Bridge_dia = 32;
//Box for bridges
//====================================
Box_Bridge_Num_x = 2;
Box_Bridge_Num_y = 6;
Box_Bridge_Num_z = 1;
Box_Bridge_x = Box_Bridge_Num_x * Bridge_x;
Box_Bridge_y = Box_Bridge_Num_y * Bridge_y;
Box_Bridge_z = Box_Bridge_Num_z * Bridge_z;
//Tower
//====================================
Tower_x = 18.4;
Tower_y = 17.75;
Tower_z = 9.6;
Tower_Cut_x = 2.8;
Tower_Cut_z = 2.4;
//Box for towers
//====================================
Box_Tower_Num_x = 4;
Box_Tower_Num_y = 3;
Box_Tower_Num_z = 3;
Box_Tower_x = Box_Tower_Num_x * Tower_x;
Box_Tower_y = Box_Tower_Num_y * Tower_y;
Box_Tower_z = Box_Tower_Num_z * Tower_z;
//Gold
//====================================
Gold_x1 = 14;
Gold_x2 = 10;
Gold_y = 16;
Gold_z = 8;
//Box for golds
//====================================
Box_Gold_Num_x = 3;
Box_Gold_Num_y = 2;
Box_Gold_Num_z = 3;
Box_Gold_x = Box_Gold_Num_x * Gold_x1;
Box_Gold_y = Box_Gold_Num_y * Gold_y;
Box_Gold_z = Box_Gold_Num_z * Gold_z;
//Box for meeple
//====================================
Box_Meeple_x = (Case_In_x - (6 * Wall)) / 3;
Box_Meeple_y = (Case_In_y - (4 * Wall)) / 2;
//ResourceChip
//====================================
ResourceChip_x = 21;
ResourceChip_y = 2.1;
ResourceChip_z = 21;
ResourceChip_Cut_z = ResourceChip_z - 14;
ResourceChip_Cut_x = (ResourceChip_x / 2) - 1;
//Box for resource chips
//====================================
Box_ResourceChip_Num_x = 1;
Box_ResourceChip_Num_y = 20;
Box_ResourceChip_Num_z = 1;
Box_ResourceChip_x = Box_ResourceChip_Num_x * ResourceChip_x;
Box_ResourceChip_y = Box_ResourceChip_Num_y * ResourceChip_y;
Box_ResourceChip_z = Box_ResourceChip_Num_z * ResourceChip_z;
//Fary
//====================================
Fary_x = 16.5;
Fary_y = 4.5;
Fary_z = 4.5;
Fary_Num = 8;
//Box for faries
//====================================
Box_Fary_x = 30;
Box_Fary_y = 10;
//Catapult chips
//====================================
CatapultChip_y = 2.1;
CatapultChip_Blue_x = 21;
CatapultChip_Blue_z = 25.5;
CatapultChip_Yellow_x = 22.5;
CatapultChip_Yellow_z = 23;
CatapultChip_Green_dia = 26;
CatapultChip_Red_dia = 21;
//Box for catapult chips
//====================================
Box_CatapultChip_Num = 4;
Box_CatapultChip_Num2 = 6;
Box_CatapultChip_Num_x = 1;
Box_CatapultChip_Num_y = Box_CatapultChip_Num * Box_CatapultChip_Num2;
Box_CatapultChip_Num_z = 1;
Box_CatapultChip_x = CatapultChip_Green_dia;
Box_CatapultChip_y = (CatapultChip_y * Box_CatapultChip_Num_y) + (Wall * (Box_CatapultChip_Num - 1)); 
Box_CatapultChip_z = CatapultChip_Green_dia;
//Castle
//====================================
Castle_x = 37;
Castle_y = 2.25;
Castle_z = 31;
//Box for castle
//====================================
Box_Castle_Num_x = 1;
Box_Castle_Num_y = 12;
Box_Castle_Num_z = 1;
Box_Castle_x = Box_Castle_Num_x * Castle_x;
Box_Castle_y = Box_Castle_Num_y * Castle_y;
Box_Castle_z = Box_Castle_Num_z * Castle_z;
//Card
//====================================
Card_x = 46;
Card_y = 2.4;
Card_z = 46 + Card_y;
Card_Angle = acos((Case_In_Lvl - Wall) / Card_z);
Card_Mod_y = (cos(Card_Angle) * Card_y) * 2;
Card_Add_y = sin(Card_Angle) * Card_z;
Card_Mod_z = sin(Card_Angle) * Card_y;
Card_Fin_z = (Card_z * cos(Card_Angle)) + Card_Mod_z;
Card_River_Num = 11 + 1;
Card_City_Num = 12 + 1;
Card_Post_Num = 8 + 1;
Card_Max_Num = 2 + 1;
Card_Score_Num = 6 + 1;
//Box for cards
//====================================
Box_Card_Num_x = 2;
Box_Card_Num_y = Card_Post_Num + Card_City_Num;
Box_Card_Num_z = 1;
Box_Card_x = (Box_Card_Num_x * Card_x) + Wall;
Box_Card_y = ((Box_Card_Num_y + 1) * Card_Mod_y) + Card_Add_y;
Box_Card_z = Card_Fin_z;
//Box for other things
//====================================
Box_Other_x = 50;
Box_Other_y = 85;

//Things
module Bridge()
{
  difference()
  {
    cube([Bridge_x, Bridge_y, Bridge_z]);
    translate([Bridge_x / 2, 0, 0])
    {
      rotate([-90, 0, 0])
      {
        cylinder(d = Bridge_dia, h = Bridge_y, $fn = 40);
      }
    }
  }
}
module Tower()
{
  difference()
  {
    union()
    {
      cube([Tower_x, Tower_y, Tower_z - Tower_Cut_z]);
      translate([(Tower_x - Tower_Cut_x) / 2, 0, Tower_z - Tower_Cut_z])
      {
        polyhedron(points = [[0, 0, 0],
                             [Tower_Cut_x, 0, 0],
                             [Tower_Cut_x, Tower_y, 0],
                             [0, Tower_y, 0],
                             [Tower_Cut_x / 2, 0, Tower_Cut_z],
                             [Tower_Cut_x / 2, Tower_y, Tower_Cut_z]],
                   faces = [[0, 1, 2, 3],
                            [1, 4, 5, 2],
                            [0, 3, 5, 4],
                            [0, 4, 1],
                            [2, 5, 3]]);
      }
    }
    translate([(Tower_x - Tower_Cut_x) / 2, 0, 0])
    {
      polyhedron(points = [[0, 0, 0],
                           [Tower_Cut_x, 0, 0],
                           [Tower_Cut_x, Tower_y, 0],
                           [0, Tower_y, 0],
                           [Tower_Cut_x / 2, 0, Tower_Cut_z],
                           [Tower_Cut_x / 2, Tower_y, Tower_Cut_z]],
                 faces = [[0, 1, 2, 3],
                          [1, 4, 5, 2],
                          [0, 3, 5, 4],
                          [0, 4, 1],
                          [2, 5, 3]]);
    }
  }
}

module Gold()
{
  polyhedron(points = [[0, 0, 0],
                       [Gold_x1, 0, 0],
                       [Gold_x1, Gold_y, 0],
                       [0, Gold_y, 0],
                       [(Gold_x1 - Gold_x2) / 2, 0, Gold_z],
                       [Gold_x1 - ((Gold_x1 - Gold_x2) / 2), 0, Gold_z],
                       [Gold_x1 - ((Gold_x1 - Gold_x2) / 2), Gold_y, Gold_z],
                       [(Gold_x1 - Gold_x2) / 2, Gold_y, Gold_z]],
              faces = [[0, 1, 2, 3],
                       [7, 6, 5, 4],
                       [1, 5, 6, 2],
                       [0, 3, 7, 4],
                       [0, 4, 5, 1],
                       [2, 6, 7, 3]]);
                       
}
module ResourceChip()
{
  translate([0, ResourceChip_y, 0])
  {
    rotate([90, 0, 0])
    {
      linear_extrude(height = ResourceChip_y)
      {
        polygon(points = [[ResourceChip_Cut_x, 0],
                          [0, ResourceChip_Cut_z],
                          [0, ResourceChip_z],
                          [ResourceChip_x, ResourceChip_z],
                          [ResourceChip_x, ResourceChip_Cut_z],
                          [ResourceChip_x - ResourceChip_Cut_x, 0]]);
      }
    }
  }
}
module Fary()
{
  cube([Fary_x, Fary_y, Fary_z]);
}
module CatapultChip_Blue()
{
  cube([CatapultChip_Blue_x, CatapultChip_y, CatapultChip_Blue_z]);
}
module CatapultChip_Yellow()
{
  cube([CatapultChip_Yellow_x, CatapultChip_y, CatapultChip_Yellow_z]);
}
module CatapultChip_Red()
{
  translate([CatapultChip_Red_dia / 2, CatapultChip_y, CatapultChip_Red_dia/2])
  {
    rotate([90, 0, 0])
    {
      cylinder(d = CatapultChip_Red_dia, h = CatapultChip_y, $fn = 40);
    }
  }
}
module CatapultChip_Green()
{
  translate([CatapultChip_Green_dia / 2, CatapultChip_y, CatapultChip_Green_dia/2])
  {
    rotate([90, 0, 0])
    {
      cylinder(d = CatapultChip_Green_dia, h = CatapultChip_y, $fn = 40);
    }
  }
}
module Castle()
{
  cube([Castle_x, Castle_y, Castle_z]);
}
module Card()
{
  translate([0, 0, Card_Mod_z])
  {
    rotate([-Card_Angle, 0, 0])
    {
      cube([Card_x, Card_y, Card_z]);
    }
  }
}
//Show thing

//Boxes
module Box_Bridge()
{
  difference()
  {
    //Things to add
    cube([Box_Bridge_x + (2 * Wall), Box_Bridge_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + Box_Bridge_z])
      {
        cube([Box_Bridge_x, Box_Bridge_y, Case_In_Lvl - Wall - Box_Bridge_z]);
      }
      for(i = [0 : 1 : Box_Bridge_Num_x - 1])
      {
        for(j = [0 : 1: Box_Bridge_Num_y - 1])
        {
          for(k = [0 : 1 : Box_Bridge_Num_z - 1])
          {
            translate([Wall + (i * (Bridge_x - 0.0001)), Wall + (j * (Bridge_y - 0.0001)), Wall + (k * Bridge_z)])
            {
              Bridge();
            }
          }
        }
      }
    }
  }
}
module Box_Tower()
{
  difference()
  {
    //Things to add
    cube([Box_Tower_x + (2 * Wall), Box_Tower_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + Tower_Cut_z])
      {
        cube([Box_Tower_x, Box_Tower_y, Case_In_Lvl - Wall - Tower_Cut_z]);
      }
      for(i = [0 : 1 : Box_Tower_Num_x - 1])
      {
        for(j = [0 : 1: Box_Tower_Num_y - 1])
        {
          for(k = [0 : 1 : Box_Tower_Num_z - 1])
          {
            translate([Wall + (i * (Tower_x - 0.0001)), Wall + (j * (Tower_y - 0.0001)), Wall + (k * Tower_z)])
            {
              Tower();
            }
          }
        }
      }
    }
  }
}
module Box_Gold()
{
  difference()
  {
    //Things to add
    cube([Box_Gold_x + (2 * Wall), Box_Gold_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + Gold_z])
      {
        cube([Box_Gold_x, Box_Gold_y, Case_In_Lvl - Wall - Gold_z]);
      }
      for(i = [0 : 1 : Box_Gold_Num_x - 1])
      {
        for(j = [0 : 1: Box_Gold_Num_y - 1])
        {
          for(k = [0 : 1 : Box_Gold_Num_z - 1])
          {
            translate([Wall + (i * (Gold_x1 - 0.0001)), Wall + (j * (Gold_y - 0.0001)), Wall + (k * Gold_z)])
            {
              translate([Gold_x1, 0, Gold_z])
              {
                rotate([0, 180, 0])
                {
                  Gold();
                }
              }
            }
          }
        }
      }
    }
  }
}
module Box_Meeple()
{
  difference()
  {
    //Things to add
    cube([Box_Meeple_x + (2 * Wall), Box_Meeple_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall])
      {
        cube([Box_Meeple_x, Box_Meeple_y, Case_In_Lvl - Wall]);
      }
    }
  }
}
module Box_ResourceChip()
{
  difference()
  {
    //Things to add
    cube([Box_ResourceChip_x + (2 * Wall), Box_ResourceChip_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + ResourceChip_Cut_z])
      {
        cube([Box_ResourceChip_x, Box_ResourceChip_y, Case_In_Lvl - Wall - ResourceChip_Cut_z]);
      }
      for(i = [0 : 1 : Box_ResourceChip_Num_x - 1])
      {
        for(j = [0 : 1: Box_ResourceChip_Num_y - 1])
        {
          for(k = [0 : 1 : Box_ResourceChip_Num_z - 1])
          {
            translate([Wall + (i * (ResourceChip_x - 0.0001)), Wall + (j * (ResourceChip_y - 0.0001)), Wall + (k * ResourceChip_z)])
            {
              ResourceChip();
            }
          }
        }
      }
    }
  }
}
module Box_Fary()
{
  difference()
  {
    //Things to add
    cube([Box_Fary_x + (2 * Wall), Box_Fary_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    translate([Wall, Wall, Wall])
    {
      cube([Box_Fary_x, Box_Fary_y, Case_In_Lvl - Wall]);
    }
  }
}
module Box_CatapultChip()
{
    difference()
  {
    //Things to add
    cube([Box_CatapultChip_x + (2 * Wall), Box_CatapultChip_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + (Box_CatapultChip_z / 2)])
      {
        cube([Box_CatapultChip_x, Box_CatapultChip_y, Case_In_Lvl - Wall - (Box_CatapultChip_z / 2)]);
      }
      for(i = [0 : 1 : Box_CatapultChip_Num_x - 1])
      {
        for(j = [0 : 1: Box_CatapultChip_Num2 - 1])
        {
          for(k = [0 : 1 : Box_CatapultChip_Num_z - 1])
          {
            translate([Wall + (i * (CatapultChip_Green_dia - 0.0001)), Wall + (j * (CatapultChip_y - 0.0001)), Wall + (k * CatapultChip_Green_dia)])
            {
              CatapultChip_Green();
            }
          }
        }
      }
      for(i = [0 : 1 : Box_CatapultChip_Num_x - 1])
      {
        for(j = [0 : 1: Box_CatapultChip_Num2 - 1])
        {
          for(k = [0 : 1 : Box_CatapultChip_Num_z - 1])
          {
            translate([Wall + (i * (CatapultChip_Red_dia - 0.0001)), Wall + (j * (CatapultChip_y - 0.0001)), Wall + (k * CatapultChip_Red_dia)])
            {
              translate([(CatapultChip_Green_dia - CatapultChip_Red_dia) / 2, Wall + (Box_CatapultChip_Num2 * CatapultChip_y), 0])
              {
                CatapultChip_Red();
              }
            }
          }
        }
      }
      for(i = [0 : 1 : Box_CatapultChip_Num_x - 1])
      {
        for(j = [0 : 1: Box_CatapultChip_Num2 - 1])
        {
          for(k = [0 : 1 : Box_CatapultChip_Num_z - 1])
          {
            translate([Wall + (i * (CatapultChip_Blue_x - 0.0001)), Wall + (j * (CatapultChip_y - 0.0001)), Wall + (k * CatapultChip_Blue_z)])
            {
              translate([(CatapultChip_Green_dia - CatapultChip_Blue_x) / 2, (2 * Wall) + ((2 * Box_CatapultChip_Num2) * CatapultChip_y), 0])
              {
                CatapultChip_Blue();
              }
            }
          }
        }
      }
      for(i = [0 : 1 : Box_CatapultChip_Num_x - 1])
      {
        for(j = [0 : 1: Box_CatapultChip_Num2 - 1])
        {
          for(k = [0 : 1 : Box_CatapultChip_Num_z - 1])
          {
            translate([Wall + (i * (CatapultChip_Yellow_x - 0.0001)), Wall + (j * (CatapultChip_y - 0.0001)), Wall + (k * CatapultChip_Yellow_z)])
            {
              translate([(CatapultChip_Green_dia - CatapultChip_Yellow_x) / 2, (3 * Wall) + ((3 * Box_CatapultChip_Num2) * CatapultChip_y), 0])
              {
                CatapultChip_Yellow();
              }
            }
          }
        }
      }
    }
  }
}
module Box_Castle()
{
  difference()
  {
    //Things to add
    cube([Box_Castle_x + (2 * Wall), Box_Castle_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + Castle_z])
      {
        cube([Box_Castle_x, Box_Castle_y, Case_In_Lvl - Wall - Castle_z]);
      }
      for(i = [0 : 1 : Box_Castle_Num_x - 1])
      {
        for(j = [0 : 1: Box_Castle_Num_y - 1])
        {
          for(k = [0 : 1 : Box_Castle_Num_z - 1])
          {
            translate([Wall + (i * (Castle_x - 0.0001)), Wall + (j * (Castle_y - 0.0001)), Wall + (k * Castle_z)])
            {
              Castle();
            }
          }
        }
      }
    }
  }
}
module Box_Card()
{
  difference()
  {
    //Things to add
    cube([Box_Card_x + (2 * Wall), Box_Card_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    union()
    {
      translate([Wall, Wall, Wall + (Card_Fin_z * (1/2))])
      {
        cube([Box_Card_x, Box_Card_y, Case_In_Lvl - Wall - (Card_Fin_z * (1/2))]);
      }
      for(i = [0 : 1 : 0])
      {
        for(j = [0 : 1: Card_City_Num - 1])
        {
          for(k = [0 : 1 : Box_Card_Num_z - 1])
          {
            translate([Wall + (i * (Card_x - 0.0001)), Wall + (j * (Card_Mod_y)), Wall + (k * Card_Fin_z)])
            {
              Card();
            }
          }
        }
      }
      for(i = [0 : 1 : 0])
      {
        for(j = [0 : 1: Card_Post_Num - 1])
        {
          for(k = [0 : 1 : Box_Card_Num_z - 1])
          {
            translate([Wall + (i * (Card_x - 0.0001)), Wall + (j * (Card_Mod_y)) + ((Card_City_Num + 1) * (Card_Mod_y)), Wall + (k * Card_Fin_z)])
            {
              Card();
            }
          }
        }
      }
      for(i = [0 : 1 : 0])
      {
        for(j = [0 : 1: Card_River_Num - 1])
        {
          for(k = [0 : 1 : Box_Card_Num_z - 1])
          {
            translate([(2 * Wall) + (1 * (Card_x - 0.0001)), Wall + (j * (Card_Mod_y)), Wall + (k * Card_Fin_z)])
            {
              Card();
            }
          }
        }
      }
      for(i = [0 : 1 : 0])
      {
        for(j = [0 : 1: Card_Score_Num - 1])
        {
          for(k = [0 : 1 : Box_Card_Num_z - 1])
          {
            translate([(2 * Wall) + (1 * (Card_x - 0.0001)), Wall + ((j + 1 + Card_River_Num) * (Card_Mod_y)), Wall + (k * Card_Fin_z)])
            {
              Card();
            }
          }
        }
      }
      for(i = [0 : 1 : 0])
      {
        for(j = [0 : 1: Card_Max_Num - 1])
        {
          for(k = [0 : 1 : Box_Card_Num_z - 1])
          {
            translate([(2 * Wall) + (1 * (Card_x - 0.0001)), Wall + ((j + 2 + Card_River_Num + Card_Score_Num) * (Card_Mod_y)), Wall + (k * Card_Fin_z)])
            {
              Card();
            }
          }
        }
      }
    }
  }
}
module Box_Other()
{
  difference()
  {
    //Things to add
    cube([Box_Other_x + (2 * Wall), Box_Other_y + (2 * Wall), Case_In_Lvl]);
    //Things to substract
    translate([Wall, Wall, Wall])
    {
      cube([Box_Other_x, Box_Other_y, Case_In_Lvl - Wall]);
    }
  }
}
//Show box

