function Prism(spr)constructor{
  self.spr=spr;
  update=function(){

  }
  draw=function (x,y,){
    draw_sprite(spr,0,x,y)
  }
}

function draw_sprite_billboard(sprite,subimg,x,y,z,xrot=0,yrot=0,zrot=0,xscale=1,yscale=1,rot=0,color=c_white,alpha=1){
	matrix_set(matrix_world, matrix_build(x, y, z, -90+xrot, yrot, zrot, 1, 1, 1));
	draw_sprite_ext( sprite, subimg, 0, 0, xscale, yscale, rot, color, alpha );
	matrix_set(matrix_world, matrix_build_identity());
}

function Prism_(sprite,shadow=-1,num=8)constructor{
	index=sprite;
	image=0;
	sub=num;
	sub_angle=360/num	
	anim_length=sprite_get_number(index)/num;
	anim_frame=0;
	anim_speed=0.25;
	anim_angle=0;
	self.shadow=shadow;

	step=function(dir){
		var zdir=rollover(dir-(CAMERA.orbit.dir+90),0,360);
		zdir=rollover(zdir,0,360);
		anim_frame+=anim_speed;
		if anim_frame>=anim_length{anim_frame=0;}
		anim_angle=(round(zdir/sub_angle));
		image=(anim_angle*anim_length)+anim_frame;
	}
    //*******************************************************************************

	set_sprite=function(sprite){
		index=sprite;
		anim_length=sprite_get_number(index)/sub;
	}
    //******************************************************************************

	set_shadow=function(sprite){
		shadow=sprite;	
	}//******************************************************************************
	

	draw=function(x,y,z,sx=1,sy=1,ir=0,cc=c_white,aa=1){
		draw_3d_billboard(index,image,x,y,z,sx,sy,ir,cc,aa);
		if sprite_exists(shadow){
			draw_3d_sprite(shadow,0,x,y,z-0.1,90,0,0)
		}
	}//******************************************************************************
	
	

	draw_plane=function(x,y,z,rx=0,ry=0,rz=0,sx=1,sy=1,ir=0,cc=c_white,aa=1){
		draw_3d_sprite(index,image,x,y,z,rx,ry,rz,sx,sy,ir,cc,aa)
	}
}






function draw_3d_sprite(ss,ii,xx,yy,zz,rx=0,ry=0,rz=0,xs=1,ys=1,ir=0,cc=c_white,aa=1){
	matrix_set(matrix_world, matrix_build(xx, yy, zz, -90+rx, ry, rz, 1, 1, 1));
	draw_sprite_ext( ss, ii, 0, 0, xs, ys, ir, cc, aa );
	matrix_set(matrix_world, matrix_build_identity());
}



function draw_3d_billboard(ss,ii,xx,yy,zz,sx=1,sy=1,ir=0,cc=c_white,aa=1){
	matrix_set(matrix_world, matrix_build(xx, yy, zz, -90+0, 0, CAMERA.orbit.dir+90, 1, 1, 1.25));
	draw_sprite_ext( ss, ii, 0, 0, sx, sy, ir, cc, aa );
	matrix_set(matrix_world, matrix_build_identity());
}
