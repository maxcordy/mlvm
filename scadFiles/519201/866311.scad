floor_thickness = 1;
wall_thickness = 1.3;
wall_height = 30; // [25:40]
tab_height = 28;
icon = "abbey"; // [none:None,abbey:Abbey and Mayor,bridges:Bridges Castles and Bazaar,catapult:Catapult,count:Count,crop:Crop Circles,ferry:Ferries,flyer:Flyers,gold:Gold Mines,inns:Inns and Cathedrals,king:King,mage:Mage and Witch,messages:Messages,plague:Plague,princess:Princess and Dragon,robbers:Robbers,spielbox:Spielbox,tower:Tower,traders:Traders and Builders,wheel:Wheel of Fortune]

inset = 0.9;

inside_length = 27.5;

/* [Hidden] */
length = inside_length + wall_thickness * 2;
width = 46 + wall_thickness * 2;
fudge = 0.1;

rotate(a=[0,0,-90]) {
difference () {
union () {
difference () {
	cube([width,length,wall_height]);
	translate ([wall_thickness,wall_thickness,floor_thickness]) {
		cube([46,inside_length,wall_height]);
	}
};
translate([0,wall_thickness,wall_height-.01])
rotate(a=[90,0,0])
linear_extrude(height = wall_thickness)
	polygon(points=[[0,0],[10,tab_height],[width - 10,tab_height],[width,0]]);
};

translate([width/2,1.5 - inset + fudge,wall_height + tab_height - 5])
rotate(a=[90,0,180])
	if (icon == "abbey")
		abbey(inset + fudge);
	else if (icon == "bridges")
		bridges(inset + fudge);
	else if (icon == "catapult")
		catapult(inset + fudge);
	else if (icon == "count")
		count(inset + fudge);
	else if (icon == "crop")
		crop(inset + fudge);
	else if (icon == "ferry")
		ferry(inset + fudge);
	else if (icon == "flyer")
		flyer(inset + fudge);
	else if (icon == "gold")
		gold(inset + fudge);
	else if (icon == "inns")
		inns(inset + fudge);
	else if (icon == "king")
		king(inset + fudge);
	else if (icon == "mage")
		mage(inset + fudge);
	else if (icon == "messages")
		messages(inset + fudge);
	else if (icon == "plague")
		plague(inset + fudge);
	else if (icon == "princess")
		princess(inset + fudge);
	else if (icon == "robbers")
		robbers(inset + fudge);
	else if (icon == "spielbox")
		spielbox(inset + fudge);
	else if (icon == "tower")
		tower(inset + fudge);
	else if (icon == "traders")
		traders(inset + fudge);
	else if (icon == "wheel")
		wheel(inset + fudge);
	else if (icon == "m")
		m(inset + fudge);
};
};

