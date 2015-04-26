module enginePylon(a, l, r) {
	//translate([0, -2, 0]) cube([l, 4, 8], false);
	resize(newsize=[0.85*l, l/3.5, 0.5*l]) rotate([0, 90, 0]) cylinder(0.85*l, 4, 4,false);
	rotate([0, a, 0]) translate([0.85*l-1, 0, a/6]) engine(r, l);
}

module engine(r, l) {
	cylinder(l, r, r, true);
}

module deltaType(s, t, a, sw, e) {
/*
s= span
t= thickness
a= aspect ratio (0<x)
sw= wing sweep (0-1)
e= number of engines
*/
	//body
	l = s/a;
	hull() {
		resize(newsize=[0, t, l]) sphere(t);
		//"wings"
		translate([0, -s/17, l*(sw-.5)]) cube([s, t/10, 2], true);
	}
	//engines
	r = s/(2*e);
	if (floor(e/2) != ceil(e/2)) translate([0, 0, l/3]) engine(r, l/3);
	for (i=[0:1]) {
		for (k=[1:1:(e/2)]) {
			rotate([0, 0, i*(180)]) 
				translate([k*s/(2.05*e), 0  , (+l/2)-(k/(e+1))*2.1*(1-sw)*l]) 
					engine(min(t/2.5,(k+1)*r/(2*k)), l/2);
		}
	}
}
module radialType(p, r, l, a, re) {
    /*
p = number of pylons
r = main body radius
l = length
a = wing/pylon sweep 0-40 deg
re = engine radius
*/
	//body
	hull() {
		sphere(r);
		translate([0, 0, l-1.5*r]) sphere(r/2);
	}
	//pylons
	for (i=[0:p]) {
		rotate([0, -a, i*(360/p)])
            translate([(r/2)-1, 0, l/3])
                enginePylon(a, l/2, re);
	}
}
module fighterHull(scale) {
    r=scale*3;
        hull() {
            resize(newsize=[0, r, r]) sphere(r);
            translate([2*r,0,-scale]) cube([scale], true);
            translate([-1.5*r,0,scale]) cube([scale], true);
        };
    }
module displayShips(s, sp) {
// display code
for (i=[0.9:0.16:2]) {
	for (k=[0.25:0.15:0.75]) {
		for (j=[1:1:7]) {
			translate([sp*(i-0.9)*10*s, (sp*j)*s, -sp*(0.25-k)*10*s]) deltaType(s, s/4, i, k, j);
		}
	}
}

for (i=[5:5:35]) {
	for (k=[10:5:25]) {
		for (j=[2:7]) {
			translate([sp*(i-5)*30, -sp*(j-1)*150, -sp*(10-k)*30]) radialType(j, k, s, i);
		}
	}
}
}
module rocketType(l, t, f, e) {}
module moduleType() {}
module splitType() {}

fighterHull(2.5);
translate([2, 0, -1]) rotate([90,0,-90]) deltaType(30, 4, 1.65, 0.65, 2);