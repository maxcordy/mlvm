//variable description
firstLetter = "A"; //[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z] 
secondLetter = "Z"; //[A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z] 
firstLetterWidth = 10; //[3:13]
secondLetterWidth = 8; //[3:13]
scaleFactor = 1.5; //[1.5,2,2.5]
overallWidth = firstLetterWidth+secondLetterWidth+1.5;
height = 1.5;

scale([scaleFactor,scaleFactor,1]) {
    difference() {        
        cube([overallWidth,11.5,height]);
        # translate([0.75,1,height/2]) {
            linear_extrude(height/2+0.1) {
                text(firstLetter);
            }
        }
        # translate([0.75+firstLetterWidth,1,height/2]) {
            linear_extrude(height/2+0.1) {
                text(secondLetter);
            }
        }
    }
}
