name = "Your Name Here";
// This scales EVERYTHING proportionately (and may appear to do nothing). NOTE: This is in an unspecified unit, so it depends on the program you use to print. 100mm or 4" is recomended.
keyLength = 100; // [1:1000]
/* [Advanced] */
// This is a multiple of the line width.
minBlankSpace = 10; // [0:100]
// This is the ratio between the diameter and the length of the key. Lower this to allow for a stubbier key with a shorter name.
minWidthRatio = 10; // [2:10]
// This is a multiple of the barrel diameter.
ringSize = 3; // [2:10]
ringScale = 0.75; // [0.5:0.125:1.5]
// The customizer will generate all 3 as seperate files. Use the seperate key & name for dual extrusion.
part = 0; // [0:Full Key, 1:Key Blank, 2:Name]
// Please note that the heart may be somewhat buggy.
ringType = 0; // [0:circle, 1:heart]
/* [Hidden] */
$vpt = [keyLength/2,0,0]; $vpr = [0,0,0]; $vpd = 75;// preview[view:south, tilt:top]
lineSize = 1 / 5;
$fn = 50;
unit = min(keyLength / minWidthRatio, keyLength / (pos() + (minBlankSpace * lineSize) + ringSize - lineSize)); // base unit of measurement
line = unit * lineSize;
if(part < 2){
	translate([keyLength - unit * (ringSize / 2), 0, 0]){ // ring
		if (ringType == 0){
			rotate_extrude(){
				translate([(ringSize - ringScale) / 2 * unit, 0, 0]){
					scale([ringScale, 1]){
						circle(d = unit);
					}
				}
			}
		}
		else if (ringType == 1){
			heart();
		}
	}
	rotate([0, 90, 0]){ // barrel
		difference(){
			if (ringType == 0){
				cylinder(d = unit, h = keyLength - (ringSize - ringScale / 2) * unit);
			}
			else if (ringType == 1){
				cylinder(d = unit, h = keyLength - (ringSize + 1 - ringScale / 2) * unit);
			}
			translate([unit / -2, 0, 0]){
				cube([unit, unit, unit * pos() - line]);
			}
    }
  }
}
if(len(name) > 0 && part % 2 == 0){ // word generator
  for(i = [0:len(name) - 1]){
    translate([unit * pos(i), 0, unit / -2]){
      linear_extrude(unit){
        if(name[i] == "A" || name[i] == "a"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line * 4, 0],[line * 4, line * 2],[line, line * 2],[line, 0],[line, line * 3],[line, line * 4],[line * 4, line * 4],[line * 4, line * 3]], paths = [[0,1,2,3,4,5,6,7],[8,9,10,11]]);
        }
        else if(name[i] == "B" || name[i] == "b"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line, line * 3],[line, line * 4],[line * 4, line * 4],[line * 4, line * 3],[line, line],[line, line * 2],[line * 4, line * 2],[line * 4, line]], paths = [[0,1,2,3],[4,5,6,7],[8,9,10,11]]);
        }
        else if(name[i] == "C" || name[i] == "c"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line * 4],[line, line * 4],[line, line],[unit, line],[unit, 0]]);
        }
        else if(name[i] == "D" || name[i] == "d"){
          polygon([[0, 0],[0, unit],[line * 4, unit],[unit, line * 4],[unit, line],[line * 4, 0],[line, line],[line, line * 4],[line * 4, line * 4],[line * 4, line]], paths = [[0,1,2,3,4,5],[6,7,8,9]]);
        }
        else if(name[i] == "E" || name[i] == "e"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line *4],[line, line * 4],[line, line * 3],[line * 3, line * 3],[line * 3, line * 2],[line, line * 2],[line, line],[unit, line],[unit, 0]]);
        }
        else if(name[i] == "F" || name[i] == "f"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line *4],[line, line * 4],[line, line * 3],[line * 3, line * 3],[line * 3, line * 2],[line, line * 2],[line, 0]]);
        }
        else if(name[i] == "G" || name[i] == "g"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line *4],[line, line * 4],[line, line],[line * 4, line],[line * 4, line * 2],[line * 2, line * 2],[line * 2, line * 3],[unit, line * 3],[unit, 0]]);
        }
        else if(name[i] == "H" || name[i] == "h"){
          polygon([[0, 0],[0, unit],[line, unit],[line, line * 3],[line * 4, line * 3],[line * 4, unit],[unit, unit],[unit, 0],[line * 4, 0],[line * 4, line * 2],[line, line * 2],[line, 0]]);
        }
        else if(name[i] == "I" || name[i] == "i"){
          polygon([[0, 0],[0, unit],[line, unit],[line, 0]]);
        }
        else if(name[i] == "J" || name[i] == "j"){
          polygon([[0, 0],[0, line * 2],[line, line * 2],[line, line],[line * 4, line],[line * 4, unit],[unit, unit],[unit, 0]]);
        }
        else if(name[i] == "K" || name[i] == "k"){
          polygon([[0, 0],[0, unit],[line, unit],[line, line * 3],[line * (3 - sqrt(0.5)), line * 3],[line * (5 - sqrt(0.5)), unit],[unit, unit],[unit, line * (5 - sqrt(0.5))],[line * (2.5 + sqrt(0.5)), unit / 2],[unit, line * sqrt(0.5)],[unit, 0],[line * (5 - sqrt(0.5)), 0],[line * (3 - sqrt(0.5)), line * 2],[line, line * 2],[line, 0]]);
        }
        else if(name[i] == "L" || name[i] == "l"){
          polygon([[0, 0],[0, unit],[line, unit],[line, line],[unit, line],[unit, 0]]);
        }
        else if(name[i] == "M" || name[i] == "m"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line * 4, 0],[line * 4, line * 4],[line * 3, line * 4],[line * 3, 0],[line * 2, 0],[line * 2, line * 4],[line, line * 4],[line, 0]]);
        }
        else if(name[i] == "N" || name[i] == "n"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line * 4, 0],[line * 4, line * 4],[line, line * 4],[line, 0]]);
        }
        else if(name[i] == "O" || name[i] == "o"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line, line],[line, line * 4],[line * 4, line * 4],[line * 4, line]], paths = [[0,1,2,3],[4,5,6,7]]);
        }
        else if(name[i] == "P" || name[i] == "p"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line * 2],[line, line * 2],[line, 0],[line, line * 3],[line, line * 4],[line * 4, line * 4],[line * 4, line * 3]], paths = [[0,1,2,3,4,5],[6,7,8,9]]);
        }
        else if(name[i] == "Q" || name[i] == "q"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line, line],[line, line * 4],[line * 4, line * 4],[line * 4, line * (1 + sqrt(0.5))],[line * (2 + sqrt(0.5)), line * 3],[line * 2, line * 3],[line * 2, line * (3 - sqrt(0.5))],[line * (4 - sqrt(0.5)), line]], paths = [[0,1,2,3],[4,5,6,7,8,9,10,11]]);
        }
        else if(name[i] == "R" || name[i] == "r"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line * 2],[line * (3 + sqrt(0.5)), line * 2],[unit, line * sqrt(0.5)],[unit, 0],[line * (5 - sqrt(0.5)), 0],[line * (3 - sqrt(0.5)), line * 2],[line, line * 2],[line, 0],[line, line * 3],[line, line * 4],[line * 4, line * 4],[line * 4, line * 3]], paths = [[0,1,2,3,4,5,6,7,8,9,10],[11,12,13,14]]);
        }
        else if(name[i] == "S" || name[i] == "s"){
          polygon([[0, 0],[0, line],[line * 4, line],[line * 4, line * 2],[0, line * 2],[0, unit],[unit, unit],[unit, line * 4],[line, line * 4],[line, line * 3],[unit, line * 3],[unit, 0]]);
        }
        else if(name[i] == "T" || name[i] == "t"){
          polygon([[0, line * 4],[0, unit],[unit, unit],[unit, line * 4],[line * 3, line * 4],[line * 3, 0],[line * 2, 0],[line * 2, line * 4]]);
        }
        else if(name[i] == "U" || name[i] == "u"){ 
          polygon([[0, 0],[0, unit],[line, unit],[line, line],[line * 4, line],[line * 4, unit],[unit, unit],[unit, 0]]);
        }
        else if(name[i] == "V" || name[i] == "v"){
          polygon([[0, line * 2],[0, unit],[line, unit],[line, line * 2.5],[line * 2.5, line],[line * 4, line * 2.5],[line * 4, unit],[unit, unit],[unit, line * 2],[line * 3, 0],[line * 2, 0]]);
        }
        else if(name[i] == "W" || name[i] == "w"){
          polygon([[0, 0],[0, unit],[line, unit],[line, line],[line * 2, line],[line * 2, line * 4],[line * 3, line * 4],[line * 3, line],[line * 4, line],[line * 4, unit],[unit, unit],[unit, 0]]);
        }
        else if(name[i] == "X" || name[i] == "x"){
          polygon([[0, 0],[0, line * sqrt(0.5)],[line * (2.5 - sqrt(0.5)), unit / 2],[0, line * (5 - sqrt(0.5))],[0, unit],[line * sqrt(0.5), unit],[unit / 2, line * (2.5 + sqrt(0.5))],[line * (5 - sqrt(0.5)), unit],[unit, unit],[unit, line * (5 - sqrt(0.5))],[line * (2.5 + sqrt(0.5)), unit / 2],[unit, line * sqrt(0.5)],[unit, 0],[line * (5 - sqrt(0.5)), 0],[unit / 2, line * (2.5 - sqrt(0.5))],[line * sqrt(0.5), 0]]);
        }
        else if(name[i] == "Y" || name[i] == "y"){
          polygon([[0, line * 2],[0, unit],[line, unit],[line, line * 3],[line * 4, line * 3],[line * 4, unit],[unit, unit],[unit, line * 2],[line * 3, line * 2],[line * 3, 0],[line * 2, 0],[line * 2, line * 2]]);
        }
        else if(name[i] == "Z" || name[i] == "z"){
          polygon([[0, 0],[0, line],[line * 3.5, line * 4],[0, line * 4],[0, unit],[unit, unit],[unit, line * 4],[line * 1.5, line],[unit, line],[unit, 0]]); 
        }
        else if(name[i] == "0"){ 
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line, line],[line, line * 4],[line * 4, line * 4],[line * 4, line]], paths = [[0,1,2,3],[4,5,6,7]]);
        }
        else if(name[i] == "1"){
          polygon([[0, 0],[0, line],[line, line],[line, line * 4],[0, line * 4],[0, unit],[line * 2, unit],[line * 2, line],[line * 3, line],[line * 3, 0]]);
        }
        else if(name[i] == "2"){
          polygon([[0, 0],[0, line * 3],[line * 4, line * 3],[line * 4, line * 4],[0, line * 4],[0, unit],[unit, unit],[unit, line * 2],[line, line * 2],[line, line],[unit, line],[unit, 0]]);
        }
        else if(name[i] == "3"){
          polygon([[0, 0],[0, line],[line * 4, line],[line * 4, line * 2],[line, line * 2],[line, line * 3],[line * 4, line * 3],[line * 4, line * 4],[0, line * 4],[0, unit],[unit, unit],[unit, 0]]);
        }
        else if(name[i] == "4"){
          polygon([[0, line * 2],[0, unit],[line, unit],[line, line * 3],[line * 4, line * 3],[line * 4, unit],[unit, unit],[unit, 0],[line * 4, 0],[line * 4, line * 2]]);
        }
        else if(name[i] == "5"){
          polygon([[0, 0],[0, line],[line * 4, line],[line * 4, line * 2],[0, line * 2],[0, unit],[unit, unit],[unit, line * 4],[line, line * 4],[line, line * 3],[unit, line * 3],[unit, 0]]);
        }
        else if(name[i] == "6"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, line * 4],[line, line * 4],[line, line * 3],[unit, line * 3],[unit, 0],[line, line],[line, line * 2],[line * 4, line * 2],[line * 4, line]], paths = [[0,1,2,3,4,5,6,7],[8,9,10,11]]);
        }
        else if(name[i] == "7"){
          polygon([[0, line * 4],[0, unit],[unit, unit],[unit, 0],[line * 4, 0],[line * 4, line * 4]]);
        }
        else if(name[i] == "8"){
          polygon([[0, 0],[0, unit],[unit, unit],[unit, 0],[line, line * 3],[line, line * 4],[line * 4, line * 4],[line * 4, line * 3],[line, line],[line, line * 2],[line * 4, line * 2],[line * 4, line]], paths = [[0,1,2,3],[4,5,6,7],[8,9,10,11]]);
        }
        else if(name[i] == "9"){
          polygon([[0, 0],[0, line],[line * 4, line],[line * 4, line * 2],[0, line * 2],[0, unit],[unit, unit],[unit, 0],[line, line * 3],[line, line * 4],[line * 4, line * 4],[line * 4, line * 3]], paths = [[0,1,2,3,4,5,6,7],[8,9,10,11]]);
        }
        else if(name[i] == "/"){
          polygon([[0, 0],[0, line * sqrt(0.5)],[line * (5 - sqrt(0.5)), unit],[unit, unit],[unit, line * (5 - sqrt(0.5))],[line * sqrt(0.5), 0]]);
        }
        else if(name[i] == "\\"){
          polygon([[0, line * (5 - sqrt(0.5))],[0, unit],[line * sqrt(0.5), unit],[unit, line * sqrt(0.5)],[unit, 0],[line * (5 - sqrt(0.5)), 0]]);
        }
        else if(name[i] == "+"){
          polygon([[0, line * 2],[0, line * 3],[line * 2, line * 3],[line * 2, unit],[line * 3, unit], [line * 3, line * 3],[unit, line * 3],[unit, line * 2],[line * 3, line * 2],[line * 3, 0],[line * 2, 0],[line * 2, line * 2]]);
        }
        else if(name[i] == "#"){
          polygon([[0, line],[0, line * 2],[line, line * 2],[line, line * 3],[0, line * 3],[0, line * 4],[line, line * 4],[line, unit],[line * 2, unit],[line * 2, line * 4],[line * 3, line * 4],[line * 3, unit],[line * 4, unit],[line * 4, line * 4],[unit, line * 4],[unit, line * 3],[line * 4, line * 3],[line * 4, line * 2],[unit, line * 2],[unit, line],[line * 4, line],[line * 4, 0],[line * 3, 0],[line * 3, line],[line * 2, line],[line * 2, 0],[line, 0],[line, line],[line * 2, line * 2],[line * 2, line * 3],[line * 3, line * 3],[line * 3, line * 2]], paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27],[28,29,30,31]]);
        }
        else if(name[i] == "["){
          polygon([[0, 0],[0, unit],[line * 2, unit],[line * 2, line * 4],[line, line * 4],[line, line],[line * 2, line],[line * 2, 0]]);
        }
        else if(name[i] == "]"){
          polygon([[0, 0],[0, line],[line, line],[line, line * 4],[0, line * 4],[0, unit],[line * 2, unit],[line * 2, 0]]);
        }
        else if(name[i] == "{"){
          polygon([[0, line * 2],[0, line * 3],[line, line * 3],[line, unit],[line * 3, unit],[line * 3, line * 4],[line * 2, line * 4],[line * 2, line],[line * 3, line],[line * 3, 0],[line, 0],[line, line * 2]]);
        }
        else if(name[i] == "}"){
          polygon([[0, 0],[0, line],[line, line],[line, line * 4],[0, line * 4],[0, unit],[line * 2, unit],[line * 2, line * 3],[line * 3, line * 3],[line * 3, line * 2],[line * 2, line * 2],[line * 2, 0]]);
        }
        else if(name[i] == "("){
          polygon([[0, line * sqrt(0.5)],[0, line * (5 - sqrt(0.5))],[line * sqrt(0.5), unit],[line * 2, unit],[line * 2, line * 4],[line, line * 4],[line, line],[line * 2, line],[line * 2, 0],[line * sqrt(0.5), 0]]);
        }
        else if(name[i] == ")"){
          polygon([[0, 0],[0, line],[line, line],[line, line * 4],[0, line * 4],[0, unit],[line * (2 - sqrt(0.5)), unit],[line * 2, line * (5 - sqrt(0.5))],[line * 2, line * sqrt(0.5)],[line * (2 - sqrt(0.5)), 0]]);
        }
        else if(name[i] == "."){
          polygon([[0, 0],[0, line],[line, line],[line, 0]]);
        }
        else if(name[i] == "$"){
          polygon([[0, line * 0.5],[0, line * 1.5],[line * 4, line * 1.5],[line * 4, line * 2],[0, line * 2],[0, line * 4.5],[line * 2, line * 4.5],[line * 2, unit],[line * 3, unit],[line * 3, line * 4.5],[unit, line * 4.5],[unit, line * 3.5],[line, line * 3.5],[line, line * 3],[unit, line * 3],[unit, line * 0.5],[line * 3, line * 0.5],[line * 3, 0],[line * 2, 0],[line * 2, line * 0.5]]);
        }
        else if(name[i] == "&"){
          polygon([[0, 0],[0, unit],[line * 3, unit],[line * 3, line * 3], [unit, line * 3],[unit, line * 2],[line * (3 + sqrt(0.5)), line * 2],[unit, line * sqrt(0.5)],[unit, 0],[line * (5 - sqrt(0.5)), 0],[line * 3, line * (2 - sqrt(0.5))],[line * 3, 0],[line, line * 3],[line, line * 4],[line * 2, line * 4],[line * 2, line * 3],[line, line],[line, line * 2],[line * 2, line * 2],[line * 2, line]], paths = [[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15],[16,17,18,19]]);
        }
        else if(name[i] == " "){
          // this space intentionally left blank
        }
      }
    }
  }
}
{function pos(n) = ( // position function
  n == undef ? pos(len(name)) : n == 0 || len(name) == 0 ? 0 : 
    name[n - 1] == "I" || name[n - 1] == "i" || name[n - 1] == "." ? pos(n - 1) + lineSize * 2 :
    name[n - 1] == "[" || name[n - 1] == "]" || name[n - 1] == "(" || name[n - 1] == ")" ? pos(n - 1) + lineSize * 3 :
    name[n - 1] == "1" || name[n - 1] == " " || name[n - 1] == "{" || name[n - 1] == "}" ? pos(n - 1) + lineSize * 4 :
  pos(n - 1) + lineSize * 6
);}
module heart(){
	difference(){
		translate([0, (ringSize / 2 - ringScale) * unit, 0]){
			rotate_extrude(){
				translate([(ringSize - ringScale) / 2 * unit, 0, 0]){
					scale([ringScale, 1]){
						circle(d = unit);
					}
				}
			}
		}
		linear_extrude(unit, center = true){
			polygon([[0, 0],[unit * ringSize / 2, 0],[unit * ringSize / 2, -unit * ringScale],[unit * ringSize / -2, -unit * ringScale],[unit * ringSize / -2, unit * (ringSize - ringScale)],[0, unit * (ringSize / 2 - ringScale)]]);
		}
	}
	difference(){
		translate([0, (ringSize / 2 - ringScale) * unit, 0]){
			rotate([90, 0, -45]){
				translate([unit * (ringSize - ringScale) / -2, 0, 0]){
					linear_extrude(unit * ringSize){
						scale([ringScale, 1]){
							circle(d = unit);
						}
					}
				}
			}
		}
		translate([unit * ringSize * -1.2, unit * ringSize * -1, unit / -2]){
			cube([unit * ringSize, unit * ringSize, unit]);
		}
	}
	
	rotate([180, 0, 0]){
		difference(){
			translate([0, (ringSize / 2 - ringScale) * unit, 0]){
				rotate_extrude(){
					translate([(ringSize - ringScale) / 2 * unit, 0, 0]){
						scale([ringScale, 1]){
							circle(d = unit);
						}
					}
				}
			}
			linear_extrude(unit, center = true){
				polygon([[0, 0],[unit * ringSize / 2, 0],[unit * ringSize / 2, -unit * ringScale],[unit * ringSize / -2, -unit * ringScale],[unit * ringSize / -2, unit * (ringSize - ringScale)],[0, unit * (ringSize / 2 - ringScale)]]);
			}
		}
		difference(){
			translate([0, (ringSize / 2 - ringScale) * unit, 0]){
				rotate([90, 0, -45]){
					translate([unit * (ringSize - ringScale) / -2, 0, 0]){
						linear_extrude(unit * ringSize){
							scale([ringScale, 1]){
								circle(d = unit);
							}
						}
					}
				}
			}
			translate([unit * ringSize * -1.2, unit * ringSize * -1, unit / -2]){
				cube([unit * ringSize, unit * ringSize, unit]);
			}
		}
	}
}