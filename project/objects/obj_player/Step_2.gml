CAMERA.update();


var ele= keyboard_check(vk_pageup)-keyboard_check(vk_pagedown)
var zoom = keyboard_check(vk_home)-keyboard_check(vk_end)
var dist= keyboard_check(vk_insert)-keyboard_check(vk_delete)
CAMERA.orbit.ele+=ele
CAMERA.orbit.dist+=dist
