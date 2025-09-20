
// VERSION
#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vBUILD 1
#macro vTAG "dev"
#macro VERSION "v"+string(vMAJOR)+"."+string(vMINOR)+"."+string(vPATCH)+"."+string(vBUILD)+(string_length(vTAG)>0?"-"+string(vTAG):"")
#macro nVERSION (vMAJOR*1000000 + vMINOR*10000 + vPATCH*100 + vBUILD)
// Tags: a: Alpha | b: Beta | rc: Release Candidate | dev: | GOLD: Final, stable release

#macro LOREM "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam et elementum risus. Etiam condimentum ligula eget purus euismod molestie. Etiam varius, orci dictum bibendum volutpat, lorem nunc congue sapien, eget rutrum arcu urna at dolor. Nam ornare dignissim arcu, quis accumsan dui. Duis rutrum non mi non pellentesque. Donec pharetra augue ante, eget semper tortor varius eu. Nullam quis rhoncus nisl. Curabitur in commodo odio, in laoreet sem."
#macro null undefined
#macro	c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflowerblue #6495ed

// GPU
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);



//SYSTEM
#macro PLATFORM global.__platform
PLATFORM=new Platform();

#macro SCREEN global.__screen
SCREEN=new Screen(640,360,2);

#macro CAMERA global.__camera
CAMERA=new Camera();

#macro INPUT global.__input
INPUT=new Input();

#macro STORY global.__story
STORY=new Story(); 

#macro DBUG global.__dbug
DBUG=new Dbug(); 