module abbey(h) {
  scale([25.4/90, -25.4/90, 1])
  {
    linear_extrude(height=h)
      polygon([[4.699935,4.819935],[5.634285,5.066798],[6.414915,5.744925],[6.978016,6.760539],[7.259905,8.019895],[7.594905,8.639885],[8.259895,8.899885],[11.779845,8.899885],[12.489835,8.589885],[12.779835,7.859895],[12.779835,-1.499985],[12.594835,-2.114975],[12.139845,-2.579965],[0.659995,-8.739885],[0.369995,-8.864885],[0.019995,-8.899885],[-0.659995,-8.739885],[-12.139845,-2.579965],[-12.594835,-2.114975],[-12.779835,-1.499985],[-12.779835,7.859895],[-12.489845,8.589885],[-11.779845,8.899885],[-9.859875,8.899885],[-9.194885,8.639885],[-8.859885,8.019895],[-8.819885,8.019895],[-8.819885,5.379925],[-8.531781,3.944327],[-7.744905,2.774965],[-6.575549,1.988103],[-5.139935,1.699975],[-5.019935,1.699975],[-3.641211,1.967463],[-2.509965,2.699965],[-1.723740,3.792454],[-1.379985,5.139935],[-1.379985,7.859895],[-1.359985,7.939895],[-1.339985,8.019895],[-1.004985,8.639885],[-0.339995,8.899885],[1.099985,8.899885],[1.764975,8.639885],[2.099975,8.019895],[2.388076,6.760539],[2.964965,5.744925],[3.759314,5.066813],[4.699935,4.819935]]);
};
};
module bridges(h) {
  scale([25.4/90, -25.4/90, 1])
  {
    linear_extrude(height=h)
      polygon([[-13.159830,7.079910],[-9.959870,7.079910],[-9.959870,5.199930],[-9.738297,3.193399],[-9.181121,1.361236],[-8.288330,-0.296557],[-7.059910,-1.779980],[-5.576498,-3.008394],[-3.918709,-3.901191],[-2.086542,-4.458373],[-0.080000,-4.679940],[0.120000,-4.679940],[2.128714,-4.458365],[3.964936,-3.901184],[5.628668,-3.008391],[7.119910,-1.779980],[8.356128,-0.296557],[9.254860,1.361236],[9.816107,3.193399],[10.039870,5.199930],[10.039870,7.079910],[13.159830,7.079910],[13.159830,-7.079910],[-13.159830,-7.079910]]);
};
};
module catapult(h) {
difference()
{
  scale([25.4/90, -25.4/90, 1])
  {
    linear_extrude(height=h)
         polygon([[-9.779880,8.079900],[-8.689890,9.349880],[-7.059910,9.839870],[-5.429930,9.349880],[-4.339950,8.079900],[4.699940,8.079900],[5.789920,9.349880],[7.419900,9.839870],[9.049880,9.349880],[10.139870,8.079900],[10.939860,8.079900],[10.939860,5.399930],[10.059870,5.399930],[9.289880,4.484940],[8.219890,3.959950],[2.059970,-5.119930],[1.939970,-5.119930],[1.939970,-5.159930],[0.060000,-5.159930],[0.060000,-9.799870],[-0.020000,-9.819870],[-0.100000,-9.839870],[-1.266868,-9.595477],[-2.234970,-8.934880],[-2.895598,-7.966755],[-3.139960,-6.799910],[-2.956215,-5.775535],[-2.449970,-4.904940],[-1.688738,-4.251809],[-0.739990,-3.879950],[-0.739990,5.399930],[-4.419950,5.399930],[-5.514930,4.274940],[-7.059910,3.839950],[-8.604890,4.274950],[-9.699880,5.399930],[-10.939860,5.399930],[-10.939860,8.079900]]);
	};
  scale([25.4/90, -25.4/90, 1])
  {
    linear_extrude(height=h)
           polygon([[5.419930,4.639940],[5.069930,5.004940],[4.779940,5.399930],[1.939970,5.399930],[1.939970,-0.439990]]);
	};
};
};
module count(h) {
  scale([25.4/90, -25.4/90, 1])
  {
    linear_extrude(height=h)
      polygon([[-11.179855,-2.259990],[-11.259855,9.579860],[11.259855,9.539860],[11.179855,-3.899970],[10.659865,-3.899970],[9.459875,-1.779990],[9.499875,-1.659990],[9.939875,-1.340000],[9.979875,-0.220010],[9.739885,0.099980],[9.739885,0.979970],[9.379885,1.499970],[9.379885,1.579970],[9.459885,1.579970],[9.459885,1.699970],[9.499885,1.699970],[9.539885,2.059970],[9.499885,2.059970],[9.499885,2.139970],[9.539885,2.139970],[9.539885,2.659960],[8.459895,2.659960],[7.859905,2.739960],[7.859905,1.859970],[7.899905,1.859970],[7.899905,1.779970],[7.859905,1.739970],[7.819905,1.659970],[7.819905,1.579970],[6.739925,-0.500000],[6.699925,-1.059990],[6.619925,-0.460000],[5.779935,1.539970],[5.779935,1.619970],[5.739935,1.619970],[5.819935,1.739970],[5.939935,1.739970],[5.979935,2.939960],[5.859935,3.019960],[5.859935,3.099960],[5.899935,3.099960],[5.899935,3.139960],[5.699935,3.179960],[5.459935,3.219960],[5.459935,3.419960],[5.659935,3.419960],[5.619935,3.619960],[5.499935,3.619960],[5.459935,3.539960],[5.339935,3.619960],[5.339935,4.139950],[5.219945,4.139950],[5.259945,4.259950],[5.339945,4.299950],[5.339945,4.819940],[2.979985,4.899940],[2.979985,4.859940],[3.059985,4.819940],[3.059985,4.699940],[2.979985,4.699940],[2.979985,2.619970],[3.174975,2.169980],[2.619985,1.779980],[1.140005,1.384990],[-0.339975,0.899990],[-0.379975,0.740000],[-0.379975,-1.939970],[-0.299975,-1.979970],[-0.219975,-2.259970],[-0.379975,-2.419960],[-0.379975,-3.099960],[-0.339975,-3.099960],[-0.339975,-3.259950],[-0.419975,-3.379950],[-0.459975,-5.979920],[-0.259975,-6.139920],[-0.699975,-7.579900],[-0.899965,-7.739900],[-2.059955,-7.939890],[-2.339955,-7.979890],[-2.419955,-8.259890],[-2.374955,-8.359890],[-2.419955,-8.459890],[-2.419955,-8.659880],[-2.269955,-8.559880],[-2.179955,-8.459880],[-2.084955,-8.269880],[-1.779955,-8.019880],[-1.699955,-8.019880],[-1.714955,-8.199880],[-1.699955,-8.379880],[-1.539965,-8.209880],[-1.379965,-8.099880],[-1.299965,-8.179880],[-1.579965,-8.584880],[-1.859955,-8.899870],[-2.104955,-9.284870],[-2.379955,-9.579860],[-2.539945,-9.579860],[-2.539945,-8.459880],[-2.619945,-8.389880],[-2.579945,-8.259880],[-2.619945,-7.939880],[-2.979945,-7.939880],[-4.939915,-7.499890],[-4.939915,-7.219890],[-4.859915,-7.179890],[-4.859915,-7.019890],[-4.739925,-6.939890],[-4.699925,-4.099920],[-4.819915,-4.099920],[-4.819915,-3.899930],[-4.779915,-3.899930],[-4.739915,-2.979940],[-4.859905,-2.939940],[-4.859905,-2.779940],[-4.779905,-2.739940],[-4.779905,-1.419960],[-4.859905,1.620000],[-6.179895,1.620000],[-6.219895,-1.739950],[-7.499875,-2.539940],[-7.979865,-2.499940],[-7.979865,-2.059950],[-7.939865,-2.059950],[-7.939865,-1.859950],[-8.699855,-2.379940]]);
	};
};

