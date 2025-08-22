// Movement speed
spd=0
move_spd = 4;

cam_dist   = 64;      // how far the camera sits from the player
cam_orbit  = 90;     // degrees around the player (270° = below the player looking up)
cam_x      = x;
cam_y      = y + cam_dist;



// Horizontal / vertical input
hsp = 0;
vsp = 0;

z=0;

camera.focus=self
camera.mode="orbit";

story.dialog.set_player_character(self);
model= import_obj("sphere.obj",vformat);
texture=sprite_get_texture(Sprite4,1);

