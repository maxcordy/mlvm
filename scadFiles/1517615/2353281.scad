Hauteur=150;
Diametre=60;
Epaisseur_du_fond=5;
Epaisseur_du_vase=3;
Courbure=0.85;
Type_de_courbure=1;//[0,1]
Force_de_la_courbure=15;
Rotation=0.0;
Nombre_de_faces=[6,6,12,12,18,18,24,24,30,30,36,36,42,42,48,48];
vase();
module vase()
{
    difference()
    {
        modele(Diametre=Diametre,ajout=0,fond=0);
        modele(Diametre=Diametre-Epaisseur_du_vase,ajout=1,fond=Epaisseur_du_fond);
        }
}

module modele()
{
    difference()
    {
        for(i=[0:len(Nombre_de_faces)-2+ajout])
        {
            hull()
            {
                translate([0,0,TailleDivision*(i)])
                rotate([0,0,(360*Rotation)/len(Nombre_de_faces)*i])
                if(Type_de_courbure==0)
                {
                    cylinder(d=Diametre+(sin(360/len(Nombre_de_faces)*(i-1)*Courbure)*Force_de_la_courbure),h=0.01,$fn=Nombre_de_faces[i]);
                }
                else
                {
                    cylinder(d=Diametre+(cos(360/len(Nombre_de_faces)*(i-1)*Courbure)*Force_de_la_courbure),h=0.01,$fn=Nombre_de_faces[i]);
                }
            
                translate([0,0,TailleDivision*(i+1)])
                rotate([0,0,(360*Rotation)/len(Nombre_de_faces)*(i+1)])
                if(Type_de_courbure==0)
                {
                    cylinder(d=Diametre+(sin(360/len(Nombre_de_faces)*(i)*Courbure)*Force_de_la_courbure),h=0.01,$fn=Nombre_de_faces[i+1]);
                }
                else
                {
                    cylinder(d=Diametre+(cos(360/len(Nombre_de_faces)*(i)*Courbure)*Force_de_la_courbure),h=0.01,$fn=Nombre_de_faces[i+1]);
                }
            }
        }
        translate([-Diametre,-Diametre,-fond])
        cube([Diametre*2,Diametre*2,fond*2]);
    }
}
TailleDivision=Hauteur/(len(Nombre_de_faces)-1);