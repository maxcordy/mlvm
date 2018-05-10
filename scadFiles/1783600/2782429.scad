$fn=32;

heighth = 10;
arms = 5;
cable = 2;

difference(){
  linear_extrude(heighth)import("hennispacer.dxf", "Final");
  translate([0,0,heighth-arms])linear_extrude(arms)import("hennispacer.dxf", "mill1");
  translate([0,0,heighth-(arms+cable)])linear_extrude(arms+cable)import("hennispacer.dxf", "mill2");
}