// THINGIVERSE VARIABLES
// Polygon quality slider (less is faster)
quality_numerical_slider=15; // [10:20]
//Select sets
text_drop_down_box = "all"; // [all,alphabetic,numeric,symbols,functions,commands]
// Thickness of the bottom base in mm
baseHeight_text_box = 0.4;
// Key Size in mm
keySize_text_box = 9.5;
// Key corner rounding radius in mm (min 2.2)
cornerRadius_text_box = 2.2;
// Braille scale Multiplier
brailleScale_text_box = 1;

$fn=quality_numerical_slider;                   // Quality
baseHeight=baseHeight_text_box;           //Base Height mm
keySize=keySize_text_box;               //Base Size mm^2
cornerRadius = cornerRadius_text_box;         // How round to make the corners?
scaleBraille = brailleScale_text_box;

// Braille medical standards
std_a = 2.5*scaleBraille;    // Horzontal dot to dot
std_b = 2.5*scaleBraille;    // vertical dot to dot
std_c = 6*scaleBraille;      // from cell to cell
std_d = 2.5*scaleBraille;    // from cell to cell with single space between
std_e = 10*scaleBraille;     // line spacing
std_f = 0.3*scaleBraille;    // raised Height
std_g = 1.4*scaleBraille;    // Dot Size

dotRadius = .7;          // Dot Size Multiplier
dotDepth = 1;// How much to raise the braille mm
_0=[0,0,0];     // Per dot | Depth, Size, Offset
_1 = [dotDepth/2,dotRadius/.5,dotRadius*.3];
_2 = [dotDepth,dotRadius,0];


blank = [_0,_0,_0,_0,_0,_0];        // Selecting per dot settings above
//    1  2  3  4  5  6
a = [_2,_1,_1,_1,_1,_1];
b = [_2,_2,_1,_1,_1,_1];
c = [_2,_1,_1,_2,_1,_1];
d = [_2,_1,_1,_2,_2,_1];
e = [_2,_1,_1,_1,_2,_1];
f = [_2,_2,_1,_2,_1,_1];
g = [_2,_2,_1,_2,_2,_1];
h = [_2,_2,_1,_1,_2,_1];
i = [_1,_2,_1,_2,_1,_1];
j = [_1,_2,_1,_2,_2,_1];
k = [_2,_1,_2,_1,_1,_1];
l = [_2,_2,_2,_1,_1,_1];
m = [_2,_1,_2,_2,_1,_1];
n = [_2,_1,_2,_2,_2,_1];
o = [_2,_1,_2,_1,_2,_1];
p = [_2,_2,_2,_2,_1,_1];
q = [_2,_2,_2,_2,_2,_1];
r = [_2,_2,_2,_1,_2,_1];
s = [_1,_2,_2,_2,_1,_1];
t = [_1,_2,_2,_2,_2,_1];
u = [_2,_1,_2,_1,_1,_2];
v = [_2,_2,_2,_1,_1,_2];
w = [_1,_2,_1,_2,_2,_2];
x = [_2,_1,_2,_2,_1,_2];
y = [_2,_1,_2,_2,_2,_2];
z = [_2,_1,_2,_1,_2,_2];
//     1  2  3  4  5  6
numbersign = [_1,_1,_2,_2,_2,_2];
n1 = [_2,_1,_1,_1,_1,_1];
n2 = [_2,_2,_1,_1,_1,_1];
n3 = [_2,_1,_1,_2,_1,_1];
n4 = [_2,_1,_1,_2,_2,_1];
n5 = [_2,_1,_1,_1,_2,_1];
n6 = [_2,_2,_1,_2,_1,_1];
n7 = [_2,_2,_1,_2,_2,_1];
n8 = [_2,_2,_1,_1,_2,_1];
n9 = [_1,_2,_1,_2,_1,_1];
n0 = [_1,_2,_1,_2,_2,_1];

// Special Keys
//           1  2  3  4  5  6
period   = [_1,_1,_2,_1,_1,_1]; // .
comma    = [_1,_2,_1,_1,_1,_1]; // ,
semi     = [_1,_2,_2,_1,_1,_1]; // ;
colon    = [_1,_2,_1,_1,_2,_1]; // :
bracket1 = [_1,_2,_2,_1,_2,_2]; // (
bracket2 = [_1,_2,_2,_1,_2,_2]; // )
minus    = [_1,_1,_2,_1,_1,_2]; // -
fslash   = [_1,_1,_2,_2,_1,_1]; // /
numPoint = [_1,_2,_1,_1,_1,_1]; // 0.0
letter   = [_1,_1,_1,_1,_2,_2]; // letter
accented = [_1,_1,_1,_2,_1,_1]; // accented letter

alphabet=[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z];

numbers=[n1,n2,n3,n4,n5,n6,n7,n8,n9,n0];

symbols=[period,comma,semi,colon,bracket1,bracket2,minus,fslash];

controlKey = [c,t];
altKey = [a,l];
cmdKey = [c,m];
spacebar = [s,b];
shiftKey = [s,h];
capslock = [c,l];
up = [u,p];
down = [d,n];
left = [l,t];
right = [r,t];
returnKey = [r,n];
esc = [e,s];
tab = [t,b];
tilde = [t,i];
backspace = [b,k];
del = [d,l];

