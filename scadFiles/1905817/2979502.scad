//Length of the road, without connector
//Female is around 20
//male is almost zero (it fits into the female)

roadlength = 50;

//0 = female, 1 = male
start = 0;
end = 0;

//Grade of details
$fn = 18;

module connector(m)
{
    if(m==0)
    {
      import("vtechsmartwheels female.stl", convexity=3);
    }
    
    if(m==1)
    {
      import("vtechsmartwheels male.stl", convexity=3);
    }
}

module startpiece()
{
  connector(start);
}

module endpiece()
{
  translate([roadlength,0,0])
  rotate([0,0,180])
  {
    connector(end);
  }
}

w = 78.8;

module road()
{
  difference()
  {
    union()
    {
      translate([0,-(w/2),0])
      cube([roadlength,w,8]);
      
      difference()
      {
        hull()
        {
          translate([0,-(w/2),0])
          border();

          translate([0,-(w/2) + 4.9,0])
          border();
        }
      }
      
      mirror([0,1,0])
      hull()
      {
        translate([0,-(w/2),0])
        border();

        translate([0,-(w/2) + 4.9,0])
        border();
      }
    }

    translate([2,-(w/2) + 2,0])
    cube([roadlength-4,3,14]);

    mirror([0,1,0])
    translate([2,-(w/2) + 2,0])
    cube([roadlength-4,3,14]);

    translate([2,1,0])
    cube([roadlength-4,14,6]);

    translate([2,1 + 14 + 2,0])
    cube([roadlength-4,14,6]);

    mirror([0,1,0])
    {
      translate([2,1,0])
      cube([roadlength-4,14,6]);

      translate([2,1 + 14 + 2,0])
      cube([roadlength-4,14,6]);
    }
  }
}

module border()
{
  translate([0,0 + 1,1])
  sphere(r=1);

  translate([roadlength,1,1])
  sphere(r=1);

  translate([0,1,15.5])
  sphere(r=1);

  translate([roadlength,1,15.5])
  sphere(r=1);
}

startpiece();

road();

endpiece();