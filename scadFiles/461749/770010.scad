// Number of cut lines.
num_lines = 3;

// Gap between lines in a row.
line_gap = 3;

// Number of rows.
rows = 28;

// Width of the output.
width = 60;

// Height of the output.
height = 60;

// Thickness of the line.
line_thickness = .15;

// Calculated with of the line.
line_width = (width - ((num_lines - 1) * line_gap)) / num_lines;

// Calculated spacing between rows.
row_spacing = (height - (rows * line_thickness)) / (rows - 1);

intersection() {
  for (row = [0 : (rows - 1)]) {

    // Even rows
    if (row % 2) {
      for (line = [0 : num_lines]) {
        if (line == 0) {
          translate([(row * (line_thickness + row_spacing)), 0, 0])
            square([line_thickness, ((line_width / 2) - (line_gap / 2))]);
        } else {
          translate([(row * (line_thickness + row_spacing)), ((line * (line_width + line_gap)) - ((line_width + line_gap) / 2)), 0])
            square([line_thickness, line_width]);
        }
      }

    // Odd rows
    } else {
      for (line = [0 : (num_lines - 1)]) {
        translate([(row * (line_thickness + row_spacing)), (line * (line_width + line_gap)), 0])
          square([line_thickness, line_width]);
      }
    }
  }
  square([height, width]);
}
