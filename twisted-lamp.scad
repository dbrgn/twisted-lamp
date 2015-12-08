radius = 20;
wall_thickness = 0.8;
height = 70;
height_floor = 1.4;
twist = 150;
corners = 7;
led_diameter = 5;
mounting_hole_diameter = 1;
mounting_hole_count = 3;

/// The "floor"
module bottom(rad) {
    circle(r=rad, $fn=corners);
}

/// The base shape: Bottom plus side walls
module base_shape() {
    difference() {
        linear_extrude(height=height, twist=twist)
            bottom(rad=radius);
        linear_extrude(height=height, twist=twist)
            bottom(rad=radius-wall_thickness);
    }
    linear_extrude(height=height_floor, twist=twist*height_floor/height)
        bottom(rad=radius);
}

/// Hole for the LED
module led_hole() {
    linear_extrude(height=height_floor)
        circle(r=led_diameter/2, $fn=50);
}

/// Mounting holes for the lamp
module mounting_holes() {
    linear_extrude(height=height_floor) {
        for (i=[0:mounting_hole_count-1]) {
            rotate(i * 360 / mounting_hole_count)
                translate([led_diameter, 0, 0])
                    circle(r=mounting_hole_diameter/2, $fn=50);
        }
    }
}

difference() {
    base_shape();
    led_hole();
    mounting_holes();
}