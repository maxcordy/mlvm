use <../connector/iphone_connector.scad>  // http://www.thingiverse.com/thing:15206

$fn = 100;

holder_height = 70; // desired height of the holder
case_depth = 14; // depth
case_width = 63; // 
holder_front_lip = 3; //
holder_thickness = 3; // overall thickness of the holder
bottom_gap = 3.5; // distance between the bottom of the case and bottom of the holder
bottom_thickness = 3; // keep thick for strength

centerline_device_x = holder_thickness+case_width/2;
centerline_device_y = holder_thickness+case_depth/2;
centerline_device_z = bottom_gap+bottom_thickness+holder_height/2;
total_height = holder_height+bottom_gap+bottom_thickness;

connector_depth = 6; // added some on the 5.65 for clearance
connector_width = 27; // width of the connector and some added fudge_room
connector_fudge = 1; // move the connector forward (+ toward the front of the holder) or backward (- toward the back of the holder

//#translate([centerline_device_x,centerline_device_y,centerline_device_z]) rotate([90,0,0]) cylinder(r=1, h=100, center=true); // debug axis
//#translate([centerline_device_x,centerline_device_y,centerline_device_z]) rotate([0,90,0]) cylinder(r=1, h=100, center=true);
//#translate([centerline_device_x,centerline_device_y,centerline_device_z]) rotate([0,0,90]) cylinder(r=1, h=100, center=true);

difference()
{
  intersection()
  {
    difference()
    {
      cube([holder_thickness*2+case_width,holder_thickness*2+case_depth, total_height]); // initial holder block

      translate([0,0,1]) translate([centerline_device_x,centerline_device_y,centerline_device_z]) cube([case_width, case_depth, holder_height+2], center=true); // device cavity

      translate([0,0,1]) translate([centerline_device_x,0,centerline_device_z]) cube([case_width-2*holder_front_lip, holder_thickness*2.1, holder_height+1], center=true); // front of the case

    }
    
    translate([centerline_device_x,centerline_device_y,-1]) cylinder(r=centerline_device_x,h=total_height+2); // side rounding
    translate([centerline_device_x,centerline_device_y,0]) sphere(r=total_height); // top rounding
    translate([centerline_device_x,centerline_device_y,total_height]) sphere(r=total_height*1.05); // bottom_rounding
    
  }

  //translate([centerline_device_x,centerline_device_y,total_height]) rotate([90,0,0])cylinder(r=case_width/2,h=2*case_depth); // top lip rounding
  
  // connector cutout
  translate([centerline_device_x - connector_depth/2, centerline_device_y-connector_fudge, -1]) union()
  {
    cube([connector_depth, holder_thickness*2+case_depth, connector_width+bottom_gap+bottom_thickness]); // cutout body
    translate([connector_depth/2, 0, 0]) cylinder(r = connector_depth/2, h = connector_width+bottom_gap+bottom_thickness); // connector rounding
    translate([connector_depth/2, holder_thickness*2+case_depth, connector_width+bottom_gap+bottom_thickness]) rotate([90,0,0]) cylinder(r = connector_depth/2, h = holder_thickness*2+case_depth); // top connector rounding
  }
  
  translate([centerline_device_x, centerline_device_y-connector_fudge, bottom_thickness]) iphone_connector();

}

// uncomment to show the connector in the holder
#translate([centerline_device_x, centerline_device_y-connector_fudge, bottom_thickness]) iphone_connector();
  