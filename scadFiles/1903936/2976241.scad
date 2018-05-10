/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in November 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 *
 * Based on the Hubsan Battery Magazine by dboyer:
 * https://www.thingiverse.com/thing:1689701
 */

// -----------------------------------------------------------

batteryCount = 4; // Number of batteries you want to store

// Size of one battery (without cable)
batteryWidth = 14;
batteryHeight = 44;
batteryDepth = 25;

wallSize = 1.2; // wall strength
cableDepth = 15; // depth of part added for cable management
bottomCut = 10; // how much space to cut out for the connector
backCut = 20; // another cut at the back
cableRidge = 5; // thickness of cable management edge

// -----------------------------------------------------------

module holder() {
    // battery
    %translate([wallSize, 0, wallSize])
        cube([batteryWidth, batteryDepth, batteryHeight]);
    
    // left wall
    cube([wallSize, batteryDepth + cableDepth, wallSize + batteryHeight]);
    
    // bottom
    translate([wallSize, 0, 0])
        cube([batteryWidth, batteryDepth + cableDepth - bottomCut, wallSize]);
    
    // right wall
    translate([wallSize + batteryWidth, 0, 0])
        cube([wallSize, batteryDepth + cableDepth, wallSize + batteryHeight]);
    
    // back left ridge
    translate([wallSize, batteryDepth + cableDepth - cableRidge, backCut])
        cube([cableRidge, cableRidge, wallSize + batteryHeight - backCut]);
    
    // back right ridge
    translate([wallSize + batteryWidth - cableRidge, batteryDepth + cableDepth - cableRidge, backCut])
        cube([cableRidge, cableRidge, wallSize + batteryHeight - backCut]);
    
    // top left ridge
    translate([wallSize, batteryDepth, wallSize + batteryHeight - cableRidge])
        cube([cableRidge, cableDepth - cableRidge, cableRidge]);
    
    // top right ridge
    translate([wallSize + batteryWidth - cableRidge, batteryDepth, wallSize + batteryHeight - cableRidge])
        cube([cableRidge, cableDepth - cableRidge, cableRidge]);
    
    // left bototm print helper edge
    translate([wallSize + cableRidge, batteryDepth + cableDepth - cableRidge, backCut])
        rotate([0, 0, 90])
        polyhedron(points=[
            [0, 0, 0], [cableRidge, 0, 0], [cableRidge, cableRidge, 0], [0, cableRidge, 0], [0, cableRidge, -cableRidge], [cableRidge, cableRidge, -cableRidge]
        ], faces=[
            [0, 1, 2, 3], [5, 4, 3, 2], [0, 4, 5, 1], [0, 3, 4], [5, 2, 1]
        ]);
    
    // right bottom print helper edge
    translate([wallSize + batteryWidth - cableRidge, batteryDepth + cableDepth - cableRidge, backCut])
        rotate([0, 0, -90])
        polyhedron(points=[
            [0, 0, 0], [-cableRidge, 0, 0], [-cableRidge, cableRidge, 0], [0, cableRidge, 0], [0, cableRidge, -cableRidge], [-cableRidge, cableRidge, -cableRidge]
        ], faces=[
            [0, 1, 2, 3], [5, 4, 3, 2], [0, 4, 5, 1], [0, 3, 4], [5, 2, 1]
        ]);
    
    // left top print helper edge
    translate([wallSize, batteryDepth + cableDepth - (2 * cableRidge), wallSize + batteryHeight - cableRidge])
        polyhedron(points=[
            [0, 0, 0], [cableRidge, 0, 0], [cableRidge, cableRidge, 0], [0, cableRidge, 0], [0, cableRidge, -cableRidge], [cableRidge, cableRidge, -cableRidge]
        ], faces=[
            [0, 1, 2, 3], [5, 4, 3, 2], [0, 4, 5, 1], [0, 3, 4], [5, 2, 1]
        ]);
    
    // right top print helper edge
    translate([wallSize + batteryWidth - cableRidge, batteryDepth + cableDepth - (2 * cableRidge), wallSize + batteryHeight - cableRidge])
        polyhedron(points=[
            [0, 0, 0], [cableRidge, 0, 0], [cableRidge, cableRidge, 0], [0, cableRidge, 0], [0, cableRidge, -cableRidge], [cableRidge, cableRidge, -cableRidge]
        ], faces=[
            [0, 1, 2, 3], [5, 4, 3, 2], [0, 4, 5, 1], [0, 3, 4], [5, 2, 1]
        ]);
    
    // center mass
    translate([wallSize, batteryDepth, wallSize])
        cube([batteryWidth, cableDepth - bottomCut, batteryHeight - cableRidge]);
}

// -----------------------------------------------------------

for (i = [0 : batteryCount - 1]) {
    translate([((i % 2) == 0) ? 0 : batteryWidth + (2 * wallSize), ((i % 2) == 0) ? 0 : batteryDepth + cableDepth, 0])
    translate([i * (batteryWidth + (2 * wallSize)), 0, 0])
    rotate([0, 0, (180 * i) % 360])
    holder();
}