commands=[controlKey,altKey,cmdKey,spacebar,shiftKey,capslock,up,down,left,right,returnKey,esc,tab,tilde,backspace,del];

/*test
for (i=[0:10]){
        translate([i,0,0]){      // eh ?
            translate([i*keySize,0,0]){
                backplate();
                intersection() {
                    Char_display_single(alphabet[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }

            }
        }
    }
*///test

// LETTER KEYS
if(text_drop_down_box == "alphabetic" || text_drop_down_box == "all"){
    for (i=[0:10]){
        translate([i,0,0]){      // eh ?
            translate([i*keySize,0,0]){
                backplate();
                intersection() {
                    Char_display_single(alphabet[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }

            }
        }
    }
    for (i=[11:20]){
        translate([i-11,-2,0]){      // eh ?
            translate([(i-11)*keySize,-keySize,0]){
                backplate();
                intersection() {
                    Char_display_single(alphabet[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }
            }
        }
    }
    for (i=[21:25]){
        translate([i-21,-4,0]){      // eh ?
            translate([(i-21)*keySize,-keySize*2,0]){
                backplate();
                intersection() {
                    Char_display_single(alphabet[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }
            }
        }
    }
}

// NUMBER KEYS
if(text_drop_down_box == "numeric" || text_drop_down_box == "all"){
    for (i=[0:len(numbers)-1]){
        translate([i,-6,0]){      // eh ?
            translate([i*keySize,-keySize*3,0]){
                backplate();
                intersection() {
                    Char_display_standard2(numbersign,numbers[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }
                
            }
        }
    }
}



// SYMBOL KEYS
if(text_drop_down_box == "symbols" || text_drop_down_box == "all"){
    for (i=[0:len(symbols)-1]){
        translate([i,-8,0]){      // eh ?
            translate([i*keySize,-keySize*4,0]){
                backplate();
                intersection() {
                    Char_display_single(symbols[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }
                
            }
        }
    }
}

// FUNCTION KEYS
if(text_drop_down_box == "functions" || text_drop_down_box == "all"){
    for (i=[0:len(numbers)-1]){
        translate([i,-10,0]){      // eh ?
            translate([i*keySize,-keySize*5,0]){
                backplate();
                intersection() {
                    Char_display_standard2(f,numbers[i]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }
                
            }
        }
    }
}

// COMMAND KEYS
if(text_drop_down_box == "commands" || text_drop_down_box == "all"){
    for (i=[0:len(commands)-1]){
        translate([i,-12,0]){      // eh ?
            translate([i*keySize,-keySize*6,0]){
                backplate();
                intersection() {
                    Char_display_standard2(commands[i][0],commands[i][1]);
                    translate([0,0,-baseHeight/100])scale([1,1,10*scaleBraille]) backplate();
                }
                
            }
        }
    }
}


module backplate(){
    translate([cornerRadius,cornerRadius,0]){
        minkowski(){
            wtf = keySize-cornerRadius*2;
            cube(size=[wtf,wtf,0.1]);
            cylinder(h=baseHeight,r=cornerRadius);
        }
    }
}

module placeDot (placeX, placeY, dotSize, dotHeight) {
    translate([placeX,placeY,baseHeight]){
        sphere(r=dotRadius*scaleBraille/dotSize);
    }
}



module Char_display_single(glyph1){
    for (i=[0:2]){
        placeDot(((keySize/2)-((std_a)*.5))+glyph1[i][2],
            ((keySize*.5)+((std_a))-i*(std_a))-glyph1[i][2],
            glyph1[i][1],
            glyph1[i][1]);
    }
    for (i=[3:5]){
        placeDot(((keySize/2)+((std_a)*.5))+glyph1[i][2],
            ((keySize*.5)+((std_a))-(i-3)*(std_a))-glyph1[i][2],
            glyph1[i][1],
            glyph1[i][1]);
    }
}

module Char_display_standard2(glyph1,glyph2){
    for (i=[0:2]){
        placeDot(((keySize/2)-(std_a*1.5))+glyph1[i][2],((keySize*.5)+(std_a)-i*std_a)-glyph1[i][2],glyph1[i][1],glyph1[i][1]);
    }
    for (i=[3:5]){
        placeDot(((keySize/2)-(std_a*.5))+glyph1[i][2],((keySize*.5)+(std_a)-(i-3)*std_a)-glyph1[i][2],glyph1[i][1],glyph1[i][1]);
    }


        for (i=[0:2]){
        placeDot(((keySize/2)+(std_a)*.5)+glyph2[i][2],((keySize*.5)+(std_a)-i*std_a)-glyph2[i][2],glyph2[i][1],glyph2[i][1]);
    }
    for (i=[3:5]){
        placeDot(((keySize/2)+(std_a)*1.5)+glyph2[i][2],((keySize*.5)+(std_a)-(i-3)*std_a)-glyph2[i][2],glyph2[i][1],glyph2[i][1]);
    }
}
