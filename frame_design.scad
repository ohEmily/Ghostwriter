unit = 10;

// loop vars
outer_loop_rad = unit * 1.5;
inner_loop_rad = outer_loop_rad / 2;
protruding_loop_rad = inner_loop_rad - 2;
loop_height = unit * 3;
frame_offset = loop_height / 12;

module loop()
{
	translate([0, frame_offset, 0]) rotate([90,0,0]) {
		difference() {
			cylinder(h = loop_height, r = outer_loop_rad, 
				center = true);
			cylinder(h = loop_height, r = inner_loop_rad, 
				center = true);
		}
	}
}

loop();

// frame vars
frame_length_long = unit * 22; // 11 inches
frame_length_short = unit * 17; // 8.5 inches
frame_width = unit * 2;
frame_height = frame_width / 2;
rail_width = frame_width / 4;

// long part, the rails
module frame(frame_len)
{
	translate([0, 0, (-1) * (frame_len / 2 + inner_loop_rad)])
		difference() {
			cube([frame_width, frame_height, frame_len], center = true);
			cube([rail_width, frame_height, frame_len], center = true);
		}
}

module frame_long_side() {
	union() {
		loop();
		frame(frame_length_long);
		translate([0, 0, -1 * (frame_length_long + inner_loop_rad * 2)])
			loop();
	}
}

frame_long_side();

module loop_protruding()
{
		translate([0, frame_offset, 0]) rotate([90,0,0]) {
		union() {
			cylinder(h = loop_height, r = outer_loop_rad, 
				center = true);
			translate([0, 0, loop_height])
				cylinder(h = loop_height, r = protruding_loop_rad, 
					center = true);
		}
	}
}

module frame_short_side()
{
	translate([100, 0, 0]) {
		union() {
			loop_protruding();
			frame(frame_length_short);
			translate([0, 0, -1 * (frame_length_short + protruding_loop_rad * 2)])
				loop_protruding();
			
		}
	}
}

frame_short_side();