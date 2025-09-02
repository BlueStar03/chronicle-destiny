function Dbug() constructor{
  
  
  build={
    draw:function (){
      draw_set_halign(fa_left);
      draw_set_valign(fa_bottom)
draw_text_outline(screen.bottomleft.x+1,screen.bottomleft.y-1,VERSION)
    }
  }
  
	draw=function(){
		draw_set_font(fnt_dbug);
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);
		var xx=0;
		var yy= window_get_height();
		//draw_text_outline(xx,yy,nVERSION)
    draw_text_outline(100,100,platform,platform.color)
    build.draw();
	}

}