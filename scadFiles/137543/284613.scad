use <write/Write.scad>

// How many numbers in x-direction?
factors_x=10; // [1:32]

// How many numbers in y-direction?
factors_y=10; // [1:32]

// Shrink the hight a bit?
factor_height = 0.3;

font = "write/Letters.dxf"; // ["write/Letters.dxf":Letters,"write/orbitron.dxf":orbitron,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave,"write/braille.dxf":braille]
font_depth = 1; // [.5:3]

for ( factor_x = [1:factors_x])
{
		
	for ( factor_y = [1:factors_y]) assign ( product = factor_y*factor_x)
	{ //echo (factor_y*factor_x); 
		//echo (product);
		draw_productcube(factor_x,factor_y,product);
	}
}

module draw_productcube(factor_x,factor_y,product) {
	translate(v = [10*factor_x-10, 10*factor_y-10, 0]) {
		color("green")cube(size = [10,10,1+(factor_x*factor_y*factor_height)], center = false);
		
			if (product == 	1	) { writecube("	1	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	2	) { writecube("	2	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	3	) { writecube("	3	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	4	) { writecube("	4	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	5	) { writecube("	5	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	6	) { writecube("	6	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	7	) { writecube("	7	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	8	) { writecube("	8	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	9	) { writecube("	9	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	10	) { writecube("	10	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	11	) { writecube("	11	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	12	) { writecube("	12	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	13	) { writecube("	13	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	14	) { writecube("	14	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	15	) { writecube("	15	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	16	) { writecube("	16	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	17	) { writecube("	17	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	18	) { writecube("	18	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	19	) { writecube("	19	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	20	) { writecube("	20	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	21	) { writecube("	21	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	22	) { writecube("	22	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	23	) { writecube("	23	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	24	) { writecube("	24	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	25	) { writecube("	25	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	26	) { writecube("	26	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	27	) { writecube("	27	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	28	) { writecube("	28	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	29	) { writecube("	29	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	30	) { writecube("	30	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	31	) { writecube("	31	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	32	) { writecube("	32	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	33	) { writecube("	33	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	34	) { writecube("	34	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	35	) { writecube("	35	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	36	) { writecube("	36	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	37	) { writecube("	37	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	38	) { writecube("	38	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	39	) { writecube("	39	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	40	) { writecube("	40	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	41	) { writecube("	41	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	42	) { writecube("	42	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	43	) { writecube("	43	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	44	) { writecube("	44	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	45	) { writecube("	45	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	46	) { writecube("	46	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	47	) { writecube("	47	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	48	) { writecube("	48	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	49	) { writecube("	49	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	50	) { writecube("	50	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	51	) { writecube("	51	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	52	) { writecube("	52	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	53	) { writecube("	53	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	54	) { writecube("	54	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	55	) { writecube("	55	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	56	) { writecube("	56	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	57	) { writecube("	57	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	58	) { writecube("	58	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	59	) { writecube("	59	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	60	) { writecube("	60	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	61	) { writecube("	61	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	62	) { writecube("	62	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	63	) { writecube("	63	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	64	) { writecube("	64	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	65	) { writecube("	65	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	66	) { writecube("	66	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	67	) { writecube("	67	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	68	) { writecube("	68	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	69	) { writecube("	69	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	70	) { writecube("	70	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	71	) { writecube("	71	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	72	) { writecube("	72	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	73	) { writecube("	73	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	74	) { writecube("	74	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	75	) { writecube("	75	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	76	) { writecube("	76	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	77	) { writecube("	77	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	78	) { writecube("	78	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	79	) { writecube("	79	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	80	) { writecube("	80	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	81	) { writecube("	81	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	82	) { writecube("	82	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	83	) { writecube("	83	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	84	) { writecube("	84	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	85	) { writecube("	85	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	86	) { writecube("	86	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	87	) { writecube("	87	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	88	) { writecube("	88	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	89	) { writecube("	89	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	90	) { writecube("	90	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	91	) { writecube("	91	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	92	) { writecube("	92	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	93	) { writecube("	93	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	94	) { writecube("	94	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	95	) { writecube("	95	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	96	) { writecube("	96	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	97	) { writecube("	97	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	98	) { writecube("	98	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	99	) { writecube("	99	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	100	) { writecube("	100	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	101	) { writecube("	101	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	102	) { writecube("	102	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	103	) { writecube("	103	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	104	) { writecube("	104	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	105	) { writecube("	105	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	106	) { writecube("	106	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	107	) { writecube("	107	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	108	) { writecube("	108	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	109	) { writecube("	109	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	110	) { writecube("	110	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	111	) { writecube("	111	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	112	) { writecube("	112	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	113	) { writecube("	113	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	114	) { writecube("	114	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	115	) { writecube("	115	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	116	) { writecube("	116	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	117	) { writecube("	117	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	118	) { writecube("	118	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	119	) { writecube("	119	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	120	) { writecube("	120	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	121	) { writecube("	121	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	122	) { writecube("	122	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	123	) { writecube("	123	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	124	) { writecube("	124	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	125	) { writecube("	125	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	126	) { writecube("	126	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	127	) { writecube("	127	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	128	) { writecube("	128	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	129	) { writecube("	129	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	130	) { writecube("	130	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	131	) { writecube("	131	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	132	) { writecube("	132	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	133	) { writecube("	133	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	134	) { writecube("	134	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	135	) { writecube("	135	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	136	) { writecube("	136	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	137	) { writecube("	137	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	138	) { writecube("	138	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	139	) { writecube("	139	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	140	) { writecube("	140	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	141	) { writecube("	141	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	142	) { writecube("	142	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	143	) { writecube("	143	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	144	) { writecube("	144	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	145	) { writecube("	145	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	146	) { writecube("	146	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	147	) { writecube("	147	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	148	) { writecube("	148	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	149	) { writecube("	149	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	150	) { writecube("	150	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	151	) { writecube("	151	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	152	) { writecube("	152	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	153	) { writecube("	153	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	154	) { writecube("	154	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	155	) { writecube("	155	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	156	) { writecube("	156	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	157	) { writecube("	157	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	158	) { writecube("	158	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	159	) { writecube("	159	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	160	) { writecube("	160	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	161	) { writecube("	161	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	162	) { writecube("	162	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	163	) { writecube("	163	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	164	) { writecube("	164	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	165	) { writecube("	165	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	166	) { writecube("	166	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	167	) { writecube("	167	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	168	) { writecube("	168	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	169	) { writecube("	169	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	170	) { writecube("	170	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	171	) { writecube("	171	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	172	) { writecube("	172	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	173	) { writecube("	173	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	174	) { writecube("	174	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	175	) { writecube("	175	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	176	) { writecube("	176	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	177	) { writecube("	177	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	178	) { writecube("	178	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	179	) { writecube("	179	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	180	) { writecube("	180	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	181	) { writecube("	181	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	182	) { writecube("	182	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	183	) { writecube("	183	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	184	) { writecube("	184	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	185	) { writecube("	185	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	186	) { writecube("	186	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	187	) { writecube("	187	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	188	) { writecube("	188	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	189	) { writecube("	189	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	190	) { writecube("	190	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	191	) { writecube("	191	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	192	) { writecube("	192	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	193	) { writecube("	193	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	194	) { writecube("	194	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	195	) { writecube("	195	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	196	) { writecube("	196	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	197	) { writecube("	197	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	198	) { writecube("	198	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	199	) { writecube("	199	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	200	) { writecube("	200	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	201	) { writecube("	201	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	202	) { writecube("	202	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	203	) { writecube("	203	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	204	) { writecube("	204	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	205	) { writecube("	205	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	206	) { writecube("	206	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	207	) { writecube("	207	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	208	) { writecube("	208	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	209	) { writecube("	209	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	210	) { writecube("	210	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	211	) { writecube("	211	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	212	) { writecube("	212	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	213	) { writecube("	213	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	214	) { writecube("	214	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	215	) { writecube("	215	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	216	) { writecube("	216	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	217	) { writecube("	217	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	218	) { writecube("	218	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	219	) { writecube("	219	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	220	) { writecube("	220	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	221	) { writecube("	221	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	222	) { writecube("	222	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	223	) { writecube("	223	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	224	) { writecube("	224	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	225	) { writecube("	225	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	226	) { writecube("	226	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	227	) { writecube("	227	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	228	) { writecube("	228	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	229	) { writecube("	229	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	230	) { writecube("	230	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	231	) { writecube("	231	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	232	) { writecube("	232	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	233	) { writecube("	233	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	234	) { writecube("	234	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	235	) { writecube("	235	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	236	) { writecube("	236	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	237	) { writecube("	237	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	238	) { writecube("	238	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	239	) { writecube("	239	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	240	) { writecube("	240	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	241	) { writecube("	241	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	242	) { writecube("	242	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	243	) { writecube("	243	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	244	) { writecube("	244	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	245	) { writecube("	245	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	246	) { writecube("	246	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	247	) { writecube("	247	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	248	) { writecube("	248	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	249	) { writecube("	249	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	250	) { writecube("	250	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	251	) { writecube("	251	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	252	) { writecube("	252	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	253	) { writecube("	253	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	254	) { writecube("	254	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	255	) { writecube("	255	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	256	) { writecube("	256	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	257	) { writecube("	257	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	258	) { writecube("	258	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	259	) { writecube("	259	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	260	) { writecube("	260	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	261	) { writecube("	261	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	262	) { writecube("	262	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	263	) { writecube("	263	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	264	) { writecube("	264	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	265	) { writecube("	265	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	266	) { writecube("	266	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	267	) { writecube("	267	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	268	) { writecube("	268	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	269	) { writecube("	269	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	270	) { writecube("	270	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	271	) { writecube("	271	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	272	) { writecube("	272	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	273	) { writecube("	273	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	274	) { writecube("	274	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	275	) { writecube("	275	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	276	) { writecube("	276	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	277	) { writecube("	277	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	278	) { writecube("	278	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	279	) { writecube("	279	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	280	) { writecube("	280	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	281	) { writecube("	281	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	282	) { writecube("	282	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	283	) { writecube("	283	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	284	) { writecube("	284	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	285	) { writecube("	285	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	286	) { writecube("	286	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	287	) { writecube("	287	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	288	) { writecube("	288	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	289	) { writecube("	289	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	290	) { writecube("	290	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	291	) { writecube("	291	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	292	) { writecube("	292	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	293	) { writecube("	293	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	294	) { writecube("	294	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	295	) { writecube("	295	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	296	) { writecube("	296	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	297	) { writecube("	297	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	298	) { writecube("	298	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	299	) { writecube("	299	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	300	) { writecube("	300	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	301	) { writecube("	301	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	302	) { writecube("	302	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	303	) { writecube("	303	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	304	) { writecube("	304	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	305	) { writecube("	305	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	306	) { writecube("	306	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	307	) { writecube("	307	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	308	) { writecube("	308	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	309	) { writecube("	309	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	310	) { writecube("	310	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	311	) { writecube("	311	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	312	) { writecube("	312	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	313	) { writecube("	313	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	314	) { writecube("	314	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	315	) { writecube("	315	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	316	) { writecube("	316	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	317	) { writecube("	317	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	318	) { writecube("	318	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	319	) { writecube("	319	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	320	) { writecube("	320	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	321	) { writecube("	321	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	322	) { writecube("	322	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	323	) { writecube("	323	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	324	) { writecube("	324	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	325	) { writecube("	325	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	326	) { writecube("	326	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	327	) { writecube("	327	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	328	) { writecube("	328	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	329	) { writecube("	329	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	330	) { writecube("	330	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	331	) { writecube("	331	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	332	) { writecube("	332	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	333	) { writecube("	333	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	334	) { writecube("	334	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	335	) { writecube("	335	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	336	) { writecube("	336	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	337	) { writecube("	337	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	338	) { writecube("	338	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	339	) { writecube("	339	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	340	) { writecube("	340	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	341	) { writecube("	341	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	342	) { writecube("	342	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	343	) { writecube("	343	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	344	) { writecube("	344	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	345	) { writecube("	345	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	346	) { writecube("	346	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	347	) { writecube("	347	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	348	) { writecube("	348	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	349	) { writecube("	349	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	350	) { writecube("	350	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	351	) { writecube("	351	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	352	) { writecube("	352	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	353	) { writecube("	353	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	354	) { writecube("	354	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	355	) { writecube("	355	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	356	) { writecube("	356	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	357	) { writecube("	357	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	358	) { writecube("	358	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	359	) { writecube("	359	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	360	) { writecube("	360	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	361	) { writecube("	361	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	362	) { writecube("	362	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	363	) { writecube("	363	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	364	) { writecube("	364	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	365	) { writecube("	365	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	366	) { writecube("	366	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	367	) { writecube("	367	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	368	) { writecube("	368	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	369	) { writecube("	369	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	370	) { writecube("	370	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	371	) { writecube("	371	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	372	) { writecube("	372	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	373	) { writecube("	373	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	374	) { writecube("	374	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	375	) { writecube("	375	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	376	) { writecube("	376	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	377	) { writecube("	377	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	378	) { writecube("	378	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	379	) { writecube("	379	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	380	) { writecube("	380	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	381	) { writecube("	381	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	382	) { writecube("	382	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	383	) { writecube("	383	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	384	) { writecube("	384	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	385	) { writecube("	385	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	386	) { writecube("	386	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	387	) { writecube("	387	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	388	) { writecube("	388	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	389	) { writecube("	389	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	390	) { writecube("	390	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	391	) { writecube("	391	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	392	) { writecube("	392	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	393	) { writecube("	393	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	394	) { writecube("	394	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	395	) { writecube("	395	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	396	) { writecube("	396	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	397	) { writecube("	397	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	398	) { writecube("	398	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	399	) { writecube("	399	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	400	) { writecube("	400	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	401	) { writecube("	401	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	402	) { writecube("	402	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	403	) { writecube("	403	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	404	) { writecube("	404	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	405	) { writecube("	405	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	406	) { writecube("	406	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	407	) { writecube("	407	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	408	) { writecube("	408	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	409	) { writecube("	409	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	410	) { writecube("	410	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	411	) { writecube("	411	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	412	) { writecube("	412	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	413	) { writecube("	413	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	414	) { writecube("	414	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	415	) { writecube("	415	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	416	) { writecube("	416	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	417	) { writecube("	417	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	418	) { writecube("	418	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	419	) { writecube("	419	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	420	) { writecube("	420	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	421	) { writecube("	421	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	422	) { writecube("	422	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	423	) { writecube("	423	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	424	) { writecube("	424	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	425	) { writecube("	425	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	426	) { writecube("	426	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	427	) { writecube("	427	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	428	) { writecube("	428	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	429	) { writecube("	429	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	430	) { writecube("	430	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	431	) { writecube("	431	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	432	) { writecube("	432	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	433	) { writecube("	433	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	434	) { writecube("	434	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	435	) { writecube("	435	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	436	) { writecube("	436	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	437	) { writecube("	437	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	438	) { writecube("	438	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	439	) { writecube("	439	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	440	) { writecube("	440	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	441	) { writecube("	441	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	442	) { writecube("	442	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	443	) { writecube("	443	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	444	) { writecube("	444	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	445	) { writecube("	445	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	446	) { writecube("	446	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	447	) { writecube("	447	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	448	) { writecube("	448	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	449	) { writecube("	449	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	450	) { writecube("	450	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	451	) { writecube("	451	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	452	) { writecube("	452	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	453	) { writecube("	453	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	454	) { writecube("	454	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	455	) { writecube("	455	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	456	) { writecube("	456	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	457	) { writecube("	457	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	458	) { writecube("	458	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	459	) { writecube("	459	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	460	) { writecube("	460	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	461	) { writecube("	461	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	462	) { writecube("	462	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	463	) { writecube("	463	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	464	) { writecube("	464	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	465	) { writecube("	465	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	466	) { writecube("	466	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	467	) { writecube("	467	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	468	) { writecube("	468	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	469	) { writecube("	469	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	470	) { writecube("	470	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	471	) { writecube("	471	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	472	) { writecube("	472	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	473	) { writecube("	473	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	474	) { writecube("	474	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	475	) { writecube("	475	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	476	) { writecube("	476	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	477	) { writecube("	477	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	478	) { writecube("	478	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	479	) { writecube("	479	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	480	) { writecube("	480	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	481	) { writecube("	481	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	482	) { writecube("	482	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	483	) { writecube("	483	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	484	) { writecube("	484	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	485	) { writecube("	485	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	486	) { writecube("	486	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	487	) { writecube("	487	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	488	) { writecube("	488	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	489	) { writecube("	489	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	490	) { writecube("	490	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	491	) { writecube("	491	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	492	) { writecube("	492	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	493	) { writecube("	493	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	494	) { writecube("	494	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	495	) { writecube("	495	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	496	) { writecube("	496	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	497	) { writecube("	497	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	498	) { writecube("	498	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	499	) { writecube("	499	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	500	) { writecube("	500	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	501	) { writecube("	501	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	502	) { writecube("	502	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	503	) { writecube("	503	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	504	) { writecube("	504	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	505	) { writecube("	505	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	506	) { writecube("	506	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	507	) { writecube("	507	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	508	) { writecube("	508	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	509	) { writecube("	509	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	510	) { writecube("	510	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	511	) { writecube("	511	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	512	) { writecube("	512	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	513	) { writecube("	513	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	514	) { writecube("	514	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	515	) { writecube("	515	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	516	) { writecube("	516	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	517	) { writecube("	517	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	518	) { writecube("	518	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	519	) { writecube("	519	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	520	) { writecube("	520	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	521	) { writecube("	521	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	522	) { writecube("	522	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	523	) { writecube("	523	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	524	) { writecube("	524	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	525	) { writecube("	525	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	526	) { writecube("	526	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	527	) { writecube("	527	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	528	) { writecube("	528	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	529	) { writecube("	529	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	530	) { writecube("	530	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	531	) { writecube("	531	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	532	) { writecube("	532	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	533	) { writecube("	533	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	534	) { writecube("	534	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	535	) { writecube("	535	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	536	) { writecube("	536	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	537	) { writecube("	537	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	538	) { writecube("	538	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	539	) { writecube("	539	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	540	) { writecube("	540	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	541	) { writecube("	541	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	542	) { writecube("	542	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	543	) { writecube("	543	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	544	) { writecube("	544	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	545	) { writecube("	545	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	546	) { writecube("	546	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	547	) { writecube("	547	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	548	) { writecube("	548	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	549	) { writecube("	549	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	550	) { writecube("	550	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	551	) { writecube("	551	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	552	) { writecube("	552	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	553	) { writecube("	553	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	554	) { writecube("	554	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	555	) { writecube("	555	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	556	) { writecube("	556	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	557	) { writecube("	557	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	558	) { writecube("	558	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	559	) { writecube("	559	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	560	) { writecube("	560	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	561	) { writecube("	561	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	562	) { writecube("	562	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	563	) { writecube("	563	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	564	) { writecube("	564	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	565	) { writecube("	565	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	566	) { writecube("	566	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	567	) { writecube("	567	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	568	) { writecube("	568	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	569	) { writecube("	569	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	570	) { writecube("	570	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	571	) { writecube("	571	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	572	) { writecube("	572	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	573	) { writecube("	573	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	574	) { writecube("	574	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	575	) { writecube("	575	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	576	) { writecube("	576	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	577	) { writecube("	577	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	578	) { writecube("	578	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	579	) { writecube("	579	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	580	) { writecube("	580	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	581	) { writecube("	581	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	582	) { writecube("	582	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	583	) { writecube("	583	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	584	) { writecube("	584	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	585	) { writecube("	585	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	586	) { writecube("	586	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	587	) { writecube("	587	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	588	) { writecube("	588	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	589	) { writecube("	589	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	590	) { writecube("	590	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	591	) { writecube("	591	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	592	) { writecube("	592	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	593	) { writecube("	593	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	594	) { writecube("	594	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	595	) { writecube("	595	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	596	) { writecube("	596	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	597	) { writecube("	597	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	598	) { writecube("	598	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	599	) { writecube("	599	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	600	) { writecube("	600	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	601	) { writecube("	601	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	602	) { writecube("	602	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	603	) { writecube("	603	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	604	) { writecube("	604	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	605	) { writecube("	605	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	606	) { writecube("	606	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	607	) { writecube("	607	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	608	) { writecube("	608	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	609	) { writecube("	609	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	610	) { writecube("	610	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	611	) { writecube("	611	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	612	) { writecube("	612	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	613	) { writecube("	613	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	614	) { writecube("	614	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	615	) { writecube("	615	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	616	) { writecube("	616	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	617	) { writecube("	617	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	618	) { writecube("	618	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	619	) { writecube("	619	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	620	) { writecube("	620	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	621	) { writecube("	621	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	622	) { writecube("	622	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	623	) { writecube("	623	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	624	) { writecube("	624	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	625	) { writecube("	625	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	626	) { writecube("	626	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	627	) { writecube("	627	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	628	) { writecube("	628	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	629	) { writecube("	629	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	630	) { writecube("	630	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	631	) { writecube("	631	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	632	) { writecube("	632	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	633	) { writecube("	633	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	634	) { writecube("	634	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	635	) { writecube("	635	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	636	) { writecube("	636	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	637	) { writecube("	637	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	638	) { writecube("	638	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	639	) { writecube("	639	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	640	) { writecube("	640	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	641	) { writecube("	641	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	642	) { writecube("	642	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	643	) { writecube("	643	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	644	) { writecube("	644	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	645	) { writecube("	645	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	646	) { writecube("	646	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	647	) { writecube("	647	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	648	) { writecube("	648	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	649	) { writecube("	649	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	650	) { writecube("	650	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	651	) { writecube("	651	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	652	) { writecube("	652	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	653	) { writecube("	653	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	654	) { writecube("	654	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	655	) { writecube("	655	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	656	) { writecube("	656	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	657	) { writecube("	657	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	658	) { writecube("	658	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	659	) { writecube("	659	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	660	) { writecube("	660	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	661	) { writecube("	661	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	662	) { writecube("	662	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	663	) { writecube("	663	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	664	) { writecube("	664	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	665	) { writecube("	665	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	666	) { writecube("	666	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	667	) { writecube("	667	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	668	) { writecube("	668	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	669	) { writecube("	669	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	670	) { writecube("	670	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	671	) { writecube("	671	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	672	) { writecube("	672	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	673	) { writecube("	673	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	674	) { writecube("	674	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	675	) { writecube("	675	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	676	) { writecube("	676	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	677	) { writecube("	677	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	678	) { writecube("	678	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	679	) { writecube("	679	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	680	) { writecube("	680	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	681	) { writecube("	681	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	682	) { writecube("	682	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	683	) { writecube("	683	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	684	) { writecube("	684	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	685	) { writecube("	685	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	686	) { writecube("	686	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	687	) { writecube("	687	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	688	) { writecube("	688	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	689	) { writecube("	689	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	690	) { writecube("	690	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	691	) { writecube("	691	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	692	) { writecube("	692	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	693	) { writecube("	693	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	694	) { writecube("	694	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	695	) { writecube("	695	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	696	) { writecube("	696	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	697	) { writecube("	697	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	698	) { writecube("	698	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	699	) { writecube("	699	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	700	) { writecube("	700	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	701	) { writecube("	701	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	702	) { writecube("	702	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	703	) { writecube("	703	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	704	) { writecube("	704	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	705	) { writecube("	705	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	706	) { writecube("	706	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	707	) { writecube("	707	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	708	) { writecube("	708	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	709	) { writecube("	709	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	710	) { writecube("	710	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	711	) { writecube("	711	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	712	) { writecube("	712	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	713	) { writecube("	713	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	714	) { writecube("	714	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	715	) { writecube("	715	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	716	) { writecube("	716	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	717	) { writecube("	717	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	718	) { writecube("	718	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	719	) { writecube("	719	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	720	) { writecube("	720	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	721	) { writecube("	721	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	722	) { writecube("	722	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	723	) { writecube("	723	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	724	) { writecube("	724	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	725	) { writecube("	725	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	726	) { writecube("	726	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	727	) { writecube("	727	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	728	) { writecube("	728	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	729	) { writecube("	729	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	730	) { writecube("	730	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	731	) { writecube("	731	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	732	) { writecube("	732	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	733	) { writecube("	733	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	734	) { writecube("	734	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	735	) { writecube("	735	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	736	) { writecube("	736	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	737	) { writecube("	737	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	738	) { writecube("	738	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	739	) { writecube("	739	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	740	) { writecube("	740	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	741	) { writecube("	741	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	742	) { writecube("	742	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	743	) { writecube("	743	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	744	) { writecube("	744	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	745	) { writecube("	745	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	746	) { writecube("	746	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	747	) { writecube("	747	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	748	) { writecube("	748	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	749	) { writecube("	749	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	750	) { writecube("	750	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	751	) { writecube("	751	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	752	) { writecube("	752	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	753	) { writecube("	753	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	754	) { writecube("	754	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	755	) { writecube("	755	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	756	) { writecube("	756	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	757	) { writecube("	757	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	758	) { writecube("	758	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	759	) { writecube("	759	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	760	) { writecube("	760	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	761	) { writecube("	761	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	762	) { writecube("	762	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	763	) { writecube("	763	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	764	) { writecube("	764	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	765	) { writecube("	765	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	766	) { writecube("	766	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	767	) { writecube("	767	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	768	) { writecube("	768	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	769	) { writecube("	769	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	770	) { writecube("	770	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	771	) { writecube("	771	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	772	) { writecube("	772	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	773	) { writecube("	773	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	774	) { writecube("	774	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	775	) { writecube("	775	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	776	) { writecube("	776	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	777	) { writecube("	777	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	778	) { writecube("	778	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	779	) { writecube("	779	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	780	) { writecube("	780	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	781	) { writecube("	781	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	782	) { writecube("	782	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	783	) { writecube("	783	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	784	) { writecube("	784	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	785	) { writecube("	785	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	786	) { writecube("	786	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	787	) { writecube("	787	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	788	) { writecube("	788	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	789	) { writecube("	789	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	790	) { writecube("	790	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	791	) { writecube("	791	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	792	) { writecube("	792	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	793	) { writecube("	793	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	794	) { writecube("	794	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	795	) { writecube("	795	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	796	) { writecube("	796	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	797	) { writecube("	797	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	798	) { writecube("	798	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	799	) { writecube("	799	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	800	) { writecube("	800	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	801	) { writecube("	801	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	802	) { writecube("	802	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	803	) { writecube("	803	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	804	) { writecube("	804	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	805	) { writecube("	805	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	806	) { writecube("	806	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	807	) { writecube("	807	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	808	) { writecube("	808	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	809	) { writecube("	809	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	810	) { writecube("	810	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	811	) { writecube("	811	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	812	) { writecube("	812	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	813	) { writecube("	813	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	814	) { writecube("	814	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	815	) { writecube("	815	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	816	) { writecube("	816	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	817	) { writecube("	817	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	818	) { writecube("	818	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	819	) { writecube("	819	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	820	) { writecube("	820	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	821	) { writecube("	821	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	822	) { writecube("	822	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	823	) { writecube("	823	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	824	) { writecube("	824	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	825	) { writecube("	825	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	826	) { writecube("	826	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	827	) { writecube("	827	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	828	) { writecube("	828	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	829	) { writecube("	829	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	830	) { writecube("	830	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	831	) { writecube("	831	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	832	) { writecube("	832	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	833	) { writecube("	833	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	834	) { writecube("	834	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	835	) { writecube("	835	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	836	) { writecube("	836	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	837	) { writecube("	837	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	838	) { writecube("	838	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	839	) { writecube("	839	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	840	) { writecube("	840	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	841	) { writecube("	841	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	842	) { writecube("	842	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	843	) { writecube("	843	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	844	) { writecube("	844	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	845	) { writecube("	845	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	846	) { writecube("	846	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	847	) { writecube("	847	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	848	) { writecube("	848	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	849	) { writecube("	849	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	850	) { writecube("	850	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	851	) { writecube("	851	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	852	) { writecube("	852	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	853	) { writecube("	853	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	854	) { writecube("	854	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	855	) { writecube("	855	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	856	) { writecube("	856	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	857	) { writecube("	857	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	858	) { writecube("	858	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	859	) { writecube("	859	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	860	) { writecube("	860	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	861	) { writecube("	861	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	862	) { writecube("	862	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	863	) { writecube("	863	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	864	) { writecube("	864	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	865	) { writecube("	865	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	866	) { writecube("	866	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	867	) { writecube("	867	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	868	) { writecube("	868	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	869	) { writecube("	869	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	870	) { writecube("	870	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	871	) { writecube("	871	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	872	) { writecube("	872	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	873	) { writecube("	873	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	874	) { writecube("	874	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	875	) { writecube("	875	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	876	) { writecube("	876	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	877	) { writecube("	877	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	878	) { writecube("	878	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	879	) { writecube("	879	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	880	) { writecube("	880	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	881	) { writecube("	881	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	882	) { writecube("	882	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	883	) { writecube("	883	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	884	) { writecube("	884	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	885	) { writecube("	885	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	886	) { writecube("	886	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	887	) { writecube("	887	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	888	) { writecube("	888	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	889	) { writecube("	889	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	890	) { writecube("	890	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	891	) { writecube("	891	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	892	) { writecube("	892	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	893	) { writecube("	893	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	894	) { writecube("	894	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	895	) { writecube("	895	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	896	) { writecube("	896	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	897	) { writecube("	897	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	898	) { writecube("	898	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	899	) { writecube("	899	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	900	) { writecube("	900	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	901	) { writecube("	901	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	902	) { writecube("	902	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	903	) { writecube("	903	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	904	) { writecube("	904	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	905	) { writecube("	905	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	906	) { writecube("	906	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	907	) { writecube("	907	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	908	) { writecube("	908	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	909	) { writecube("	909	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	910	) { writecube("	910	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	911	) { writecube("	911	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	912	) { writecube("	912	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	913	) { writecube("	913	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	914	) { writecube("	914	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	915	) { writecube("	915	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	916	) { writecube("	916	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	917	) { writecube("	917	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	918	) { writecube("	918	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	919	) { writecube("	919	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	920	) { writecube("	920	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	921	) { writecube("	921	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	922	) { writecube("	922	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	923	) { writecube("	923	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	924	) { writecube("	924	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	925	) { writecube("	925	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	926	) { writecube("	926	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	927	) { writecube("	927	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	928	) { writecube("	928	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	929	) { writecube("	929	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	930	) { writecube("	930	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	931	) { writecube("	931	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	932	) { writecube("	932	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	933	) { writecube("	933	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	934	) { writecube("	934	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	935	) { writecube("	935	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	936	) { writecube("	936	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	937	) { writecube("	937	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	938	) { writecube("	938	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	939	) { writecube("	939	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	940	) { writecube("	940	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	941	) { writecube("	941	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	942	) { writecube("	942	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	943	) { writecube("	943	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	944	) { writecube("	944	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	945	) { writecube("	945	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	946	) { writecube("	946	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	947	) { writecube("	947	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	948	) { writecube("	948	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	949	) { writecube("	949	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	950	) { writecube("	950	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	951	) { writecube("	951	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	952	) { writecube("	952	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	953	) { writecube("	953	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	954	) { writecube("	954	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	955	) { writecube("	955	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	956	) { writecube("	956	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	957	) { writecube("	957	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	958	) { writecube("	958	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	959	) { writecube("	959	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	960	) { writecube("	960	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	961	) { writecube("	961	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	962	) { writecube("	962	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	963	) { writecube("	963	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	964	) { writecube("	964	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	965	) { writecube("	965	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	966	) { writecube("	966	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	967	) { writecube("	967	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	968	) { writecube("	968	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	969	) { writecube("	969	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	970	) { writecube("	970	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	971	) { writecube("	971	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	972	) { writecube("	972	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	973	) { writecube("	973	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	974	) { writecube("	974	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	975	) { writecube("	975	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	976	) { writecube("	976	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	977	) { writecube("	977	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	978	) { writecube("	978	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	979	) { writecube("	979	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	980	) { writecube("	980	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	981	) { writecube("	981	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	982	) { writecube("	982	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	983	) { writecube("	983	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	984	) { writecube("	984	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	985	) { writecube("	985	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	986	) { writecube("	986	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	987	) { writecube("	987	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	988	) { writecube("	988	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	989	) { writecube("	989	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	990	) { writecube("	990	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	991	) { writecube("	991	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	992	) { writecube("	992	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	993	) { writecube("	993	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	994	) { writecube("	994	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	995	) { writecube("	995	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	996	) { writecube("	996	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	997	) { writecube("	997	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	998	) { writecube("	998	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	999	) { writecube("	999	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1000	) { writecube("	1000	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1001	) { writecube("	1001	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1002	) { writecube("	1002	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1003	) { writecube("	1003	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1004	) { writecube("	1004	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1005	) { writecube("	1005	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1006	) { writecube("	1006	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1007	) { writecube("	1007	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1008	) { writecube("	1008	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1009	) { writecube("	1009	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1010	) { writecube("	1010	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1011	) { writecube("	1011	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1012	) { writecube("	1012	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1013	) { writecube("	1013	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1014	) { writecube("	1014	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1015	) { writecube("	1015	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1016	) { writecube("	1016	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1017	) { writecube("	1017	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1018	) { writecube("	1018	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1019	) { writecube("	1019	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1020	) { writecube("	1020	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1021	) { writecube("	1021	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1022	) { writecube("	1022	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1023	) { writecube("	1023	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}
			if (product == 	1024	) { writecube("	1024	",[5,5,0],2+font_depth+2*product*factor_height-0.1,face="top",up=0, font=font, t=font_depth);}



		

	}
}
