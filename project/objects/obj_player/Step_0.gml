// Get Input
hsp = input.horizontal;
vsp = input.vertical;

//make it relative to the camera
var input_dir = (point_direction(0,0,hsp,vsp))+90;
var input_mag = point_distance(0,0,hsp,vsp);
var cam_dir   = point_direction(x, y, camera.from.x, camera.from.y);
var char_dir  = cam_dir + input_dir;

//camera relative 
hsp = lengthdir_x(input_mag, char_dir) * move_spd;
vsp = lengthdir_y(input_mag, char_dir) * move_spd;



//collision
if (hsp!=0){
	if (place_meeting(x + hsp, y, obj_wall)) {
	    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
	        x += sign(hsp);
	    }
	    hsp = 0;
	}
}
if (vsp!=0){
	if (place_meeting(x, y + vsp, obj_wall)) {
	    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
	        y += sign(vsp);
	    }
	    vsp = 0;
	}
}
//Apply
x+=hsp;
y+=vsp;

// facing direction
if (hsp != 0 || vsp != 0) {
    facing = point_direction(0,0,hsp, vsp);
    facing=rollover_angle(facing);

}

//camera rotation 
if !input.dialog{
  camera.rotate_orbit(input.rotate);
}

if keyboard_check_released(vk_tab){camera.snap=!camera.snap}
  
