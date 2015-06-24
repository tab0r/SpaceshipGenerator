// each ship type is a collection of hulls with features
// shipType(length, resolution, weapons, numEngines)

module enginePylon(a, l, r, resolution) {
	//translate([0, -2, 0]) cube([l, 4, 8], false);
	resize(newsize=[0.85*l, l/3.5, 0.5*l]) rotate([0, 90, 0]) cylinder(0.85*l, 4, 4,false);
	rotate([0, a, 0]) translate([0.85*l-1, 0, a/6]) engine(r, l);
}

module engine(r, l, resolution) {
	cylinder(l, r, r, true);
}

module deltaHull(l, t, a, sw, resolution) {
/*
s= length
t= thickness
a= aspect ratio (0<x)
sw= wing sweep (0-1)
*/
	s = l*a;
	hull() {
		resize(newsize=[0, t, l]) sphere(t);
		//"wings"
		translate([0, -s/17, l*(sw-.5)]) cube([s, t/10, 2], true);
	}
}
module radialFrame(r, scale, numFeatures) {
   union(){
        for (i=[1:numFeatures]) {
            rotate([0,0,i*360/(numFeatures)]) hull() {
                cube(scale, true);
                translate([-scale+r, 0, 0]) cube(scale, true);
            }
        }
        //cube([l, scale, scale], true);
    }
}
module ringHull(ri, ro, l) {
    r = (ro-ri)/2;
    rotate_extrude(convexity = 10)
        hull() {
          translate([ri+r, l/2, 0]) circle(r, $fn = 100);
          translate([ri+r, -l/2, 0]) circle(r, $fn = 100);
        }
        /*
        ringHull(7, 10, 10);
        radialFrame(12, 3, 7);
        */
}
module radialHull(l, r1, r2, resolution) {
/*
l = length
r1 = radius 1
r2 = radius 2
*/
hull() {
		sphere(r1);
		translate([0, 0, l-r1-r2]) sphere(r2);
	}
}

/*
module taperHull(l, r, al, ar, resolution) {
    r=resolution*3;
        hull() {
            resize(newsize=[0, r, r]) sphere(r);
            translate([2*r,0,-resolution]) cube([resolution], true);
            translate([-1.5*r,0,resolution]) cube([resolution], true);
        };
    }

 To Do
module rocketType() {}
module boxHull() {}
module splitHull() {}
	//pylons
    for (i=[0:p]) {
		rotate([0, -a, i*(360/p)])
            translate([(r/2)-1, 0, l/3])
                enginePylon(a, l/2, re);
	}

	//engines
    /*
	r = s/(2*e);
	if (floor(e/2) != ceil(e/2)) translate([0, 0, l/3]) engine(r, l/3);
	for (i=[0:1]) {
		for (k=[1:1:(e/2)]) {
			rotate([0, 0, i*(180)]) 
				translate([k*s/(2.05*e), 0  , (+l/2)-(k/(e+1))*2.1*(1-sw)*l]) 
					engine(min(t/2.5,(k+1)*r/(2*k)), l/2);
		}
	}
    */
