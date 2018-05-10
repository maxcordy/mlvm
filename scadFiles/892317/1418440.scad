/* [Hidden] */
$fa = 2;
$fs = 1;

/* [Parameters] */
//Drive size
drive_size = 3; // [2:1/4,3:3/8,4:1/2]

//The center to center spacing of recepticles
spacing = 20;
//how many rows of sockets?
rows = 2;
//how many columns of sockets?
cols = 3;
//adjust this up if the sockets fit too tight
clearance = 0.3;
//list the socket labels.  Note: right now the customizer only accepts numbers.  sorry :(
txt = ["10","8","7","6","5","4"];

//END PARAMETERS//
/* [Hidden] */

nib_size = drive_size/8*25.4-clearance;
nib_height = 1.25*nib_size;

basethickness = 3;
letter_depth = 1.4;

rRect([spacing*(rows),spacing*(cols),basethickness],3);


for (r = [0.5:1:rows]) {
  for (c = [0.5:1:cols]) {
    difference() {
      translate([r*spacing,c*spacing,basethickness+nib_height/2])
        rRect([nib_size,nib_size,nib_height],drive_size,center = true);
      translate([r*spacing,c*spacing,basethickness+nib_height-letter_depth])
        linear_extrude(letter_depth+0.1)
          text( str(txt[round((cols-1-(c-0.5))*rows+ (r-0.5))]),size=4*drive_size/3,font= "Arial:style=Black",valign="center",
            halign="center");
    };
  }
}


// rectangle with radiused cornerrs
// size - [x,y,z]
// r - radius
// center=false - center the object ar origin? (similar to cube)
module rRect(size, r, center = false)
{
  x = size[0];
  y = size[1];
  z = size[2];
  t = center?[-x/2,-y/2,-z/2]:[0,0,0];
  
  translate(t)
  linear_extrude(height=z)
        hull() {
            translate([r, r, 0])
                circle(r=r);
            translate([x-r, (r), 0])
                circle(r=r);
            translate([ r, y-r, 0])
                circle(r=r);
            translate([x-r, y-r, 0])
                circle(r=r);
        };
}


/*
linear_extrude(height=20)
text(str(7));
*/