/*  Stobin. Highly configurable storage bin. 
    Copyright (C) 2016  PMorel for Thilab (www.thilab.fr)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


// Kerf (depends on the tool used to cut the pieces)
kerf=0.1;
// Scale (allows you to make a prototype of your bin. Wood thickness is not affected by the scale)
scale=1;

// Type of bin
type="top"; //[top,bottom,middle]
// Create connectors 
connectors="yes"; //[yes,no]
// Height of the bin
box_height=250;
// Depth of the bin without the opening
box_depth=380;
// Width of the bin
box_width=350;
// Depth off the opening
box_opening_depth=150;
// Opening hole length
box_opening_face_length=220;
// Width of a tooth
box_tooth_width=15;
// Zone where we do not want teeth
box_min_protected_zone=40;

// Wood thickness of the right panel
wood_thickness_right=10;
// Wood thickness of the left panel
wood_thickness_left=10;
// Wood thickness of the bottom panel
wood_thickness_bottom=3;
// Wood thickness of the bottom side
wood_thickness_rear=3;
// Wood thickness of the top panel
wood_thickness_top=10;



/* [Hidden] */

height=box_height*scale;

depth=box_depth*scale;

width=box_width*scale;

opening_depth=box_opening_depth*scale;

opening_face_length=box_opening_face_length*scale;

tooth_width=box_tooth_width*scale;

min_protected_zone=box_min_protected_zone*scale;

// Calculate the length of the underside of the opening 
opening_bottom=sqrt(opening_face_length*opening_face_length-opening_depth*opening_depth);
// 
closing_face_length = sqrt((height-opening_bottom)*(height-opening_bottom)+opening_depth*opening_depth);

angle_opening = atan(opening_depth/(height-opening_bottom));
angle_hinge = angle_opening + 90;

hinge_point_x = wood_thickness_bottom/tan(angle_hinge/2);
hinge_point=[hinge_point_x,wood_thickness_bottom];

p1=[min_protected_zone,wood_thickness_bottom];

angle_pie = (180-angle_hinge/2-90)*2;
dist_center_p1 = distance(hinge_point, p1);

radius_pie = tan(angle_hinge/2)*dist_center_p1;

center_pie=[p1[0],radius_pie+wood_thickness_bottom];

if( type == "middle" )
// middle box with no top and with connectors on the bottom and hollows for the connectors of the box on top of it
    exploded_box(true && (connectors=="yes"), true && (connectors=="yes"));

if( type == "top" )
// Top box with connector on the bottom and a top to close the boxes
    exploded_box_top(false, true && (connectors=="yes"));

if( type == "bottom" )
// bottom box with no connector (papatte) on the bottom
    exploded_box(true && (connectors=="yes"), false);

// creates the little connector between two bins
module papatte(height, width, plain) {
    hull() {
        square([plain, width]);
        translate([0,width/2-height/2])
           square([height, height]);
    }
}


//2D representation of all the pieces without the top panel
module exploded_box(connector_top=false, connector_bottom=false) {

    offset(delta=kerf)
        right_face_with_hinge(connector_top, connector_bottom);

    offset(delta=kerf)
        translate([0,height+15])
            right_face_with_hinge(connector_top, connector_bottom);

    offset(delta=kerf)
        translate([depth+15,0])
            rear_face();

    offset(delta=kerf)
        translate([-opening_depth-20,-width-15,0])
            hinge_bottom_closing();
    
}

//2D representation of all the pieces with the top panel
module exploded_box_top(connector_top=false, connector_bottom=false) {

    offset(delta=kerf)
        right_face_with_hinge(connector_top, connector_bottom);

    offset(delta=kerf)
        translate([0,height+15])
            right_face_with_hinge(connector_top, connector_bottom);

    offset(delta=kerf)
        translate([depth+15,0])
            rear_face(!connector_top);

    offset(delta=kerf)
        translate([-opening_depth-25,-width-15,0])
            hinge_bottom_closing();
    
    offset(delta=kerf)
        translate([0,-2*width-30,0])
            top();
}


