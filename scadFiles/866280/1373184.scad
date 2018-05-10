// Customizable Map for board game Blokus3D
// Version 1.0, 2015-06-05 by 3DWilson@Thingiverse 

// preview[view:south east, tilt:top diagonal]

/* [A] */

A1 = 1; //[1:Yes, 0:No]
A2 = 1; //[1:Yes, 0:No]
A3 = 1; //[1:Yes, 0:No]
A4 = 1; //[1:Yes, 0:No]
A5 = 1; //[1:Yes, 0:No]
A6 = 1; //[1:Yes, 0:No]
A7 = 1; //[1:Yes, 0:No]
A8 = 1; //[1:Yes, 0:No]

/* [B] */

B1 = 1; //[1:Yes, 0:No]
B2 = 1; //[1:Yes, 0:No]
B3 = 1; //[1:Yes, 0:No]
B4 = 1; //[1:Yes, 0:No]
B5 = 1; //[1:Yes, 0:No]
B6 = 1; //[1:Yes, 0:No]
B7 = 1; //[1:Yes, 0:No]
B8 = 1; //[1:Yes, 0:No]

/* [C] */

C1 = 1; //[1:Yes, 0:No]
C2 = 1; //[1:Yes, 0:No]
C3 = 1; //[1:Yes, 0:No]
C4 = 1; //[1:Yes, 0:No]
C5 = 1; //[1:Yes, 0:No]
C6 = 1; //[1:Yes, 0:No]
C7 = 1; //[1:Yes, 0:No]
C8 = 1; //[1:Yes, 0:No]

/* [D] */

D1 = 1; //[1:Yes, 0:No]
D2 = 1; //[1:Yes, 0:No]
D3 = 1; //[1:Yes, 0:No]
D4 = 1; //[1:Yes, 0:No]
D5 = 1; //[1:Yes, 0:No]
D6 = 1; //[1:Yes, 0:No]
D7 = 1; //[1:Yes, 0:No]
D8 = 1; //[1:Yes, 0:No]

/* [E] */

E1 = 1; //[1:Yes, 0:No]
E2 = 1; //[1:Yes, 0:No]
E3 = 1; //[1:Yes, 0:No]
E4 = 1; //[1:Yes, 0:No]
E5 = 1; //[1:Yes, 0:No]
E6 = 1; //[1:Yes, 0:No]
E7 = 1; //[1:Yes, 0:No]
E8 = 1; //[1:Yes, 0:No]

/* [F] */

F1 = 1; //[1:Yes, 0:No]
F2 = 1; //[1:Yes, 0:No]
F3 = 1; //[1:Yes, 0:No]
F4 = 1; //[1:Yes, 0:No]
F5 = 1; //[1:Yes, 0:No]
F6 = 1; //[1:Yes, 0:No]
F7 = 1; //[1:Yes, 0:No]
F8 = 1; //[1:Yes, 0:No]

/* [G] */

G1 = 1; //[1:Yes, 0:No]
G2 = 1; //[1:Yes, 0:No]
G3 = 1; //[1:Yes, 0:No]
G4 = 1; //[1:Yes, 0:No]
G5 = 1; //[1:Yes, 0:No]
G6 = 1; //[1:Yes, 0:No]
G7 = 1; //[1:Yes, 0:No]
G8 = 1; //[1:Yes, 0:No]

/* [H] */

H1 = 1; //[1:Yes, 0:No]
H2 = 1; //[1:Yes, 0:No]
H3 = 1; //[1:Yes, 0:No]
H4 = 1; //[1:Yes, 0:No]
H5 = 1; //[1:Yes, 0:No]
H6 = 1; //[1:Yes, 0:No]
H7 = 1; //[1:Yes, 0:No]
H8 = 1; //[1:Yes, 0:No]


/* [Map] */

// A-D is used in the board game.
map_name            = "E";  //["E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

two_player_height   = 2;    //[1:20]
three_player_height = 5;    //[1:20]
four_player_height  = 6;    //[1:20]

// Original = 2mm, Thin = 1mm.
thickness           = 2.0;  //[1.0:Thin, 2.0:Original]

//Adjust map size, if it does not fit exactly.
adjustment          = 0.4;  //[0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]


/* [Hidden] */

map_outer_length    = 149.0;
map_frame_length    = 133.5;
map_inner_length    = 118.0;
map_x               = map_outer_length-adjustment;
map_y               = map_outer_length-adjustment;
map_z               = thickness;

block_outer_length  = 15.0;
block_x             = block_outer_length+adjustment;
block_y             = block_outer_length+adjustment;
block_z             = thickness*3;
block_step          = map_inner_length/8; //14.75

