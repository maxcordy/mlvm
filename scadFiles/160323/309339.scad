use <write/Write.scad>

// How many numbers in x-direction?
factors_x=10; // [1:32]

// How many numbers in y-direction?
factors_y=10; // [1:32]

// Shrink the hight a bit?
factor_height = 0.3;

font = "write/braille.dxf"; // ["write/Letters.dxf":Letters,"write/orbitron.dxf":orbitron,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave,"write/braille.dxf":braille]
font_depth = 1; // [.5:3]

font_height = 8;

for ( factor_x = [1:factors_x])
{
		
	for ( factor_y = [1:factors_y]) assign ( product = factor_y*factor_x)
	{ //echo (factor_y*factor_x); 
		//echo (product);
		draw_productcube(factor_x,factor_y,product);
	}
}

module draw_productcube(factor_x,factor_y,product) {
	translate(v = [16*factor_x-16, 16*factor_y-16, 0]) {
		color("green")cube(size = [16,16,1+(factor_x*factor_y*factor_height)], center = false);
		
			if (product == 	1	) { writecube("	1	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	2	) { writecube("	2	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	3	) { writecube("	3	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	4	) { writecube("	4	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	5	) { writecube("	5	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	6	) { writecube("	6	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	7	) { writecube("	7	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	8	) { writecube("	8	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	9	) { writecube("	9	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	10	) { writecube("	10	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	11	) { writecube("	11	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	12	) { writecube("	12	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	13	) { writecube("	13	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	14	) { writecube("	14	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	15	) { writecube("	15	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	16	) { writecube("	16	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	17	) { writecube("	17	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	18	) { writecube("	18	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	19	) { writecube("	19	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	20	) { writecube("	20	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	21	) { writecube("	21	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	22	) { writecube("	22	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	23	) { writecube("	23	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	24	) { writecube("	24	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	25	) { writecube("	25	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	26	) { writecube("	26	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	27	) { writecube("	27	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	28	) { writecube("	28	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	29	) { writecube("	29	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	30	) { writecube("	30	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	31	) { writecube("	31	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	32	) { writecube("	32	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	33	) { writecube("	33	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	34	) { writecube("	34	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	35	) { writecube("	35	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	36	) { writecube("	36	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	37	) { writecube("	37	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	38	) { writecube("	38	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	39	) { writecube("	39	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	40	) { writecube("	40	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	41	) { writecube("	41	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	42	) { writecube("	42	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	43	) { writecube("	43	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	44	) { writecube("	44	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	45	) { writecube("	45	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	46	) { writecube("	46	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	47	) { writecube("	47	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	48	) { writecube("	48	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	49	) { writecube("	49	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	50	) { writecube("	50	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	51	) { writecube("	51	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	52	) { writecube("	52	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	53	) { writecube("	53	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	54	) { writecube("	54	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	55	) { writecube("	55	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	56	) { writecube("	56	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	57	) { writecube("	57	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	58	) { writecube("	58	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	59	) { writecube("	59	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	60	) { writecube("	60	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	61	) { writecube("	61	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	62	) { writecube("	62	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	63	) { writecube("	63	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	64	) { writecube("	64	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	65	) { writecube("	65	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	66	) { writecube("	66	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	67	) { writecube("	67	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	68	) { writecube("	68	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	69	) { writecube("	69	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	70	) { writecube("	70	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	71	) { writecube("	71	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	72	) { writecube("	72	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	73	) { writecube("	73	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	74	) { writecube("	74	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	75	) { writecube("	75	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	76	) { writecube("	76	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	77	) { writecube("	77	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	78	) { writecube("	78	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	79	) { writecube("	79	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	80	) { writecube("	80	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	81	) { writecube("	81	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	82	) { writecube("	82	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	83	) { writecube("	83	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	84	) { writecube("	84	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	85	) { writecube("	85	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	86	) { writecube("	86	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	87	) { writecube("	87	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	88	) { writecube("	88	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	89	) { writecube("	89	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	90	) { writecube("	90	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	91	) { writecube("	91	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	92	) { writecube("	92	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	93	) { writecube("	93	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	94	) { writecube("	94	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	95	) { writecube("	95	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	96	) { writecube("	96	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	97	) { writecube("	97	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	98	) { writecube("	98	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	99	) { writecube("	99	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	100	) { writecube("	100	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	101	) { writecube("	101	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	102	) { writecube("	102	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	103	) { writecube("	103	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	104	) { writecube("	104	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	105	) { writecube("	105	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	106	) { writecube("	106	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	107	) { writecube("	107	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	108	) { writecube("	108	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	109	) { writecube("	109	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	110	) { writecube("	110	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	111	) { writecube("	111	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	112	) { writecube("	112	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	113	) { writecube("	113	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	114	) { writecube("	114	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	115	) { writecube("	115	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	116	) { writecube("	116	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	117	) { writecube("	117	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	118	) { writecube("	118	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	119	) { writecube("	119	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	120	) { writecube("	120	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	121	) { writecube("	121	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	122	) { writecube("	122	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	123	) { writecube("	123	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	124	) { writecube("	124	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	125	) { writecube("	125	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	126	) { writecube("	126	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	127	) { writecube("	127	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	128	) { writecube("	128	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	129	) { writecube("	129	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	130	) { writecube("	130	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	131	) { writecube("	131	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	132	) { writecube("	132	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	133	) { writecube("	133	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	134	) { writecube("	134	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	135	) { writecube("	135	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	136	) { writecube("	136	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	137	) { writecube("	137	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	138	) { writecube("	138	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	139	) { writecube("	139	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	140	) { writecube("	140	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	141	) { writecube("	141	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	142	) { writecube("	142	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	143	) { writecube("	143	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	144	) { writecube("	144	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	145	) { writecube("	145	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	146	) { writecube("	146	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	147	) { writecube("	147	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	148	) { writecube("	148	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	149	) { writecube("	149	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	150	) { writecube("	150	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	151	) { writecube("	151	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	152	) { writecube("	152	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	153	) { writecube("	153	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	154	) { writecube("	154	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	155	) { writecube("	155	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	156	) { writecube("	156	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	157	) { writecube("	157	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	158	) { writecube("	158	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	159	) { writecube("	159	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	160	) { writecube("	160	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	161	) { writecube("	161	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	162	) { writecube("	162	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	163	) { writecube("	163	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	164	) { writecube("	164	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	165	) { writecube("	165	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	166	) { writecube("	166	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	167	) { writecube("	167	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	168	) { writecube("	168	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	169	) { writecube("	169	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	170	) { writecube("	170	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	171	) { writecube("	171	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	172	) { writecube("	172	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	173	) { writecube("	173	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	174	) { writecube("	174	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	175	) { writecube("	175	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	176	) { writecube("	176	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	177	) { writecube("	177	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	178	) { writecube("	178	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	179	) { writecube("	179	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	180	) { writecube("	180	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	181	) { writecube("	181	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	182	) { writecube("	182	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	183	) { writecube("	183	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	184	) { writecube("	184	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	185	) { writecube("	185	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	186	) { writecube("	186	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	187	) { writecube("	187	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	188	) { writecube("	188	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	189	) { writecube("	189	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	190	) { writecube("	190	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	191	) { writecube("	191	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	192	) { writecube("	192	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	193	) { writecube("	193	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	194	) { writecube("	194	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	195	) { writecube("	195	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	196	) { writecube("	196	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	197	) { writecube("	197	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	198	) { writecube("	198	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	199	) { writecube("	199	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	200	) { writecube("	200	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	201	) { writecube("	201	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	202	) { writecube("	202	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	203	) { writecube("	203	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	204	) { writecube("	204	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	205	) { writecube("	205	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	206	) { writecube("	206	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	207	) { writecube("	207	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	208	) { writecube("	208	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	209	) { writecube("	209	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	210	) { writecube("	210	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	211	) { writecube("	211	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	212	) { writecube("	212	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	213	) { writecube("	213	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	214	) { writecube("	214	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	215	) { writecube("	215	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	216	) { writecube("	216	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	217	) { writecube("	217	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	218	) { writecube("	218	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	219	) { writecube("	219	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	220	) { writecube("	220	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	221	) { writecube("	221	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	222	) { writecube("	222	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	223	) { writecube("	223	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	224	) { writecube("	224	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	225	) { writecube("	225	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	226	) { writecube("	226	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	227	) { writecube("	227	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	228	) { writecube("	228	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	229	) { writecube("	229	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	230	) { writecube("	230	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	231	) { writecube("	231	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	232	) { writecube("	232	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	233	) { writecube("	233	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	234	) { writecube("	234	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	235	) { writecube("	235	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	236	) { writecube("	236	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	237	) { writecube("	237	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	238	) { writecube("	238	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	239	) { writecube("	239	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	240	) { writecube("	240	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	241	) { writecube("	241	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	242	) { writecube("	242	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	243	) { writecube("	243	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	244	) { writecube("	244	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	245	) { writecube("	245	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	246	) { writecube("	246	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	247	) { writecube("	247	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	248	) { writecube("	248	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	249	) { writecube("	249	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	250	) { writecube("	250	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	251	) { writecube("	251	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	252	) { writecube("	252	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	253	) { writecube("	253	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	254	) { writecube("	254	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	255	) { writecube("	255	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	256	) { writecube("	256	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	257	) { writecube("	257	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	258	) { writecube("	258	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	259	) { writecube("	259	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	260	) { writecube("	260	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	261	) { writecube("	261	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	262	) { writecube("	262	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	263	) { writecube("	263	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	264	) { writecube("	264	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	265	) { writecube("	265	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	266	) { writecube("	266	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	267	) { writecube("	267	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	268	) { writecube("	268	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	269	) { writecube("	269	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	270	) { writecube("	270	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	271	) { writecube("	271	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	272	) { writecube("	272	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	273	) { writecube("	273	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	274	) { writecube("	274	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	275	) { writecube("	275	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	276	) { writecube("	276	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	277	) { writecube("	277	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	278	) { writecube("	278	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	279	) { writecube("	279	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	280	) { writecube("	280	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	281	) { writecube("	281	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	282	) { writecube("	282	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	283	) { writecube("	283	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	284	) { writecube("	284	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	285	) { writecube("	285	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	286	) { writecube("	286	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	287	) { writecube("	287	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	288	) { writecube("	288	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	289	) { writecube("	289	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	290	) { writecube("	290	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	291	) { writecube("	291	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	292	) { writecube("	292	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	293	) { writecube("	293	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	294	) { writecube("	294	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	295	) { writecube("	295	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	296	) { writecube("	296	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	297	) { writecube("	297	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	298	) { writecube("	298	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	299	) { writecube("	299	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	300	) { writecube("	300	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	301	) { writecube("	301	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	302	) { writecube("	302	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	303	) { writecube("	303	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	304	) { writecube("	304	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	305	) { writecube("	305	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	306	) { writecube("	306	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	307	) { writecube("	307	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	308	) { writecube("	308	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	309	) { writecube("	309	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	310	) { writecube("	310	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	311	) { writecube("	311	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	312	) { writecube("	312	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	313	) { writecube("	313	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	314	) { writecube("	314	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	315	) { writecube("	315	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	316	) { writecube("	316	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	317	) { writecube("	317	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	318	) { writecube("	318	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	319	) { writecube("	319	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	320	) { writecube("	320	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	321	) { writecube("	321	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	322	) { writecube("	322	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	323	) { writecube("	323	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	324	) { writecube("	324	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	325	) { writecube("	325	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	326	) { writecube("	326	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	327	) { writecube("	327	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	328	) { writecube("	328	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	329	) { writecube("	329	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	330	) { writecube("	330	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	331	) { writecube("	331	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	332	) { writecube("	332	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	333	) { writecube("	333	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	334	) { writecube("	334	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	335	) { writecube("	335	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	336	) { writecube("	336	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	337	) { writecube("	337	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	338	) { writecube("	338	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	339	) { writecube("	339	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	340	) { writecube("	340	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	341	) { writecube("	341	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	342	) { writecube("	342	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	343	) { writecube("	343	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	344	) { writecube("	344	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	345	) { writecube("	345	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	346	) { writecube("	346	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	347	) { writecube("	347	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	348	) { writecube("	348	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	349	) { writecube("	349	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	350	) { writecube("	350	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	351	) { writecube("	351	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	352	) { writecube("	352	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	353	) { writecube("	353	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	354	) { writecube("	354	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	355	) { writecube("	355	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	356	) { writecube("	356	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	357	) { writecube("	357	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	358	) { writecube("	358	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	359	) { writecube("	359	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	360	) { writecube("	360	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	361	) { writecube("	361	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	362	) { writecube("	362	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	363	) { writecube("	363	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	364	) { writecube("	364	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	365	) { writecube("	365	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	366	) { writecube("	366	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	367	) { writecube("	367	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	368	) { writecube("	368	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	369	) { writecube("	369	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	370	) { writecube("	370	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	371	) { writecube("	371	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	372	) { writecube("	372	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	373	) { writecube("	373	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	374	) { writecube("	374	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	375	) { writecube("	375	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	376	) { writecube("	376	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	377	) { writecube("	377	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	378	) { writecube("	378	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	379	) { writecube("	379	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	380	) { writecube("	380	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	381	) { writecube("	381	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	382	) { writecube("	382	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	383	) { writecube("	383	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	384	) { writecube("	384	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	385	) { writecube("	385	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	386	) { writecube("	386	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	387	) { writecube("	387	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	388	) { writecube("	388	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	389	) { writecube("	389	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	390	) { writecube("	390	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	391	) { writecube("	391	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	392	) { writecube("	392	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	393	) { writecube("	393	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	394	) { writecube("	394	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	395	) { writecube("	395	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	396	) { writecube("	396	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	397	) { writecube("	397	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	398	) { writecube("	398	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	399	) { writecube("	399	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	400	) { writecube("	400	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	401	) { writecube("	401	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	402	) { writecube("	402	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	403	) { writecube("	403	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	404	) { writecube("	404	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	405	) { writecube("	405	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	406	) { writecube("	406	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	407	) { writecube("	407	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	408	) { writecube("	408	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	409	) { writecube("	409	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	410	) { writecube("	410	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	411	) { writecube("	411	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	412	) { writecube("	412	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	413	) { writecube("	413	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	414	) { writecube("	414	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	415	) { writecube("	415	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	416	) { writecube("	416	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	417	) { writecube("	417	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	418	) { writecube("	418	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	419	) { writecube("	419	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	420	) { writecube("	420	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	421	) { writecube("	421	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	422	) { writecube("	422	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	423	) { writecube("	423	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	424	) { writecube("	424	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	425	) { writecube("	425	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	426	) { writecube("	426	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	427	) { writecube("	427	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	428	) { writecube("	428	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	429	) { writecube("	429	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	430	) { writecube("	430	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	431	) { writecube("	431	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	432	) { writecube("	432	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	433	) { writecube("	433	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	434	) { writecube("	434	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	435	) { writecube("	435	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	436	) { writecube("	436	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	437	) { writecube("	437	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	438	) { writecube("	438	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	439	) { writecube("	439	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	440	) { writecube("	440	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	441	) { writecube("	441	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	442	) { writecube("	442	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	443	) { writecube("	443	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	444	) { writecube("	444	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	445	) { writecube("	445	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	446	) { writecube("	446	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	447	) { writecube("	447	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	448	) { writecube("	448	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	449	) { writecube("	449	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	450	) { writecube("	450	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	451	) { writecube("	451	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	452	) { writecube("	452	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	453	) { writecube("	453	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	454	) { writecube("	454	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	455	) { writecube("	455	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	456	) { writecube("	456	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	457	) { writecube("	457	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	458	) { writecube("	458	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	459	) { writecube("	459	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	460	) { writecube("	460	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	461	) { writecube("	461	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	462	) { writecube("	462	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	463	) { writecube("	463	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	464	) { writecube("	464	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	465	) { writecube("	465	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	466	) { writecube("	466	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	467	) { writecube("	467	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	468	) { writecube("	468	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	469	) { writecube("	469	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	470	) { writecube("	470	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	471	) { writecube("	471	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	472	) { writecube("	472	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	473	) { writecube("	473	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	474	) { writecube("	474	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	475	) { writecube("	475	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	476	) { writecube("	476	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	477	) { writecube("	477	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	478	) { writecube("	478	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	479	) { writecube("	479	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	480	) { writecube("	480	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	481	) { writecube("	481	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	482	) { writecube("	482	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	483	) { writecube("	483	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	484	) { writecube("	484	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	485	) { writecube("	485	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	486	) { writecube("	486	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	487	) { writecube("	487	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	488	) { writecube("	488	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	489	) { writecube("	489	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	490	) { writecube("	490	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	491	) { writecube("	491	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	492	) { writecube("	492	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	493	) { writecube("	493	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	494	) { writecube("	494	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	495	) { writecube("	495	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	496	) { writecube("	496	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	497	) { writecube("	497	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	498	) { writecube("	498	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	499	) { writecube("	499	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	500	) { writecube("	500	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	501	) { writecube("	501	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	502	) { writecube("	502	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	503	) { writecube("	503	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	504	) { writecube("	504	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	505	) { writecube("	505	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	506	) { writecube("	506	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	507	) { writecube("	507	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	508	) { writecube("	508	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	509	) { writecube("	509	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	510	) { writecube("	510	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	511	) { writecube("	511	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	512	) { writecube("	512	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	513	) { writecube("	513	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	514	) { writecube("	514	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	515	) { writecube("	515	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	516	) { writecube("	516	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	517	) { writecube("	517	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	518	) { writecube("	518	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	519	) { writecube("	519	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	520	) { writecube("	520	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	521	) { writecube("	521	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	522	) { writecube("	522	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	523	) { writecube("	523	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	524	) { writecube("	524	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	525	) { writecube("	525	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	526	) { writecube("	526	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	527	) { writecube("	527	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	528	) { writecube("	528	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	529	) { writecube("	529	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	530	) { writecube("	530	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	531	) { writecube("	531	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	532	) { writecube("	532	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	533	) { writecube("	533	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	534	) { writecube("	534	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	535	) { writecube("	535	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	536	) { writecube("	536	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	537	) { writecube("	537	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	538	) { writecube("	538	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	539	) { writecube("	539	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	540	) { writecube("	540	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	541	) { writecube("	541	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	542	) { writecube("	542	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	543	) { writecube("	543	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	544	) { writecube("	544	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	545	) { writecube("	545	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	546	) { writecube("	546	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	547	) { writecube("	547	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	548	) { writecube("	548	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	549	) { writecube("	549	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	550	) { writecube("	550	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	551	) { writecube("	551	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	552	) { writecube("	552	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	553	) { writecube("	553	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	554	) { writecube("	554	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	555	) { writecube("	555	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	556	) { writecube("	556	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	557	) { writecube("	557	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	558	) { writecube("	558	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	559	) { writecube("	559	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	560	) { writecube("	560	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	561	) { writecube("	561	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	562	) { writecube("	562	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	563	) { writecube("	563	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	564	) { writecube("	564	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	565	) { writecube("	565	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	566	) { writecube("	566	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	567	) { writecube("	567	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	568	) { writecube("	568	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	569	) { writecube("	569	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	570	) { writecube("	570	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	571	) { writecube("	571	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	572	) { writecube("	572	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	573	) { writecube("	573	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	574	) { writecube("	574	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	575	) { writecube("	575	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	576	) { writecube("	576	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	577	) { writecube("	577	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	578	) { writecube("	578	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	579	) { writecube("	579	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	580	) { writecube("	580	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	581	) { writecube("	581	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	582	) { writecube("	582	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	583	) { writecube("	583	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	584	) { writecube("	584	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	585	) { writecube("	585	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	586	) { writecube("	586	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	587	) { writecube("	587	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	588	) { writecube("	588	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	589	) { writecube("	589	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	590	) { writecube("	590	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	591	) { writecube("	591	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	592	) { writecube("	592	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	593	) { writecube("	593	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	594	) { writecube("	594	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	595	) { writecube("	595	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	596	) { writecube("	596	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	597	) { writecube("	597	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	598	) { writecube("	598	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	599	) { writecube("	599	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	600	) { writecube("	600	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	601	) { writecube("	601	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	602	) { writecube("	602	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	603	) { writecube("	603	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	604	) { writecube("	604	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	605	) { writecube("	605	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	606	) { writecube("	606	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	607	) { writecube("	607	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	608	) { writecube("	608	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	609	) { writecube("	609	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	610	) { writecube("	610	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	611	) { writecube("	611	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	612	) { writecube("	612	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	613	) { writecube("	613	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	614	) { writecube("	614	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	615	) { writecube("	615	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	616	) { writecube("	616	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	617	) { writecube("	617	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	618	) { writecube("	618	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	619	) { writecube("	619	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	620	) { writecube("	620	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	621	) { writecube("	621	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	622	) { writecube("	622	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	623	) { writecube("	623	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	624	) { writecube("	624	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	625	) { writecube("	625	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	626	) { writecube("	626	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	627	) { writecube("	627	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	628	) { writecube("	628	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	629	) { writecube("	629	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	630	) { writecube("	630	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	631	) { writecube("	631	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	632	) { writecube("	632	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	633	) { writecube("	633	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	634	) { writecube("	634	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	635	) { writecube("	635	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	636	) { writecube("	636	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	637	) { writecube("	637	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	638	) { writecube("	638	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	639	) { writecube("	639	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	640	) { writecube("	640	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	641	) { writecube("	641	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	642	) { writecube("	642	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	643	) { writecube("	643	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	644	) { writecube("	644	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	645	) { writecube("	645	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	646	) { writecube("	646	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	647	) { writecube("	647	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	648	) { writecube("	648	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	649	) { writecube("	649	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	650	) { writecube("	650	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	651	) { writecube("	651	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	652	) { writecube("	652	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	653	) { writecube("	653	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	654	) { writecube("	654	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	655	) { writecube("	655	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	656	) { writecube("	656	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	657	) { writecube("	657	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	658	) { writecube("	658	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	659	) { writecube("	659	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	660	) { writecube("	660	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	661	) { writecube("	661	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	662	) { writecube("	662	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	663	) { writecube("	663	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	664	) { writecube("	664	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	665	) { writecube("	665	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	666	) { writecube("	666	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	667	) { writecube("	667	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	668	) { writecube("	668	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	669	) { writecube("	669	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	670	) { writecube("	670	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	671	) { writecube("	671	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	672	) { writecube("	672	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	673	) { writecube("	673	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	674	) { writecube("	674	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	675	) { writecube("	675	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	676	) { writecube("	676	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	677	) { writecube("	677	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	678	) { writecube("	678	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	679	) { writecube("	679	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	680	) { writecube("	680	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	681	) { writecube("	681	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	682	) { writecube("	682	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	683	) { writecube("	683	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	684	) { writecube("	684	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	685	) { writecube("	685	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	686	) { writecube("	686	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	687	) { writecube("	687	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	688	) { writecube("	688	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	689	) { writecube("	689	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	690	) { writecube("	690	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	691	) { writecube("	691	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	692	) { writecube("	692	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	693	) { writecube("	693	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	694	) { writecube("	694	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	695	) { writecube("	695	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	696	) { writecube("	696	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	697	) { writecube("	697	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	698	) { writecube("	698	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	699	) { writecube("	699	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	700	) { writecube("	700	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	701	) { writecube("	701	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	702	) { writecube("	702	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	703	) { writecube("	703	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	704	) { writecube("	704	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	705	) { writecube("	705	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	706	) { writecube("	706	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	707	) { writecube("	707	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	708	) { writecube("	708	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	709	) { writecube("	709	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	710	) { writecube("	710	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	711	) { writecube("	711	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	712	) { writecube("	712	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	713	) { writecube("	713	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	714	) { writecube("	714	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	715	) { writecube("	715	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	716	) { writecube("	716	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	717	) { writecube("	717	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	718	) { writecube("	718	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	719	) { writecube("	719	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	720	) { writecube("	720	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	721	) { writecube("	721	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	722	) { writecube("	722	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	723	) { writecube("	723	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	724	) { writecube("	724	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	725	) { writecube("	725	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	726	) { writecube("	726	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	727	) { writecube("	727	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	728	) { writecube("	728	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	729	) { writecube("	729	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	730	) { writecube("	730	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	731	) { writecube("	731	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	732	) { writecube("	732	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	733	) { writecube("	733	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	734	) { writecube("	734	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	735	) { writecube("	735	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	736	) { writecube("	736	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	737	) { writecube("	737	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	738	) { writecube("	738	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	739	) { writecube("	739	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	740	) { writecube("	740	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	741	) { writecube("	741	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	742	) { writecube("	742	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	743	) { writecube("	743	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	744	) { writecube("	744	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	745	) { writecube("	745	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	746	) { writecube("	746	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	747	) { writecube("	747	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	748	) { writecube("	748	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	749	) { writecube("	749	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	750	) { writecube("	750	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	751	) { writecube("	751	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	752	) { writecube("	752	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	753	) { writecube("	753	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	754	) { writecube("	754	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	755	) { writecube("	755	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	756	) { writecube("	756	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	757	) { writecube("	757	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	758	) { writecube("	758	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	759	) { writecube("	759	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	760	) { writecube("	760	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	761	) { writecube("	761	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	762	) { writecube("	762	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	763	) { writecube("	763	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	764	) { writecube("	764	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	765	) { writecube("	765	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	766	) { writecube("	766	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	767	) { writecube("	767	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	768	) { writecube("	768	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	769	) { writecube("	769	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	770	) { writecube("	770	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	771	) { writecube("	771	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	772	) { writecube("	772	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	773	) { writecube("	773	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	774	) { writecube("	774	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	775	) { writecube("	775	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	776	) { writecube("	776	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	777	) { writecube("	777	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	778	) { writecube("	778	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	779	) { writecube("	779	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	780	) { writecube("	780	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	781	) { writecube("	781	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	782	) { writecube("	782	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	783	) { writecube("	783	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	784	) { writecube("	784	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	785	) { writecube("	785	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	786	) { writecube("	786	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	787	) { writecube("	787	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	788	) { writecube("	788	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	789	) { writecube("	789	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	790	) { writecube("	790	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	791	) { writecube("	791	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	792	) { writecube("	792	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	793	) { writecube("	793	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	794	) { writecube("	794	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	795	) { writecube("	795	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	796	) { writecube("	796	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	797	) { writecube("	797	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	798	) { writecube("	798	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	799	) { writecube("	799	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	800	) { writecube("	800	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	801	) { writecube("	801	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	802	) { writecube("	802	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	803	) { writecube("	803	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	804	) { writecube("	804	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	805	) { writecube("	805	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	806	) { writecube("	806	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	807	) { writecube("	807	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	808	) { writecube("	808	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	809	) { writecube("	809	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	810	) { writecube("	810	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	811	) { writecube("	811	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	812	) { writecube("	812	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	813	) { writecube("	813	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	814	) { writecube("	814	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	815	) { writecube("	815	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	816	) { writecube("	816	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	817	) { writecube("	817	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	818	) { writecube("	818	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	819	) { writecube("	819	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	820	) { writecube("	820	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	821	) { writecube("	821	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	822	) { writecube("	822	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	823	) { writecube("	823	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	824	) { writecube("	824	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	825	) { writecube("	825	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	826	) { writecube("	826	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	827	) { writecube("	827	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	828	) { writecube("	828	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	829	) { writecube("	829	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	830	) { writecube("	830	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	831	) { writecube("	831	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	832	) { writecube("	832	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	833	) { writecube("	833	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	834	) { writecube("	834	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	835	) { writecube("	835	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	836	) { writecube("	836	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	837	) { writecube("	837	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	838	) { writecube("	838	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	839	) { writecube("	839	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	840	) { writecube("	840	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	841	) { writecube("	841	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	842	) { writecube("	842	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	843	) { writecube("	843	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	844	) { writecube("	844	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	845	) { writecube("	845	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	846	) { writecube("	846	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	847	) { writecube("	847	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	848	) { writecube("	848	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	849	) { writecube("	849	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	850	) { writecube("	850	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	851	) { writecube("	851	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	852	) { writecube("	852	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	853	) { writecube("	853	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	854	) { writecube("	854	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	855	) { writecube("	855	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	856	) { writecube("	856	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	857	) { writecube("	857	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	858	) { writecube("	858	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	859	) { writecube("	859	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	860	) { writecube("	860	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	861	) { writecube("	861	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	862	) { writecube("	862	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	863	) { writecube("	863	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	864	) { writecube("	864	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	865	) { writecube("	865	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	866	) { writecube("	866	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	867	) { writecube("	867	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	868	) { writecube("	868	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	869	) { writecube("	869	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	870	) { writecube("	870	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	871	) { writecube("	871	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	872	) { writecube("	872	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	873	) { writecube("	873	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	874	) { writecube("	874	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	875	) { writecube("	875	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	876	) { writecube("	876	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	877	) { writecube("	877	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	878	) { writecube("	878	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	879	) { writecube("	879	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	880	) { writecube("	880	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	881	) { writecube("	881	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	882	) { writecube("	882	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	883	) { writecube("	883	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	884	) { writecube("	884	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	885	) { writecube("	885	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	886	) { writecube("	886	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	887	) { writecube("	887	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	888	) { writecube("	888	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	889	) { writecube("	889	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	890	) { writecube("	890	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	891	) { writecube("	891	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	892	) { writecube("	892	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	893	) { writecube("	893	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	894	) { writecube("	894	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	895	) { writecube("	895	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	896	) { writecube("	896	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	897	) { writecube("	897	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	898	) { writecube("	898	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	899	) { writecube("	899	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	900	) { writecube("	900	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	901	) { writecube("	901	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	902	) { writecube("	902	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	903	) { writecube("	903	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	904	) { writecube("	904	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	905	) { writecube("	905	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	906	) { writecube("	906	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	907	) { writecube("	907	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	908	) { writecube("	908	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	909	) { writecube("	909	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	910	) { writecube("	910	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	911	) { writecube("	911	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	912	) { writecube("	912	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	913	) { writecube("	913	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	914	) { writecube("	914	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	915	) { writecube("	915	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	916	) { writecube("	916	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	917	) { writecube("	917	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	918	) { writecube("	918	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	919	) { writecube("	919	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	920	) { writecube("	920	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	921	) { writecube("	921	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	922	) { writecube("	922	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	923	) { writecube("	923	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	924	) { writecube("	924	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	925	) { writecube("	925	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	926	) { writecube("	926	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	927	) { writecube("	927	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	928	) { writecube("	928	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	929	) { writecube("	929	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	930	) { writecube("	930	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	931	) { writecube("	931	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	932	) { writecube("	932	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	933	) { writecube("	933	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	934	) { writecube("	934	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	935	) { writecube("	935	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	936	) { writecube("	936	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	937	) { writecube("	937	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	938	) { writecube("	938	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	939	) { writecube("	939	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	940	) { writecube("	940	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	941	) { writecube("	941	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	942	) { writecube("	942	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	943	) { writecube("	943	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	944	) { writecube("	944	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	945	) { writecube("	945	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	946	) { writecube("	946	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	947	) { writecube("	947	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	948	) { writecube("	948	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	949	) { writecube("	949	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	950	) { writecube("	950	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	951	) { writecube("	951	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	952	) { writecube("	952	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	953	) { writecube("	953	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	954	) { writecube("	954	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	955	) { writecube("	955	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	956	) { writecube("	956	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	957	) { writecube("	957	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	958	) { writecube("	958	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	959	) { writecube("	959	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	960	) { writecube("	960	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	961	) { writecube("	961	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	962	) { writecube("	962	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	963	) { writecube("	963	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	964	) { writecube("	964	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	965	) { writecube("	965	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	966	) { writecube("	966	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	967	) { writecube("	967	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	968	) { writecube("	968	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	969	) { writecube("	969	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	970	) { writecube("	970	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	971	) { writecube("	971	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	972	) { writecube("	972	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	973	) { writecube("	973	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	974	) { writecube("	974	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	975	) { writecube("	975	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	976	) { writecube("	976	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	977	) { writecube("	977	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	978	) { writecube("	978	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	979	) { writecube("	979	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	980	) { writecube("	980	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	981	) { writecube("	981	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	982	) { writecube("	982	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	983	) { writecube("	983	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	984	) { writecube("	984	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	985	) { writecube("	985	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	986	) { writecube("	986	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	987	) { writecube("	987	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	988	) { writecube("	988	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	989	) { writecube("	989	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	990	) { writecube("	990	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	991	) { writecube("	991	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	992	) { writecube("	992	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	993	) { writecube("	993	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	994	) { writecube("	994	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	995	) { writecube("	995	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	996	) { writecube("	996	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	997	) { writecube("	997	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	998	) { writecube("	998	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	999	) { writecube("	999	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1000	) { writecube("	1000	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1001	) { writecube("	1001	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1002	) { writecube("	1002	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1003	) { writecube("	1003	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1004	) { writecube("	1004	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1005	) { writecube("	1005	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1006	) { writecube("	1006	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1007	) { writecube("	1007	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1008	) { writecube("	1008	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1009	) { writecube("	1009	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1010	) { writecube("	1010	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1011	) { writecube("	1011	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1012	) { writecube("	1012	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1013	) { writecube("	1013	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1014	) { writecube("	1014	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1015	) { writecube("	1015	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1016	) { writecube("	1016	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1017	) { writecube("	1017	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1018	) { writecube("	1018	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1019	) { writecube("	1019	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1020	) { writecube("	1020	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1021	) { writecube("	1021	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1022	) { writecube("	1022	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1023	) { writecube("	1023	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}
			if (product == 	1024	) { writecube("	1024	",[8,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth,h=font_height);}



		

	}
}
