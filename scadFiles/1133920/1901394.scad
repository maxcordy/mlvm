/* MakeBlock Bracket by Sam Kass 2015 */

// # holes in x direction
xholes=9;

// # holes in y direction
yholes=3;

// part thickness (MakeBlock=3)
thickness=3;

// radius of holes (MakeBlock thread=2, MakeBlock loose=2.4)
hole_radius=2.4;

// radius of part corners (MakeBlock=2)
corner_radius=2;

// distance from the center of one hole to center of next (MakeBlock=8)
pitch=8;

// Comma-separated rows to leave as long holes (eg. "0,2")
open_xs="";

// Comma-separated columns to leave as long holes (eg. "0,2")
open_ys = "";

/* [Hidden] */
$fn=50;
open=[];

open_xs_string = str("", open_xs);
open_ys_string = str("", open_ys);

d=0.01;
cr = corner_radius < 0.001 ? 0.001 : corner_radius;

module template() {
    hull() {
        translate([-(pitch/2-cr), -(pitch/2-cr), 0])
            cylinder(h=thickness, r=cr);
        
        translate([-(pitch/2-cr), (yholes-1)*pitch+(pitch/2-cr), 0])
            cylinder(h=thickness, r=cr);

        translate([(xholes-1)*pitch+(pitch/2-cr), -(pitch/2-cr), 0])
            cylinder(h=thickness, r=cr);

        translate([(xholes-1)*pitch+(pitch/2-cr), (yholes-1)*pitch+(pitch/2-cr), 0])
            cylinder(h=thickness, r=cr);
    }
}

module holes() {
    for (y = [0:yholes-1]) {
        for (x = [0:xholes-1]) {
            translate([x*pitch,y*pitch,-d])
                cylinder(h=thickness+2*d, r=hole_radius);
        }
    }
    
}

// String functions from roipoussiere's awesome "String.scad" library
//  http://www.thingiverse.com/thing:202724
function getsplit(str, index=0, char=" ") = (index==0) ? substr(str, 0, search(char, str)[0]) : getsplit(   substr(str, search(" ", str)[0]+1)   , index-1, char);
function strToInt(str, base=10, i=0, nb=0) = (str[0] == "-") ? -1*_strToInt(str, base, 1) : _strToInt(str, base);
function _strToInt(str, base, i=0, nb=0) = (i == len(str)) ? nb : nb+_strToInt(str, base, i+1, search(str[i],"0123456789ABCDEF")[0]*pow(base,len(str)-i-1));
function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));

module open_ys() {
    if (len(open_ys_string) > 0) {
        open_ys_idxs = concat([-1],search(",", open_ys_string, num_returns_per_match=0)[0], [len(open_ys_string)]);
        echo(open_ys_idxs);
        for (i = [1:len(open_ys_idxs)-1]) {
            row = strToInt(substr(open_ys_string, open_ys_idxs[i-1]+1, open_ys_idxs[i]-open_ys_idxs[i-1]-1));
            echo(row);
            hull() {
                translate([0*pitch,row*pitch,-d])
                    cylinder(h=thickness+2*d, r=hole_radius);
                
                translate([(xholes-1)*pitch,row*pitch,-d])
                    cylinder(h=thickness+2*d, r=hole_radius);
            }
        }
    }
}

module open_xs() {
    if (len(open_xs_string) > 0) {
        open_xs_idxs = concat([-1],search(",", open_xs_string, num_returns_per_match=0)[0], [len(open_xs_string)]);
        echo(open_xs_idxs);
        for (i = [1:len(open_xs_idxs)-1]) {
            col = strToInt(substr(open_xs_string, open_xs_idxs[i-1]+1, open_xs_idxs[i]-open_xs_idxs[i-1]-1));
            echo(col);
            hull() {
                translate([col*pitch,0*pitch,-d])
                    cylinder(h=thickness+2*d, r=hole_radius);
                
                translate([col*pitch,(yholes-1)*pitch,-d])
                    cylinder(h=thickness+2*d, r=hole_radius);
            }
        }
    }
}

translate([-xholes*pitch/2+pitch/2, -yholes*pitch/2+pitch/2, 0])
difference() {
    template();
    
    holes();

    open_xs();
    open_ys();
    
}