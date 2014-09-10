include <config.scad>
use <GDMUtils.scad>
use <joiners.scad>


module rail_segment()
{
	color([0.9, 0.7, 1.0]) difference() {
		union() {
			difference() {
				union() {
					// Bottom.
					translate([0,0,rail_thick/2]) yrot(90)
						sparse_strut(h=rail_width, l=rail_length, thick=rail_thick, maxang=45, strut=10, max_bridge=500);

					// Walls.
					zrot_copies([0, 180]) {
						translate([(rail_spacing+joiner_width)/2, 0, (rail_height+3)/2]) {
							thinning_wall(h=rail_height+3, l=rail_length-10, thick=joiner_width, strut=rail_thick, bracing=false);
						}
					}
				}

				// Clear space for joiners.
				translate([0,0,rail_height/2]) {
					joiner_quad_clear(xspacing=rail_spacing+joiner_width, yspacing=rail_length, h=rail_height, w=joiner_width, a=joiner_angle);
				}
			}

			// Rail backing.
			grid_of([-(rail_spacing/2+joiner_width/2), (rail_spacing/2+joiner_width/2)])
				translate([0,0,rail_height+roller_thick/2])
					cube(size=[joiner_width, rail_length, roller_thick], center=true);

			// Snap-tab joiners.
			translate([0,0,rail_height/2]) {
				joiner_quad(xspacing=rail_spacing+joiner_width, yspacing=rail_length, h=rail_height, w=joiner_width, l=5, a=joiner_angle);
			}

			zrot_copies([0, 180]) {
				translate([0, rail_length/2-8, rail_height/4]) {
					difference() {
						// Side supports.
						cube(size=[rail_width, 3, rail_height/2], center=true);

						// Wiring access holes.
						grid_of(xa=[-rail_width/4, rail_width/4])
							cube(size=[8, 5, 10], center=true);
					}
				}
			}
		}

		// Rail grooves.
		translate([0,0,rail_height+roller_thick/2]) {
			grid_of([-(rail_spacing/2), (rail_spacing/2)]) {
				scale([tan(roller_angle),1,1]) yrot(45) {
					cube(size=[roller_thick*sqrt(2)/2,rail_length+1,roller_thick*sqrt(2)/2], center=true);
				}
			}
		}
	}
}
//!rail_segment();



module rail_segment_parts() { // make me
	rail_segment();
}



rail_segment_parts();



// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