hint_x              = block_outer_length-1.0;
hint_y              = block_outer_length-1.0;
hint_z              = thickness;

map_name_x          = -map_frame_length/2;
map_name_y          = map_frame_length/2;
map_name_z          = thickness;

player2_label_x     = -60;
player2_x           = -46;
player3_label_x     = -18;
player3_x           = 3;
player4_label_x     = 30;
player4_x           = 58;
player_all_y        = -map_frame_length/2;
player_all_z        = thickness;

list_rows           = [3.5, 2.5, 1.5, 0.5, -0.5, -1.5, -2.5, -3.5];
list_columns        = [-3.5, -2.5, -1.5, -0.5, 0.5, 1.5, 2.5, 3.5];
list_A              = [A1, A2, A3, A4, A5, A6, A7, A8];
list_B              = [B1, B2, B3, B4, B5, B6, B7, B8];
list_C              = [C1, C2, C3, C4, C5, C6, C7, C8];
list_D              = [D1, D2, D3, D4, D5, D6, D7, D8];
list_E              = [E1, E2, E3, E4, E5, E6, E7, E8];
list_F              = [F1, F2, F3, F4, F5, F6, F7, F8];
list_G              = [G1, G2, G3, G4, G5, G6, G7, G8];
list_H              = [H1, H2, H3, H4, H5, H6, H7, H8];
list_hints          = ["A", "B", "C", "D", "E", "F", "G", "H"];


/* Modules */

module create_blocks(blocks, columns, row) 
    {
        for (i = [0 : 1 : 7])
        {
            if (blocks[i])
            {
                translate([(row*block_step), (columns[i]*block_step), 0]) cube([block_x,block_y,block_z], true);
            }
        }
}


module create_player_symbols(number_of_players, height)
    {
    for (i = [0 : 1 : number_of_players-1])
        {
        translate([i*7, 0, 0]) cylinder(h = height, r = 2.5, center = false, $fn = 36);
    }
}


module create_3d_text(text, h_align, extrude)
    {
    linear_extrude(height = extrude)
            {
            text(str(text), 
                font = "Helvetica:style=Bold", 
                size = 8, 
                halign = h_align, 
                valign = "center");
     }
}


/* Hints */

for (i = [0 : 1 : 7])
        { 
        for (j = [0 : 1 : 7])
            { 
            %translate ([list_columns[i]*block_step ,list_rows[j]*block_step ,-hint_z/2])
                { 
                union ()
                    {
                    cube([hint_x, hint_y, hint_z], true);
                    linear_extrude(height = hint_z)
                        {
                        text(str(list_hints[i], j+1), 
                            font = "Arial", 
                            size = 6, 
                            halign = "center", 
                            valign = "center");
                    }
                }
            }
        }
}


/* Map */

difference ()
    {
    translate([0, 0, map_z/2]) cube([map_x,map_y,map_z], true);
    
    create_blocks(list_A, list_rows, list_columns[0]);
    create_blocks(list_B, list_rows, list_columns[1]);
    create_blocks(list_C, list_rows, list_columns[2]);
    create_blocks(list_D, list_rows, list_columns[3]);
    create_blocks(list_E, list_rows, list_columns[4]);
    create_blocks(list_F, list_rows, list_columns[5]);
    create_blocks(list_G, list_rows, list_columns[6]);
    create_blocks(list_H, list_rows, list_columns[7]);
    
    
    /* Only A1 */
    /*
    if (A1){
    translate([(-3.5*block_step), (3.5*block_step), 0]) cube([block_x,block_y,block_z], true);
    }
    */
    
    
    /* Only A1-8 */
    /*
    for (i = [0 : 1 : 7])
    {
        if (list_A[i])
        {
            translate([(list_columns[0]*block_step), (list_rows[i]*block_step), 0]) cube([block_x,block_y,block_z], true);
        }
    }
    */


    translate([map_name_x, map_name_y, map_name_z/2]) create_3d_text(map_name, "center", map_name_z);
    
    translate([player2_label_x , player_all_y, player_all_z/2]) create_player_symbols(2, player_all_z);
    translate([player3_label_x , player_all_y, player_all_z/2]) create_player_symbols(3, player_all_z);
    translate([player4_label_x , player_all_y, player_all_z/2]) create_player_symbols(4, player_all_z);
    
    translate([player2_x, player_all_y, player_all_z/2]) create_3d_text(two_player_height, "left", player_all_z);
    translate([player3_x, player_all_y, player_all_z/2]) create_3d_text(three_player_height, "left", player_all_z);
    translate([player4_x, player_all_y, player_all_z/2]) create_3d_text(four_player_height, "left", player_all_z);
}