// Bottom panel with a flex hinge
module hinge_bottom_closing() {
    
    hingeLength = angle_pie*(2*PI*radius_pie)/360;
    length = (depth-min_protected_zone) + (closing_face_length-min_protected_zone) + hingeLength;
    
    difference() {
        union() {
            square([length, width]);
        }
        union() {
            // closing edge right
            translate([0,wood_thickness_right,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,closing_face_length, false, wood_thickness_right);
            // closing edge left
            translate([0,width,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,closing_face_length, false, wood_thickness_left);
            // bottom edge right
            pos_bottom = closing_face_length+hingeLength-2*min_protected_zone;
            translate([pos_bottom,wood_thickness_right,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,depth, false, wood_thickness_right);
            // bottom edge left
            translate([pos_bottom,width,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,depth, false, wood_thickness_left);
            // rear
            translate([length-wood_thickness_rear,0,0])
                    makeTeeth(tooth_width, width, true, wood_thickness_rear);           
            // hinge
            translate([closing_face_length-min_protected_zone+tooth_width,0])
                makeHinge(hingeLength-2*tooth_width,width,3,1);
        }
    }
}

// Creates the hinge. As openscad cannot create simple lines we decided to 
// make a narrow rectangle. Not as precise and nice but it works.
module makeHinge(length, width, step, cut_width) {
    nb_stripes = (1+length/step) % 2 == 0 ? (1+length/step) : (2+length/step);
    uncut1 = width/3;
    uncut2 = width/4;
 
    for(i=[0:nb_stripes-1]) {
        translate([step*i,0]) {
            if( i % 2 == 0 ) {
                square([cut_width, (width-uncut1)/2]);
                translate([0,(width-uncut1)/2+uncut1])
                    square([cut_width, (width-uncut1)/2]);
            } else {
                translate([0,uncut2])
                    square([cut_width, (width/2)]);
            }
        }
    }
}

// Rear panel
module rear_face(top_teeth) {
    difference() {
        square([width, height]);
        union() {
            // right
            translate([width-wood_thickness_right,0,0])
                makeTeeth(tooth_width, height, false, wood_thickness_right);
            // bottom
            translate([0,wood_thickness_bottom,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,width, false, wood_thickness_bottom);
            // top
            if( top_teeth )
                translate([0,height,0])
                    rotate(a=-90)
                        makeTeeth(tooth_width,width, true, wood_thickness_top);           
            // left
            makeTeeth(tooth_width,height, false, wood_thickness_left);
        }
    }
}

// Calculates the distance between two points 
function distance(p1, p2) = sqrt((p2[0]-p1[0])*(p2[0]-p1[0])+(p2[1]-p1[1])*(p2[1]-p1[1]));

// Creates the rounded part of the side panels. As there is no way to create
// a pie in openscad we use some polygons. The more steps you make the more 
// round the pie is.
module pieFromTangentPoints(radius, center, angle=45, steps=12, rotate_angle) {
    
    partial = angle / steps;
    translate(center)
    rotate([0,0,-rotate_angle])

    union() {
        for(i=[1:steps]) {
            polygon ( points= [ [0,0],
                [(radius * cos(partial * (i-1))), radius * sin(partial * (i-1))],
                [radius * cos(partial * i), radius * sin(partial * i)]],
                paths=[[0,1,2]]);
        }
    }

}

// Right panel with rounded part for the flex hinge
module right_face_with_hinge(connector_top, connector_bottom) {
    
    angle = atan(opening_depth/(height-opening_bottom));
    angle_hinge = angle + 90;
    
    difference() {
        union() {
            difference() {
                union() {
                    //Square part
                    square([depth, height]);
                    // triangle used to make the opening
                   polygon(points=[[0,height],[0,0],[-opening_depth,height-opening_bottom]],paths=[[0,1,2]]);
                }
                
                //delete some geometry to make room for the pie
                translate(hinge_point)
                    circle($fn=128,r=dist_center_p1);
            }
            
            // rounded part
            pieFromTangentPoints(radius_pie+0.1, center_pie, angle = angle_pie, steps = 128, rotate_angle=90+angle_pie);   
        }
        union() {
            // rear
            translate([depth-wood_thickness_rear,0,0])
                makeTeeth(tooth_width,height, true, wood_thickness_rear);
            // bottom
            translate([0,wood_thickness_bottom-0.1,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,depth, true, wood_thickness_bottom);
            // top
            if( ! connector_top )
                translate([0,height,0])
                    rotate(a=-90)
                        makeTeeth(tooth_width,depth, true, wood_thickness_top);
            // angle
            translate([0,-0.1])
                rotate(a=angle)
                   makeTeeth(tooth_width,closing_face_length, true,wood_thickness_bottom);

            if( connector_top) {
                translate([0,height+0.1,0])
                    makeConnector(tooth_width,depth, true, wood_thickness_top, true, true, 90);              
            }
        }

    }
        
    if( connector_bottom) {
        translate([-tooth_width,0,0])
            makeConnector(tooth_width,depth, false, wood_thickness_top, true, true, -90);              
    }

}

// Create the teeth on the sides of the panels
module makeTeeth(larg_tooth, h, inverted, wood_thickness) {
    cutable_length=h-2*min_protected_zone;
    nb_interv = (floor(cutable_length/larg_tooth) % 2 == 0 ) ? floor(cutable_length/larg_tooth) - 1 : floor(cutable_length/larg_tooth);
    protected_zone = (h-nb_interv*larg_tooth)/2;
    nb_teeth = inverted ? floor(nb_interv / 2) : floor(nb_interv / 2)+1;
    echo("nb_teeth : ",nb_teeth, "protected_zone : ",protected_zone);
    if( inverted ) {
        square([wood_thickness,protected_zone]);
        translate([0,h-protected_zone,0])
            square([wood_thickness,protected_zone]);
    }
    for( i=[0:nb_teeth-1] ) {
        if( !inverted )
            translate([0,protected_zone+larg_tooth*(i*2)]) square([wood_thickness,larg_tooth]);
        if( inverted )
            translate([0,protected_zone+larg_tooth*(i*2+1)]) square([wood_thickness,larg_tooth]);
    }
}

// Creates the little connectors between the bins
module makeConnector(larg_tooth, h, inverted, wood_thickness, left, right, angle=0) {
    cutable_length=h-2*min_protected_zone;
    nb_interv = (floor(cutable_length/larg_tooth) % 2 == 0 ) ? floor(cutable_length/larg_tooth) - 1 : floor(cutable_length/larg_tooth);
    protected_zone = (h-nb_interv*larg_tooth)/2;
    nb_teeth = inverted ? floor(nb_interv / 2) : floor(nb_interv / 2)+1;
    echo("nb_teeth : ",nb_teeth, "protected_zone : ",protected_zone);

    if( left ) {
        if( !inverted ) {
            translate([protected_zone+larg_tooth,0,0])
                rotate([0,0,angle])
                    papatte(wood_thickness,larg_tooth,wood_thickness/2 );
        } else {
            translate([protected_zone,0,0])
                rotate([0,0,-angle])
                    papatte(wood_thickness,larg_tooth,wood_thickness/2 );
        }
    }
    if( right ) {
        if( !inverted ) {
            translate([depth-protected_zone,0,0])
                rotate([0,0,angle])
                    papatte(wood_thickness,larg_tooth,wood_thickness/2 );
        } else {
            translate([depth-protected_zone-larg_tooth,0,0])
                rotate([0,0,-angle])
                    papatte(wood_thickness,larg_tooth,wood_thickness/2 );
        }
    }
}

// Top panel
module top() {
    difference() {
        square([depth, width]);
        union() {
            translate([depth-wood_thickness_rear,0,0])
                makeTeeth(tooth_width,width, false, wood_thickness_rear);
            translate([0,wood_thickness_left,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,depth, false, wood_thickness_left);
            translate([0,width,0])
                rotate(a=-90)
                    makeTeeth(tooth_width,depth, false, wood_thickness_right);           
            *makeTeeth(tooth_width,width, true);
        }
    }
}
