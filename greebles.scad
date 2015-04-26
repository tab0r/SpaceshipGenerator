module greebles(l, w, h, minD, symmetry) {
    length = l;
    if (symmetry == true) {
        width = w/2;
    } else {
        width =w; 
    };
    height = h;
    featureCount = max(l/minD, w/minD);
    for(i=[0:featureCount]) {
}
    difference() {
        cube([l, w, h+1], true);
        translate([0, 0, -5]) cube([l+5, w+5, h+5], true);
} 

greebles(20, 5, 5, 1, false);