module crop(h) {
  scale([25.4/90, -25.4/90, 1])
	union() {
    linear_extrude(height=h)
      polygon([[-0.719995,6.579910],[-0.879995,8.099890],[-0.550625,9.979249],[0.434995,11.524850],[2.073091,12.627965],[4.359945,13.179830],[4.399945,12.139840],[2.678081,11.689225],[1.424975,10.814860],[0.659360,9.513005],[0.399995,7.779900],[0.439995,6.819910],[-0.020005,5.874920],[-0.719995,6.579910]]);
    linear_extrude(height=h)
      polygon([[0.159995,4.779940],[0.039995,5.339930],[0.259995,5.844920],[0.839985,6.019920],[1.619975,5.829920],[2.519965,5.219930],[3.464955,3.674950],[4.199945,1.739980],[1.909975,2.884960],[0.903731,3.579336],[0.159995,4.779940]]);
    linear_extrude(height=h)
      polygon([[-2.719965,5.179930],[-1.834975,5.789920],[-1.039985,5.979920],[-0.479995,5.804920],[-0.279995,5.299930],[-0.399995,4.739940],[-1.137493,3.539961],[-2.129975,2.849960],[-4.399945,1.739980],[-3.664955,3.639950],[-2.719965,5.179930]]);
    linear_extrude(height=h)
      polygon([[-2.679965,2.259970],[-1.799985,2.869960],[-1.039985,3.059960],[-0.459995,2.864960],[-0.240005,2.339970],[-0.359995,1.819970],[-1.079993,0.637500],[-2.069975,-0.050000],[-4.319945,-1.139990],[-3.604955,0.754990],[-2.679965,2.259970]]);
    linear_extrude(height=h)
      polygon([[0.199995,1.739980],[0.079995,2.299970],[0.299995,2.804960],[0.879985,2.979960],[1.659975,2.789960],[2.559965,2.179970],[3.504955,0.639990],[4.239945,-1.259990],[1.919975,-0.090000],[0.921231,0.585001],[0.199995,1.739980]]);
    linear_extrude(height=h)
      polygon([[0.199995,-1.179990],[0.079995,-0.619990],[0.299995,-0.095000],[0.879985,0.100000],[1.674975,-0.090000],[2.559965,-0.699990],[3.504955,-2.259970],[4.239945,-4.179950],[1.949975,-3.069960],[0.943731,-2.379960],[0.199995,-1.179990]]);
    linear_extrude(height=h)
      polygon([[-2.679965,-0.739990],[-1.794985,-0.130000],[-0.999995,0.060000],[-0.439995,-0.115000],[-0.240005,-0.619990],[-0.359995,-1.179990],[-1.091242,-2.362460],[-2.069975,-3.049960],[-4.319945,-4.139950],[-3.604955,-2.244970],[-2.679965,-0.739990]]);
    linear_extrude(height=h)
      polygon([[-2.679965,-3.659950],[-1.794985,-3.049960],[-0.999995,-2.859960],[-0.439995,-3.034960],[-0.240005,-3.539960],[-0.359995,-4.099950],[-1.097492,-5.306166],[-2.089975,-6.009920],[-4.359945,-7.139910],[-3.624955,-5.219930],[-2.679965,-3.659950]]);
    linear_extrude(height=h)
      polygon([[0.199995,-4.139950],[0.079995,-3.579960],[0.279995,-3.074960],[0.839985,-2.899960],[1.634975,-3.089960],[2.519965,-3.699950],[3.464955,-5.239930],[4.199945,-7.139910],[1.929975,-6.029920],[0.937481,-5.339920],[0.199995,-4.139950]]);
    linear_extrude(height=h)
      polygon([[0.319995,-6.939910],[0.199995,-6.459920],[0.394995,-5.989920],[0.919985,-5.819930],[2.439965,-6.539920],[3.269955,-7.934900],[3.919945,-9.659880],[1.879975,-8.644890],[0.983731,-8.011756],[0.319995,-6.939910]]);
    linear_extrude(height=h)
      polygon([[-2.479975,-6.539920],[-1.679985,-5.999920],[-0.999995,-5.819930],[-0.474995,-5.989930],[-0.279995,-6.459920],[-0.399995,-6.939910],[-1.063743,-8.011756],[-1.959975,-8.644890],[-3.999955,-9.659880],[-3.329955,-7.934900],[-2.479975,-6.539920]]);
    linear_extrude(height=h)
      polygon([[0.199995,-9.259880],[0.079995,-8.859890],[0.244995,-8.499890],[0.679985,-8.379890],[1.254985,-8.509890],[1.919975,-8.939890],[2.614965,-10.064870],[3.159955,-11.459850],[1.484975,-10.644860],[0.746856,-10.137972],[0.199995,-9.259880]]);
    linear_extrude(height=h)
      polygon([[-1.999975,-9.019890],[-1.349985,-8.534890],[-0.759995,-8.379890],[-0.359995,-8.504890],[-0.200005,-8.899890],[-0.280005,-9.259880],[-0.756882,-10.174226],[-1.454995,-10.724860],[-3.079975,-11.619850],[-2.629975,-10.184870],[-1.999985,-9.019890]]);
    linear_extrude(height=h)
      polygon([[-1.399985,-11.139860],[-0.939995,-10.619860],[-0.479995,-10.459870],[-0.225005,-10.559870],[-0.120005,-10.899860],[-0.120005,-11.019860],[-0.724995,-12.249840],[-1.719985,-13.179830],[-1.634985,-12.069850],[-1.399985,-11.139860]]);
    linear_extrude(height=h)
      polygon([[-0.000005,-11.019860],[-0.000005,-10.899860],[0.104995,-10.559870],[0.359995,-10.459870],[0.819985,-10.619860],[1.279985,-11.139860],[1.534975,-12.069850],[1.639975,-13.179830],[0.624985,-12.249840],[-0.000005,-11.019860]]);
};
};

