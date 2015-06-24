
$fs = .5;
module greebles(l, w, h, resolution, symmetry) {
    length = l;
    if (symmetry == true) {
        width = w/2;
    } else {
        width =w; 
    };
    height = h;
    featureCount = min(l/resolution, w/resolution);
    for(i=[0:featureCount]) {
        intersection() {
            union() {
                translate([.75*l/2, 0, 0]) cylinder(h+2, w/3, w/3, true);
                translate([.25*l/2, 0, 0]) cube([.5*l, w/4, w], true);
                translate([-.25*l/2, 0, 0]) cylinder(h+2, w/3, w/3, true);
                translate([-.75*l/2, 0, 0]) cube([.5*l, w/4, w], true);
                translate([0, 0, -h-w/4]) rotate([0, 90, 0]) cylinder(l+2, w/3, .65*w, true); 
            }
            translate([0, 0, -h/2]) cube([l, w, h+1], true);
        } 
        }
    difference() {
        translate([0, 0, -(h+1)/2]) cube([l+1, w+1, h+1], true);
        translate([0, 0, -h/2]) cube([l, w, h+1], true);
    } 
}
greebles(20, 5, 2, 1, false);