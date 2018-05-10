/* [Hidden] */
$fn = 100;

/* [Coin] */
vCoinHeight = 2.3;  //Coin height; change for non-Euro currencies only. base = 2.3
vCoinDiameter = 23.2;  //Coin diameter; change for non-Euro currencies only. base = 23.2 

/* [Text] */
vText = "Schaffenburg";  //Your Text, keep quotes
vTextSize = 5.5;  //Text size; scales automatically with coin diameter value
vTextAlignment = "center";  //center, right, left. Keep quotes
vTextImprintDepth = 0.6;  //How deep you want the text, max value ist your set height to go all the way through

/* [Keychain hole] */
vHoleDiameter = 16;  //Size of the hole for your keychain. Scales automatically with coin diameter value


module NAME()
{
    translate([vCoinDiameter / 2 / 11.6 * 12.8,0,vCoinHeight - vTextImprintDepth])
    {
        linear_extrude(height=vTextImprintDepth)
        {
            text(vText, size=vCoinDiameter / 2 / 11.6 * vTextSize, valign="center", halign=vTextAlignment);
        } 
    }
}


module TAG()
{
    cylinder(r=vCoinDiameter / 2 / 11.6 * 11.6, h=vCoinHeight);

    translate([vCoinDiameter / 2 / 11.6 * 45,0,0])
    {
        cylinder(r=vCoinDiameter / 2 / 11.6 * 11.6, h=vCoinHeight);
    }

    difference()
    {
        translate([vCoinDiameter / 2 / 11.6 * 3.5,vCoinDiameter / 2 / 11.6 * -11.6,0])
        {
            cube([vCoinDiameter / 2 / 11.6 * 38,vCoinDiameter / 2 / 11.6 * 23.2,vCoinHeight]);
        }

        translate([vCoinDiameter / 2 / 11.6 * 22.5,vCoinDiameter / 2 / 11.6 * 52.99,0])
        {
            cylinder(r=vCoinDiameter / 2 / 11.6 * 46, h=vCoinHeight);
        }
    
        translate([vCoinDiameter / 2 / 11.6 * 22.5,vCoinDiameter / 2 / 11.6 * -52.99,0])
        {
            cylinder(r=vCoinDiameter / 2 / 11.6 * 46, h=vCoinHeight);
        }
    }
}


module KEYHOLE()
{
    translate([vCoinDiameter / 2 / 11.6 * 45,0,0])
    {
        cylinder(r=vCoinDiameter / 2 / 11.6 * vHoleDiameter / 2, h=vCoinHeight);
    }
}


difference()
{
    TAG();
    NAME();
    KEYHOLE();
}