module ferry(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-8.499890,3.339955],[8.499890,3.339955],[12.339840,-1.099985],[12.339840,-3.339955],[0.300000,-2.979965],[-12.339840,-3.339955],[-12.339840,-1.099985]]);
  }
}

module flyer(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-12.739835,4.059950],[-11.049855,3.934950],[-9.419875,3.899950],[-4.969316,4.251811],[-0.904985,5.274930],[2.791826,6.920541],[6.139925,9.139880],[6.539915,8.579890],[5.219935,7.699900],[5.981155,5.658682],[7.109905,3.849950],[8.583620,2.266228],[10.379865,0.899990],[12.699835,1.019990],[12.739835,0.500000],[10.619865,0.380000],[8.859885,-2.234970],[8.299895,-4.819940],[8.559885,-6.619910],[9.299875,-8.419890],[11.139855,-8.579890],[11.099855,-9.139880],[7.626766,-8.602691],[4.247433,-7.673638],[0.961853,-6.352721],[-2.229975,-4.639940],[-8.002401,-0.556234],[-12.739835,4.059950]]);
  }
}

module gold(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-8.759885,3.519950],[8.759885,3.519950],[5.959925,-3.519950],[-5.959925,-3.519950]]);
  }
}

module inns(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-10.639865,9.759870],[-10.874865,10.429870],[-10.959865,11.039860],[-10.514865,12.104840],[-9.319885,12.479840],[-9.239885,12.479840],[-3.599955,12.479840],[-2.864965,12.114840],[-2.279975,11.239850],[-0.000005,6.599910],[0.039995,6.599910],[2.279965,11.239850],[2.864955,12.114840],[3.599955,12.479840],[9.279875,12.479840],[9.359875,12.479840],[10.534865,12.104840],[10.959855,11.039860],[10.639865,9.759870],[6.519915,1.039990],[8.989885,0.624990],[11.039855,-0.000000],[11.834845,-0.539990],[12.119845,-1.319980],[11.899845,-2.119970],[11.199855,-3.039960],[7.959895,-5.389930],[3.639955,-7.079910],[3.386824,-9.374862],[2.724965,-11.069860],[1.620590,-12.119824],[0.039995,-12.479840],[-0.000005,-12.479840],[-1.586864,-12.119835],[-2.704965,-11.069860],[-3.380589,-9.374863],[-3.639955,-7.079910],[-7.959905,-5.389930],[-11.199855,-3.039960],[-11.899855,-2.119970],[-12.119845,-1.319980],[-11.834845,-0.539990],[-11.039865,-0.000000],[-8.969885,0.624990],[-6.479915,1.039990]]);
  }
}

