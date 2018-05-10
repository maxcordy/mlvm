// Customizable Pixel Beads Photo Panel
// preview[view:south, tilt:top];

/* [Global] */
// The linear extrusion takes a lot of time, which disables the preview in Customizer. Modify your settings in Preview mode, then switch to Compile before you finish. The "thickness" setting will not have any effect in Preview mode.
mode = "Preview"; // [Preview, Compile]

/* [Image] */

// Picture is reduced to 20x20. You may wish to crop and resize it manually before uploading. Check "Invert Colors".
picture = [0.459,0.322,0.659,1.000,0.988,0.984,0.965,0.902,0.871,0.871,0.878,0.529,0.514,0.784,0.941,0.980,0.996,0.580,0.067,0.275,0.329,0.294,0.733,1.000,0.957,0.976,0.980,0.941,0.820,0.824,0.549,0.129,0.165,0.302,0.533,0.871,1.000,0.757,0.157,0.349,0.255,0.224,0.745,0.835,0.769,0.933,0.969,0.910,0.839,0.494,0.075,0.071,0.129,0.192,0.290,0.733,0.988,0.902,0.345,0.365,0.220,0.153,0.506,0.580,0.373,0.510,0.749,0.651,0.318,0.047,0.051,0.082,0.118,0.180,0.290,0.678,0.973,0.953,0.365,0.192,0.200,0.118,0.235,0.486,0.365,0.212,0.153,0.098,0.035,0.043,0.039,0.051,0.122,0.251,0.365,0.525,0.867,0.882,0.137,0.102,0.141,0.086,0.220,0.576,0.694,0.694,0.514,0.149,0.047,0.047,0.220,0.475,0.514,0.451,0.490,0.486,0.757,0.878,0.380,0.071,0.157,0.133,0.325,0.533,0.588,0.792,0.808,0.431,0.122,0.129,0.376,0.667,0.659,0.490,0.424,0.459,0.698,0.859,0.522,0.043,0.278,0.196,0.200,0.498,0.749,0.788,0.800,0.545,0.200,0.204,0.412,0.596,0.820,0.749,0.451,0.376,0.584,0.780,0.337,0.020,0.251,0.173,0.173,0.361,0.322,0.384,0.267,0.176,0.125,0.145,0.184,0.204,0.333,0.235,0.165,0.329,0.569,0.690,0.227,0.020,0.173,0.153,0.102,0.290,0.224,0.106,0.078,0.086,0.082,0.102,0.078,0.063,0.071,0.055,0.149,0.349,0.620,0.447,0.094,0.016,0.165,0.122,0.071,0.212,0.251,0.102,0.075,0.125,0.067,0.075,0.098,0.035,0.035,0.078,0.220,0.412,0.412,0.188,0.020,0.008,0.141,0.098,0.063,0.106,0.302,0.173,0.114,0.204,0.102,0.137,0.204,0.082,0.067,0.114,0.294,0.431,0.075,0.000,0.016,0.024,0.173,0.122,0.086,0.067,0.329,0.286,0.137,0.251,0.467,0.522,0.420,0.106,0.122,0.196,0.365,0.376,0.071,0.024,0.051,0.063,0.204,0.145,0.106,0.055,0.239,0.345,0.271,0.180,0.235,0.306,0.141,0.247,0.220,0.247,0.357,0.298,0.055,0.031,0.039,0.071,0.173,0.110,0.075,0.035,0.078,0.329,0.306,0.471,0.459,0.369,0.486,0.424,0.208,0.243,0.373,0.314,0.016,0.031,0.055,0.094,0.094,0.075,0.047,0.027,0.000,0.176,0.318,0.271,0.341,0.318,0.275,0.129,0.188,0.306,0.553,0.408,0.075,0.043,0.078,0.125,0.094,0.082,0.063,0.043,0.008,0.004,0.184,0.224,0.125,0.110,0.075,0.149,0.345,0.592,0.757,0.533,0.180,0.129,0.094,0.157,0.094,0.090,0.082,0.039,0.020,0.000,0.012,0.408,0.294,0.165,0.235,0.431,0.678,0.773,0.804,0.761,0.224,0.118,0.184,0.145,0.102,0.125,0.129,0.055,0.031,0.016,0.000,0.537,0.784,0.675,0.682,0.737,0.769,0.729,0.604,0.529,0.298,0.184,0.294,0.106,0.125,0.118,0.133,0.086,0.063,0.031,0.024,0.608,0.871,0.827,0.776,0.784,0.776,0.435,0.251,0.318,0.314,0.290,0.231,0.145]; // [image_array:20x20]

