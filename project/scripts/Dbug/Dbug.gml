function Dbug() constructor{
	draw=function(){
		draw_set_font(fnt_dbug);
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);
		var xx=0;
		var yy= window_get_height();
		draw_text_outline(xx,yy,VERSION)
	}

}