module king(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-10.619865,7.699900],[10.619865,7.699900],[10.579865,-0.499990],[11.259855,-7.579900],[7.859895,-0.739990],[5.619925,-7.619900],[2.859965,-0.739990],[0.019995,-7.699900],[-2.819965,-0.739990],[-5.619925,-7.619900],[-7.859905,-0.739990],[-11.259855,-7.579900],[-10.579865,-0.499990]]);
  }
}

module mage(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-10.799860,8.439890],[-10.558457,8.972388],[-9.950498,9.459884],[-7.634900,10.299870],[-4.201825,10.869861],[0.000000,11.079860],[4.201810,10.869861],[7.634900,10.299870],[9.950479,9.459884],[10.558445,8.972388],[10.799860,8.439890],[10.503604,7.828029],[9.659870,7.264910],[6.599910,6.359920],[0.000000,-11.079860],[-6.639920,6.359920],[-9.679880,7.264910],[-10.509866,7.828033],[-10.799860,8.439890]]);
  }
}

module messages(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-11.839845,6.379920],[-11.839845,6.739920],[-11.384855,8.229900],[-9.759875,9.179880],[7.839905,9.179880],[6.804275,8.936135],[6.124925,8.489890],[5.639925,7.259910],[5.694925,6.819920],[5.839925,6.379920]]);
    linear_extrude(height=h)
      polygon([[10.719865,-9.179880],[7.479905,-9.179880],[-6.199915,-9.099880],[-7.021164,-8.839249],[-7.579905,-8.094890],[-7.999895,-5.379930],[-7.964895,-4.159940],[-7.839895,-2.819960],[-7.434905,1.009990],[-7.239905,4.419950],[-7.279905,5.579930],[6.919915,5.539930],[6.959915,5.579930],[6.454915,6.389920],[6.279925,7.379910],[6.289925,7.699900],[6.359925,8.019900],[7.019925,8.689890],[8.039905,8.939890],[8.384905,8.889890],[8.639895,8.779890],[9.198625,8.149900],[9.569885,7.189910],[9.839885,4.459950],[9.659885,1.059990],[9.239895,-2.819960],[9.039895,-5.819920],[9.429895,-8.204890],[9.951116,-8.874241],[10.719875,-9.179880]]);
    linear_extrude(height=h)
      polygon([[10.959855,-9.179880],[10.432975,-8.910472],[10.014875,-8.224890],[9.639875,-6.339920],[9.639875,-6.099920],[11.079855,-6.099920],[11.639855,-6.929910],[11.839845,-7.819900],[11.624855,-8.634890],[10.959855,-9.179880]]);
  }
}

