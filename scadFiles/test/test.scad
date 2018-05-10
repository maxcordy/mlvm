

a = 1.1111111111111107;
b = -10;

module main() {
    intersection() {
        translate([a, 0, 0])
            cube(10, center=true);
        translate([0, b, 0])
            cube(10, center=true);
    }
    cube(1);
}

main();