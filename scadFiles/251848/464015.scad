// Material thickness
thickness = 3;
// How much extra to remove from parts which fit together
kerf = 0.15;
// The thickness of each slot.  Should be wider width of the cable, but narrower than the plug.
slot_width = 5.5;
// How many slots to add
slots = 15;

// The angle between the back and the holder
angle = 60;

// The overall width
width = 390;
// The height of the back.  This will go against the wall.
back_height = 80;
// How deep the bit the cables go in is
holder_height = 80;
// How deep the slots are
slot_length = 50;
// How far to leave beneath the holder on the sides.  Also affects
// the edge radius. 2* the material thickness is probably good.
holder_beneath = 6;
// The distance between the holder and the back, measured along the
// holder.  It needs to be at least the width of the back.
holder_offset = 3 * thickness / sin(angle);

tines = slots + 1;
tine_width = (width - (slots * slot_width)) / (slots - 1);
slot_spacing = width / (slots + 1);

kerf_h = kerf / 2;

module end_notches(height) {
  // The holders at the end
  for (x = [0, width - thickness - kerf_h]) {
    translate([x, 0, 0])
      square([thickness + kerf_h, height / 6 + kerf_h]);
    translate([x, height * 5/6, 0])
      square([thickness + kerf_h, height / 6 + kerf_h]);
  }
}

// Cable part ---------------------------
module holder() {
  difference() {
    // The base
    square([width, holder_height]);
    // The slots
    for (slot = [0:slots-1]) { 
      assign(slot_x = (slot+1) * slot_spacing) {
        hull() {
          translate([slot_x, holder_height - slot_length, 0]) 
            circle(r=slot_width/2); // does d= have a bug?
          translate([slot_x, holder_height, 0]) 
            circle(r=slot_width/2);
        }
        translate([slot_x, holder_height, 0])
          scale([1, 2, 1])
          circle(r=slot_width * 0.8);
      }
    }
    end_notches(holder_height);
  }
}

module back() {
  difference() {
    square([width, back_height]);
    end_notches(back_height);
  }
}

module side() {
  translate([holder_beneath, holder_beneath, 0])
    difference() {
      minkowski() {
        polygon(points=[
          [0, back_height], 
          [0, 0], 
          [sin(angle) * (holder_height + holder_offset), 
            cos(angle) * (holder_height + holder_offset)]
        ]);
        circle(r=holder_beneath);
      }
      translate([-holder_beneath, back_height / 6 - kerf_h, 0])
        square([thickness + kerf_h, (back_height * 4 / 6) + 2 * kerf_h]);
      rotate([0, 0, -angle])
      translate([-thickness, 
          (holder_height / 6) - 2 * kerf_h + holder_offset, 0])
        square([thickness + kerf_h * 2, (holder_height * 4 / 6) + kerf_h * 2]);
  }
}

holder();
translate([0, holder_height * 1.05, 0]) back();
translate([0, holder_height + back_height * 1.1, 0]) 
  side();
translate([holder_height + holder_offset + holder_beneath, holder_height + back_height * 1.1, 0]) 
  side();
