module wing(chord, thickness, span) {
hull() {
    resize([.75*chord, thickness, span]) cylinder(span, thickness, thickness);
    translate([.575*chord, 0, span/2]) cube([.1, .1, span], true);
};
}

wing(30, 10, 100);