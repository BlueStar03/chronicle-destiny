// get inputs

var key_right=keyboard_check(ord("D"));//keyboard_check(vk_right);
var key_left=keyboard_check(ord("A"));//keyboard_check(vk_left);
var key_up=keyboard_check(ord("W"));//keyboard_check(vk_up);
var key_down=keyboard_check(ord("S"));//keyboard_check(vk_down);

xspd=(key_right-key_left)*mspd;
yspd=(key_down-key_up)*mspd;



if place_meeting(x+xspd,y,obj_wall){
    xspd=0;
}
if place_meeting(x,y+yspd,obj_wall){
    yspd=0;
}






x+=xspd;
y+=yspd;
