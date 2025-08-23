// Movement speed
spd=0
move_spd = 4;

cam_dist   = 64;      // how far the camera sits from the player
cam_orbit  = 90;     // degrees around the player (270° = below the player looking up)
cam_x      = x;
cam_y      = y + cam_dist;

facing=0;


// Horizontal / vertical input
hsp = 0;
vsp = 0;

z=0;

camera.focus=self
camera.mode="orbit";

story.dialog.set_player_character(self);
model= import_obj("character.obj",vformat);
texture=sprite_get_texture(spr_character,1);

vx=0
vy=0

accel    = 12;      // how quickly you speed up
decel    = 16;      // how quickly you slow down when input stops
max_spd  = 4;       // same as your old move_spd
dead_eps = 0.001;   // snap-to-zero threshold