//story.draw();
dbug.draw()
var _string="ele: "+ string(camera.orbit.ele)+", dir: " + string(camera.orbit.dir)+", dist: "+string(camera.orbit.dist)
_string+="\n "+string(camera.from.x)
_string+="\n facing:"+string(obj_player.facing)
draw_set_valign(fa_top);
draw_set_halign(fa_left)
draw_text_outline(1,1,_string)
