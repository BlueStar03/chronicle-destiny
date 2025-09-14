function Dbug() constructor{
  system={
    platform:PLATFORM,
    controller:"ERROR",

    draw:function(){
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
    draw_text_outline(SCREEN.topleft.x+1,SCREEN.topleft.y+1,platform,PLATFORM.color)
},
  }
  
  build={
    draw:function (){
      draw_set_halign(fa_left);
      draw_set_valign(fa_bottom)
      draw_text_outline(SCREEN.bottomleft.x+1,SCREEN.bottomleft.y-1,VERSION)
    }
  }
  
	draw=function(){
		draw_set_font(fnt_dbug);
    system.draw();
    build.draw();
	}

}