//use numeric variable to move the bar up and down 

//enter the anniversary (2 digit)
text_box = "47";
module plate(scale) {polyhedron(
 points=[[83.00000000000014,2.000000000000113,2.2250053518819857],[2.0000000000002305,83.00000000000033,2.2250053518820816],[2.0000000000000075,2.0000000000002256,2.22500535188211],[2.0000000000002305,83.00000000000033,2.2250053518820816],[83.00000000000014,2.000000000000113,2.2250053518819857],[83.00000000000034,83.00000000000026,2.225005351882025],[85.00000000000024,1.3535839116229907e-13,0.22500535188194992],[2.0000000000000075,2.0000000000002256,2.22500535188211],[0.0,0.0,0.22500535188208526],[2.0000000000000075,2.0000000000002256,2.22500535188211],[85.00000000000024,1.3535839116229907e-13,0.22500535188194992],[83.00000000000014,2.000000000000113,2.2250053518819857],[2.425171174991192e-13,85.00000000000037,0.22500535188207962],[85.00000000000024,1.3535839116229907e-13,0.22500535188194992],[0.0,0.0,0.22500535188208526],[85.00000000000024,1.3535839116229907e-13,0.22500535188194992],[2.425171174991192e-13,85.00000000000037,0.22500535188207962],[85.00000000000048,85.00000000000027,0.22500535188197246],[2.0000000000002305,83.00000000000033,2.2250053518820816],[85.00000000000048,85.00000000000027,0.22500535188197246],[2.425171174991192e-13,85.00000000000037,0.22500535188207962],[85.00000000000048,85.00000000000027,0.22500535188197246],[2.0000000000002305,83.00000000000033,2.2250053518820816],[83.00000000000034,83.00000000000026,2.225005351882025],[2.0000000000000075,2.0000000000002256,2.22500535188211],[2.425171174991192e-13,85.00000000000037,0.22500535188207962],[0.0,0.0,0.22500535188208526],[2.425171174991192e-13,85.00000000000037,0.22500535188207962],[2.0000000000000075,2.0000000000002256,2.22500535188211],[2.0000000000002305,83.00000000000033,2.2250053518820816],[85.00000000000024,1.3535839116229907e-13,0.22500535188194992],[83.00000000000034,83.00000000000026,2.225005351882025],[83.00000000000014,2.000000000000113,2.2250053518819857],[83.00000000000034,83.00000000000026,2.225005351882025],[85.00000000000024,1.3535839116229907e-13,0.22500535188194992],[85.00000000000048,85.00000000000027,0.22500535188197246] ],
faces=[[0,1,2],[3,4,5],[6,7,8],[9,10,11],[12,13,14],[15,16,17],[18,19,20],[21,22,23],[24,25,26],[27,28,29],[30,31,32],[33,34,35]]);}





difference(1) {
plate(1);
translate ([40,40,0])
cylinder (h = 12, r=35, center = true, $fn=100);
}
translate ([5,57,.225])
cube([75,2,2] );

// text(scale) {
font1 = "Archivo Black"; // here you can select other font type
content = (str(text_box));

translate ([40,42,2.25]) {
rotate ([180,0,0]) {
linear_extrude(height = 2) {
text(content, font = font1, size = 34, halign="center", valign="center", direction = "ltr", spacing = 1 );
    ;
}
}
}

