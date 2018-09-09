// recursionscad:  Basic recursion example

// Recursive functions are very powerful for calculating values.
// A good number of algorithms make use of recursive definitions,
// e.g the caluclation of the factorial of a number.
// The ternary operator " ? : " is the easiest way to define the
// termination condition.
// Note how the following simple implementation will never terminate
// when called with a negative value. This will produce an error after
// some time when OpenSCAD detects the endless recursive call.
function factorial(n) = n == 0 ? 1 : factorial(n - 1) * n;


c=3;

function named(a,b=c) = let(d = a + b, e = a - 1) d + e;

module named1(x, y) {
    module inner(a, b) {
        named2(a, b+1);
    }
    inner(x, y);
}

module named2(x, y) {
    if(x) named1(x-1, y);
    echo(x=x, y=y);
}

module test() {
    c = 4;
    echo(named(3));
}

// named1(1,3);

color("cyan"){ text(str("6! = ", factorial(6)), halign = "center"); echo("bonjour");}

echo(version=version());

test = [1,2,3];
named1(3,2);
//echo(x=named(b=5,3,4));

test();