panel_shape = 1; // [0:Square, 1:Circle]

// Border width relative to unit pixel size.
border_width = 1;

// Image thickness relative to unit pixel size.
thickness = 0.5;

/* [Pixels] */

// Circular and octangular pixels are slower to generate than diamonds.
pixel_shape = 4; // [4:Diamond, 8:Octagon, 16:Circle]

// Orientation of strands connecting pixels.
orientation = 1; // [0:Horizontal, 1:Vertical]

// The proportion of each pixel's width reserved for the support grid.
grid_size = 0.3;

// The proportion of each pixel's width used to represent variation between white and black pixel values. Pixel size and grid size should never add up to exactly 1; sums > 1 allow overlap between neighboring strands, while values <1 ensure there is always a gap.
pixel_size = 0.699;

// Elongation is applied to pixel size along strands; it can yield more continuous shapes. Set to 0 to prevent overlap.
pixel_elongation = 1;

/* [Hidden] */

width = 20;
height = 20;
size = width * height;

function px(i) = i % width;
function py(i) = floor(i / width);
function pv(i) = (pixel_size * picture[i]) + grid_size;
function flipy(y) = height - 1 - y;

if (mode == "Preview") PanelSurface();
else linear_extrude(height=thickness) PanelSurface();

module PanelSurface() {
  intersection() {
    Image();
    Shape();
  }
  Border();
}

module Border() {
  difference() {
    Shape(border_width);
    Shape(0);
  }
}

// The image is clipped to this shape.
module Shape(padding=0) {
  if (panel_shape == 0) {
    translate([-padding, -padding])
    square([width-1+(padding*2), height-1+(padding*2)]);
  }
  else {
    translate([(width-1)/2, (height-1)/2])
    scale([width-1+(padding*2), height-1+(padding*2)])
    circle(r=0.5, $fn=30);
  }
}

// The image module combines the actual bitmap pixels with the support grid.
module Image() {
  Bitmap();
  Grid(orientation);
}

// The grid module defines a sequence of uniform size rectangular strips,
// intended as supports to ensure the bitmap pixels are located correctly.
// The boolean vertical parameter determines the strip orientation.
module Grid(vertical) {
  if (vertical == 1) {
    for (i = [0 : width - 1]) {
      translate([i - (grid_size/2), 0])
      square([grid_size, height-1]);
    }
  }
  else if (vertical == 0) {
    for (i = [0 : height - 1]) {
      translate([0, flipy(i) - (grid_size/2)])
      square([width-1, grid_size]);
    }
  }
}

// The bitmap module iterates through every element in the picture array
// and uses the pixel module to draw a pixel object at each bitmap location.
// Pixel size is scaled in one dimension according to brightness.
// (Size may also be scaled in perpendicular direction along strands if elongation is nonzero.)
// (Bonus idea: instead of iterating through the picture array, let the user
// draw a path with a draw_polygon widget, then sample the bitmap at path point,
// and connect pixels with segments from drawn path instead of uniform grid.)
module Bitmap() {
  for (i = [0 : size-1]) {
    assign(x = px(i), y = flipy(py(i)), v = pv(i)) {
      Pixel(x, y,
          (orientation == 0 ? 1 + (pixel_elongation * v) : v),
          (orientation == 1  ? 1 + (pixel_elongation * v) : v));
    }
  }
}

// The pixel module places a "pixel" shape centered at coordinates x, y.
// The pixel is scaled to width and height given by w, h.
module Pixel(x, y, w, h) {
  translate([x, y])
  scale([w, h])
  // pixel is created with unit diameter to facilitate easy scaling
  circle(r=0.5, center=true, $fn = pixel_shape);
}
