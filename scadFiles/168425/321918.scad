// Dummy
DUMMY = 0;

function versionstring() = str(version()[0], ".", str(version()[1]), version()[2] == undef ? "" : str(".", version()[2]));

use <write/Write.scad>
write(versionstring(),t=3,h=5,center=true);
