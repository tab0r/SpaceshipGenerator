/*
p = number of pylons
r = main body radius
l = length
a = wing/pylon sweep
*/
module radialType(p, r, l, a) {
	//body
	hull() {
		sphere(r);
		translate([0, 0, l-1.5*r]) sphere(r/2);
	}
	//pylons
	for (i=[0:p]) {
		rotate([0, -a, i*(360/p)]) translate([(r/2)-1, 0, l/3]) enginePylon(a, 30);
	}
}

module enginePylon(a, l) {
	//translate([0, -2, 0]) cube([l, 4, 8], false);
	resize(newsize=[l, 4, 8]) rotate([0, 90, 0]) cylinder(l, 4, 4,false);
	rotate([0, a, 0]) translate([l-1, 0, a/2]) cylinder(20, 8, 8, true);
}

module engine(r) {
	cylinder(20, r, r, true);
}

/*
s= span
t= thickness
a= aspect ratio (0<x)
sw= wing sweep (0-1)
e= number of engines
*/
module deltaType(s, t, a, sw, e) {
	//body
	l = s/a;
	hull() {
		resize(newsize=[0, t, l]) sphere(t);
		//"wings"
		translate([0, 0, l*(sw-.5)]) cube([s, 2, 2], true);
	}
	//engines
	r = s/(2*e+3);
	for (i=[0:1]) {
		for (k=[1:2:e/2+1]) {
			rotate([0, 0, i*(180)]) translate([k*s/(2*e+1), 0, 5*(3-k)]) engine(r);
		}
	}
}
for (i=[0.6:0.2:3]) {
	translate([i*400, 0, 0]) deltaType(60, 10, i, .5, 4);
}
//translate([0, 0, 30]) deltaType(60, 10, 2, .5, 4);
//translate([100, 0, 0]) radialType(3, 10, 60, 10);

//radialTypeDisplay();

// display code

module radialTypeDisplay() {
for (i=[0:5:30]) {
	translate([i*20, 0, 0]) radialType(5, 20, 40, i);
}

for (i=[2:8]) {
	translate([(i-2)*100, 0, 100]) radialType(i, 20, 40, 15);
}

for (i=[10:5:40]) {
	translate([(i-10)*20, 0, 200]) radialType(3, i, 40, 15);
}

for (i=[10:10:70]) {
	translate([(i-10)*10, 0, 300]) radialType(3, 20, i, 15);
}
}