module plague(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-2.399970,-9.279885],[-1.919970,-8.879885],[-1.999970,-7.799905],[-5.389930,-7.099915],[-8.599890,-6.039925],[-9.359880,-5.359935],[-9.229880,-5.079935],[-8.799890,-4.799935],[-5.854920,-4.359945],[-2.159970,-4.159945],[-2.199970,-3.319955],[-6.233050,-2.088710],[-9.384880,-0.369995],[-11.644226,1.843736],[-12.999830,4.559945],[-11.739850,3.414963],[-10.239870,2.719965],[-8.984880,2.604965],[-7.639900,2.159975],[-7.439900,2.159975],[-5.709930,2.059975],[-3.559950,1.959975],[-2.624970,1.999975],[-1.959970,2.159975],[-1.784980,2.564965],[-1.279980,2.879965],[-1.054980,3.414955],[-0.439990,3.919945],[-0.399990,4.279945],[-0.684990,5.244935],[-1.479980,6.119925],[-2.559972,6.834914],[-3.519950,7.879895],[-3.759950,8.479885],[-3.149960,9.209875],[-1.039990,9.759875],[0.574990,10.104865],[2.279970,10.239865],[4.189305,10.068605],[6.274920,9.499875],[8.563000,8.451145],[11.079860,6.839915],[9.574880,5.869925],[8.159900,4.719935],[6.999910,2.639965],[6.559920,-0.279995],[6.569920,-1.029985],[6.639920,-1.839975],[6.994910,-2.639965],[7.199910,-3.559955],[8.379890,-3.539955],[9.559880,-3.519955],[10.939860,-3.559955],[12.319840,-3.719955],[12.839840,-3.989945],[12.999830,-4.319945],[12.399840,-5.119935],[8.079900,-7.079905],[8.514890,-7.999895],[9.399880,-8.559895],[9.814870,-8.859885],[9.479880,-9.159885],[9.019880,-9.304885],[8.559890,-9.359885],[8.279890,-9.334885],[7.999900,-9.279885],[6.584920,-10.029875],[4.479940,-10.239865],[-1.999970,-10.239865],[-2.799960,-9.894875],[-2.399970,-9.279885]]);
  }
}

