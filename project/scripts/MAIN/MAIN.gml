#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vCANARY 1
#macro VERSION "v" + string(vMAJOR) + "." + string(vMINOR) + "." + string(vPATCH)+ "." +string(vCANARY)

#macro	c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflowerblue #6495ed

// GPU INIT
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);


//SYSTEM
#macro display global.__display
__display=new Display();

#macro camera global.__camera
__camera=new Camera();

#macro input global.__input
__input=new Input();

#macro story global.__story
__story=new Story();

#macro dbug global.__dbug
__dbug=new Dbug(); 