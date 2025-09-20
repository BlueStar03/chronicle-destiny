name ="Player"
// Movement speed
spd=0
move_spd = 4;

facing=0;

z=0;

CAMERA.focus=self
CAMERA.mode="orbit";

//story.dialog.set_player_character(self);
model= import_obj_ext("character.obj");
texture=sprite_get_texture(spr_character,1);

STORY.set_player_character(self);

replies= ["TOP", "next", "third","fourth","fifth","sixth","last", "El Ocho"]