module princess(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-6.399915,10.639865],[-6.519915,11.359855],[-5.994925,12.594835],[-4.599935,13.079835],[-1.879975,13.039835],[0.020005,13.019835],[1.919975,12.999835],[4.639945,12.999835],[6.014925,12.494835],[6.519915,11.239855],[6.399915,10.479865],[4.279945,4.439945],[3.909955,3.359955],[3.479955,2.159975],[3.319955,1.679975],[6.159925,1.679975],[7.399905,1.159985],[7.919895,-0.079995],[7.919895,-0.119995],[7.399905,-1.359985],[6.159925,-1.879975],[2.239975,-1.879975],[2.319975,-2.079975],[2.844965,-4.059945],[3.039965,-6.399915],[2.812451,-8.945491],[2.179975,-11.074855],[1.217479,-12.536694],[0.000005,-13.079835],[-1.211239,-12.531054],[-2.159975,-11.059855],[-2.778715,-8.928616],[-2.999955,-6.399915],[-2.824965,-4.094945],[-2.319965,-2.119975],[-2.199975,-1.879975],[-6.119915,-1.879975],[-7.379905,-1.359985],[-7.919895,-0.119995],[-7.919895,-0.079995],[-7.379905,1.159985],[-6.119915,1.679975],[-3.319955,1.679975],[-3.479955,2.159975],[-3.929945,3.414955],[-4.319945,4.519945]]);
  }
}

module robbers(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-5.559925,-11.539845],[-5.649925,-11.369855],[-5.679925,-11.139855],[-4.699945,-8.854885],[-2.999965,-6.899905],[-3.539955,-6.454915],[-3.719955,-5.739925],[-3.554955,-5.034935],[-3.119965,-4.539935],[-6.221802,-2.188080],[-7.281945,-0.850444],[-8.014905,0.594995],[-8.840516,3.700587],[-9.039885,7.019915],[-8.994885,9.259885],[-8.919885,11.499855],[-8.093650,12.104850],[-6.509915,12.499845],[-2.839965,12.779835],[2.859955,12.739835],[7.359905,12.579845],[8.504885,11.934845],[8.959885,10.539865],[9.014885,9.444885],[9.039885,8.379895],[8.723004,4.544326],[7.734895,1.094985],[6.019285,-1.941831],[3.519955,-4.539935],[4.079945,-4.969935],[4.279945,-5.699925],[4.099945,-6.364915],[3.559955,-6.819905],[6.009915,-9.264875],[6.552400,-10.267971],[6.719915,-11.139855],[6.499915,-12.009845],[5.919925,-12.699835],[5.879925,-12.699835],[5.184925,-11.934845],[4.159945,-11.139855],[4.119945,-11.139855],[3.509955,-11.414845],[2.959955,-12.019845],[2.264957,-12.594818],[1.599975,-12.779835],[1.199985,-12.724835],[0.799985,-12.579835],[-0.090005,-12.004845],[-0.919995,-11.219855],[-1.379985,-10.894855],[-1.839975,-10.779855],[-2.679965,-11.099855],[-3.539955,-11.549845],[-4.519945,-11.699845],[-5.559935,-11.539845]]);
  }
}

module spielbox(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[10.599865,-2.359970],[-0.000005,-10.079870],[-10.599865,-2.359970],[-6.559915,10.079870],[6.559915,10.079870]]);
  }
}

