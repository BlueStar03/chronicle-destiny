#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vBUILD 1
#macro vTAG "dev"
#macro VERSION "v"+string(vMAJOR)+"."+string(vMINOR)+"."+string(vPATCH)+"."+string(vBUILD)+(string_length(vTAG)>0?"-"+string(vTAG):"")
#macro nVERSION (vMAJOR*1000000 + vMINOR*10000 + vPATCH*100 + vBUILD)
// Tags: a: Alpha | b: Beta | rc: Release Candidate | dev: | GOLD: Final, stable release


#macro	c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflowerblue #6495ed

// GPU INIT
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);


//SYSTEM

#macro platform global.__platform
platform=new Platform();

#macro screen global.__screen
screen=new Screen(640,360,2);

#macro camera global.__camera
camera=new Camera();

#macro input global.__input
input=new Input();

#macro dbug global.__dbug
dbug=new Dbug(); 

randomize()