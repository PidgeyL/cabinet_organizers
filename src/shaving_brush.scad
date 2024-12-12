// Size settings in mm
plate_width  =  80;  // The width of the base-plate
plate_border =  10;  // The border around the pot.
                     // Pot size will be plate_width - plate_border
holder_base_depth  =  20;  // Width of the holder base
holder_depth       =  10;  // Width of the holder
holder_width       =  50;  // Width of the holder
holder_height      = 100;  // Height of the holder
holder_head_length =  60;  // The length of the head
tray_height        =  15;  // The height of the tray
tray_rim           =   3;  // The width of the soap tray
brush_radius       =  16;  // Diameter of the brush
brush_mouth        =  28;  // Width of the brush mouth
corner_radius      =   3;  // How round we want the corners to be

// Modify the base plate:
NO_FEET  = false;  // Remove the connector feet

// Choose here which item you want to generate:
GENERATE = "tray";  // "base" or "tray", "grill"

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module tray_baseplate(){
    depth = BASE_DEFAULT_HEIGHT / 2;
    difference() {
        baseplate(plate_width, no_feet=NO_FEET);
        // Indent with 1 mm wiggle-room
        translate([plate_border-1, plate_border-1, depth + corner_radius]){
            roundedcube([plate_width - plate_border*2 + 2,
                         BASE_DEFAULT_DEPTH - plate_border*2 + 2, depth],
                         false, corner_radius);
        }
    }
}

module tray(){
    tray_width = plate_width - plate_border*2;
    tray_depth = BASE_DEFAULT_DEPTH - plate_border*2;
    height_offset = BASE_DEFAULT_HEIGHT / 2;

    holder_depth_pos = tray_depth - holder_base_depth + tray_rim/2;
    holder_width_pos = (tray_width - holder_width)/2;
    
    drip_tray_depth = tray_depth - tray_rim*2 - holder_base_depth;

    translate([plate_border, plate_border, height_offset]){
        difference(){
            roundedcube([tray_width, tray_depth, tray_height],
                        false, corner_radius);
            translate([tray_rim, tray_rim, tray_rim]){
                roundedcube([tray_width - tray_rim*2,
                             drip_tray_depth,
                             tray_height],
                            false, corner_radius);
            }
            translate([holder_width_pos, holder_depth_pos, tray_rim]){
                roundedcube([holder_width+.2, holder_depth+.2, 
                             holder_height],
                            false, corner_radius);
            }
        }
    }
}

module holder(){
    holder_depth_pos = BASE_DEFAULT_DEPTH - plate_border - holder_base_depth + tray_rim/2;
    holder_width_pos = (plate_width - holder_width)/2;
    holder_height_pos = BASE_DEFAULT_HEIGHT+tray_rim;

    translate([holder_width_pos, holder_depth_pos, holder_height_pos])
        roundedcube([holder_width, holder_depth, holder_height],
                    false, corner_radius);
    head_depth = holder_depth_pos - holder_head_length + holder_depth;
    head_height = holder_height_pos + holder_height - holder_depth;
    difference(){
        translate([holder_width_pos, head_depth, head_height])
            roundedcube([holder_width,
                         holder_head_length,
                         holder_depth],
                        false, corner_radius);
        translate([plate_width/2,
                   head_depth + brush_radius,
                   head_height-1])
            cylinder(h=holder_depth+2,
                     r1=brush_radius,
                     r2=brush_radius,  center=false);
        translate([(plate_width - brush_mouth)/2,
                   head_depth - brush_mouth/2,
                   head_height-1])
            cube([brush_mouth, brush_mouth, brush_mouth]);
    }
}


if (GENERATE == "base")  tray_baseplate();
if (GENERATE == "tray")  tray();

holder();