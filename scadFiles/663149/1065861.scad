grossura_Da_Peca = 6;
grossura_Da_Barra_Superior = 7.7;
altura_Do_Apoio_Alto = 10;
altura_Do_Apoio_Baixo = 15;
profundudade_Maxima_Da_Barra_Superior = 26;
distancia_Superior_Reta = 50;
distancia_Inferior_Reta = 80;
tamanho_Da_Aste_Que_Sobe = 110;
raio_Do_Furo = 4;
borda_Do_Furo_Pra_Fora = 10;
borda_Do_Furo_Pra_Cima = 10;
tamanho_Da_Lingueta = 10;
grossura_Da_Lingueta = 2;
raio_Do_Furo_Da_Lingueta = 1.5;
esquerda = false; // [true, false]

alturaTotal = altura_Do_Apoio_Baixo + altura_Do_Apoio_Alto + grossura_Da_Barra_Superior;
alturaDaAsteQueSobe = sqrt(alturaTotal*alturaTotal + (distancia_Inferior_Reta-distancia_Superior_Reta)*(distancia_Inferior_Reta-distancia_Superior_Reta));
anguloDaAste = acos(alturaTotal/alturaDaAsteQueSobe);

if(esquerda) {
	mirror([0,1,0]) peca();
} else {
	peca();
}



module peca(){
difference(){
union() {
	cube([profundudade_Maxima_Da_Barra_Superior, altura_Do_Apoio_Baixo,grossura_Da_Peca]);

	translate([0,0,grossura_Da_Peca])
		difference() {
			cube([grossura_Da_Lingueta, altura_Do_Apoio_Baixo, tamanho_Da_Lingueta]);
			translate ([-0.1, altura_Do_Apoio_Baixo/2, tamanho_Da_Lingueta/2])
				rotate ([0,90,0])
					cylinder (h = grossura_Da_Peca*2, r=raio_Do_Furo_Da_Lingueta, $fn=30);
		}

	translate([0,(altura_Do_Apoio_Baixo+grossura_Da_Barra_Superior),0])
		cube([profundudade_Maxima_Da_Barra_Superior,altura_Do_Apoio_Alto,grossura_Da_Peca]);
	translate([0,(altura_Do_Apoio_Baixo+grossura_Da_Barra_Superior),grossura_Da_Peca])
		difference () {
			cube([profundudade_Maxima_Da_Barra_Superior,grossura_Da_Lingueta,tamanho_Da_Lingueta]);
			translate ([profundudade_Maxima_Da_Barra_Superior/2, -0.1, tamanho_Da_Lingueta/2])
				rotate ([-90,0,0])
					cylinder (h = grossura_Da_Peca*2, r=raio_Do_Furo_Da_Lingueta, $fn=30);
		}


		difference() {translate([profundudade_Maxima_Da_Barra_Superior,0,0])
			cube([distancia_Inferior_Reta-profundudade_Maxima_Da_Barra_Superior,altura_Do_Apoio_Baixo+grossura_Da_Barra_Superior+altura_Do_Apoio_Alto,grossura_Da_Peca]);
			translate([profundudade_Maxima_Da_Barra_Superior,altura_Do_Apoio_Baixo+grossura_Da_Barra_Superior/2,-0.1])
				cylinder (h = grossura_Da_Peca*2, r=grossura_Da_Barra_Superior/2, $fn=30);
		}

	translate([distancia_Inferior_Reta,0,0])
		rotate([0,0,anguloDaAste])
			difference() {
				union() {
					cube([tamanho_Da_Aste_Que_Sobe,alturaDaAsteQueSobe,grossura_Da_Peca]);
					translate([tamanho_Da_Aste_Que_Sobe-borda_Do_Furo_Pra_Fora,alturaDaAsteQueSobe-borda_Do_Furo_Pra_Cima,0])
						cylinder (h = grossura_Da_Peca*1.5, r=raio_Do_Furo*3, $fn=30);
				}
				translate([tamanho_Da_Aste_Que_Sobe-borda_Do_Furo_Pra_Fora,alturaDaAsteQueSobe-borda_Do_Furo_Pra_Cima,-grossura_Da_Peca])
					rotate([0,0,90-anguloDaAste])
						union () {
							%cylinder (h = 5, r=75+55/2, $fn=30);
							cylinder (h = grossura_Da_Peca*3, r=raio_Do_Furo);
							translate([0,-raio_Do_Furo,0])
								cube([raio_Do_Furo*10,raio_Do_Furo*2,grossura_Da_Peca*3]);
						}
			}
}
 
translate([distancia_Superior_Reta,0,0])
	rotate([0,0,anguloDaAste]){
		translate([0,-100,-0.1]){
			cube([200,100,grossura_Da_Peca*3]);
		}
	}

}
}