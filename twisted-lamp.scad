radius = 20;
thickness = 0.8;
height = 70;
height_floor = 1.2;
twist = 150;
corners = 7;

module bottom(rad) {
    circle(r=rad, $fn=corners);
}

module base_shape() {
    difference() {
        linear_extrude(height=height, twist=twist) bottom(rad=radius);
        linear_extrude(height=height, twist=twist) bottom(rad=radius-thickness);
    }
    linear_extrude(height=height_floor, twist=twist*height_floor/height) bottom(rad=radius);
}

base_shape();