module tower(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-4.799935,11.259855],[4.799935,11.259855],[4.119945,-6.379915],[5.599925,-6.379915],[5.839925,-11.259855],[4.039945,-11.259855],[4.039945,-9.979875],[2.319965,-9.979875],[2.319965,-11.259855],[0.799985,-11.259855],[0.799985,-9.979875],[-0.799995,-9.979875],[-0.799995,-11.259855],[-2.319975,-11.259855],[-2.319975,-9.979875],[-4.039945,-9.979875],[-4.039945,-11.259855],[-5.839925,-11.259855],[-5.599925,-6.379915],[-4.119945,-6.379915]]);
  }
}

module traders(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-3.919950,6.399920],[-3.559950,6.849910],[-2.959960,6.999910],[-2.294970,6.794910],[-1.959970,6.199920],[-1.999970,4.599940],[0.854990,4.849940],[3.679950,4.919940],[4.999940,4.899940],[6.319920,4.879940],[6.399920,6.319920],[6.739910,6.824910],[7.439900,6.999910],[8.099900,6.824910],[8.399890,6.319920],[8.399890,6.279920],[8.439890,5.519930],[8.973619,4.603694],[9.769870,3.859950],[10.521096,2.876219],[10.919860,1.239980],[10.959860,0.559990],[10.804977,-1.239979],[10.319870,-2.679970],[10.359870,-2.679970],[11.250462,-2.983704],[11.844850,-3.489960],[12.279840,-4.839940],[12.199840,-5.319930],[11.664850,-6.274920],[10.559860,-6.719910],[9.879870,-6.599920],[9.249880,-6.039920],[9.039880,-5.239930],[9.279880,-4.439940],[9.999870,-4.119950],[10.569860,-4.274950],[10.959860,-4.639940],[10.799860,-5.239930],[10.174870,-4.924940],[9.879870,-5.119940],[9.879870,-5.239930],[10.124870,-5.689930],[10.639860,-5.839930],[11.079860,-5.679930],[11.349850,-5.304930],[11.439850,-4.839940],[11.084860,-3.944950],[9.919870,-3.439960],[9.879870,-3.399960],[8.814870,-4.435560],[7.449900,-5.114940],[3.999950,-5.599930],[0.245000,-5.294930],[-3.719950,-4.599940],[-3.679950,-4.879940],[-3.888714,-5.801790],[-4.419940,-6.344920],[-5.879920,-6.999910],[-6.384920,-5.759930],[-6.559920,-4.399940],[-11.679850,-3.079960],[-12.159840,-2.884960],[-12.279840,-2.479970],[-12.259840,-2.199970],[-12.239840,-1.919980],[-12.149840,-1.604980],[-12.119840,-1.319980],[-12.139840,-1.019990],[-12.159840,-0.719990],[-12.029840,-0.245000],[-11.479850,0.319990],[-10.534860,1.044990],[-7.639900,1.559980],[-7.177414,2.401224],[-6.279920,3.189960],[-3.959950,4.999930]]);
  }
}

module m(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[14.228490,14.003905],[8.564430,14.003905],[8.564430,-2.753905],[8.798810,-8.750005],[8.642560,-8.750005],[8.330060,-7.500005],[7.978490,-6.318365],[7.636700,-5.322265],[7.353490,-4.609375],[2.040990,5.605465],[-2.373070,5.605465],[-7.509790,-4.648445],[-7.724630,-5.205085],[-8.017600,-6.123055],[-8.339860,-7.324225],[-8.623070,-8.750005],[-8.798850,-8.750005],[-8.603540,-5.371095],[-8.544940,-2.773445],[-8.544940,14.003905],[-14.228540,14.003905],[-14.228540,-14.003905],[-6.494160,-14.003905],[-1.552760,-4.277345],[-1.123070,-3.281255],[-0.703150,-2.226565],[-0.332050,-1.201175],[-0.087910,-0.273445],[0.009790,-0.273445],[0.263700,-1.240235],[0.556670,-2.324225],[0.888700,-3.388675],[1.259790,-4.316405],[6.337920,-14.003905],[14.228540,-14.003905]]);
  }
}
