#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vCANARY 1
#macro vTAG ""
#macro VERSION "v" + string(vMAJOR) + "." + string(vMINOR) + "." + string(vPATCH)+ "." +string(vCANARY)
//Tags: a=alpha, b= beta, 
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
__camera=new Camera();

#macro input global.__input
__input=new Input();

#macro story global.__story
__story=new Story();

#macro dbug global.__dbug
__dbug=new Dbug(); 