// These variables specify the default depth and height of the baseplate
BASE_DEFAULT_HEIGHT =   4; //milimeters
BASE_DEFAULT_DEPTH  = 120; //milimeters


// These variables only need to be modified if you have extreme baseplate sizes
feet_width  = 6;
feet_depth  = 5;
feet_height = 2;
feet_lock_width = 12;
feet_lock_depth =  4;
feet_border = 20;


// This is the code to generate a baseplate-connector (foot)
// You likely won't need to edit this code, unless you want to change the shape.
module foot(x, y, z, d){
    translate(v = [x-1, y-d/2, z-d]) {
        cube([feet_depth+2,feet_width+d,feet_height+d]);
        translate([feet_depth+1-d/2,
                   0-(feet_lock_width - feet_width)/2, 0]){
            cube([feet_lock_depth+d,feet_lock_width+d,feet_height+d]);
        }
    }
}