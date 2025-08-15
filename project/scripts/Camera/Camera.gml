enum camera_mode {
	none,
	orbit
}

function Camera() constructor{
	mode = camera_mode.none;
	focus = noone;
	from = {x:640/2 ,y:360, z: -360/2};
	to = {x:640/2 ,y:360/2, z: 0};
	up = {x:0 ,y:0, z: 1};
	orbit = { dir: 45, dist: 256, ele: 35.264 };//30
	snap=true;
	
	//pro_mat = matrix_build_projection_perspective_fov(45, window_get_width() / window_get_height(), 1, 32000);
	pro_mat = matrix_build_projection_ortho( (window_get_width()/2) , (window_get_height()/2), 1, 32000);
	

	update = function() {
		switch (mode){
			case camera_mode.none:
				update_none();break;
			case camera_mode.orbit:
				update_orbit();break;
		}
	}
	
	update_none=function(){
		if (focus==noone){return;}
		if (instance_exists(focus)) {
			to.x = focus.x;
			to.y = focus.y;
			to.z = focus.z;
		}else{focus=noone;}
	}
	update_orbit=function(){
		if (focus==noone){mode=camera_mode.none; return;}
		if (instance_exists(focus)){
			to.x=focus.x;
			to.y=focus.y;
			to.z=focus.z;			
		} else{
			focus=noone;
			mode=camera_mode.none;
		}
		orbit.dir=rollover_angle(orbit.dir);
		orbit.ele=rollover_angle(orbit.ele);
		var _ele=degtorad(orbit.ele+90); 
		var _dist= orbit.dist; 
		var _dir=degtorad(orbit.dir);
		from.x = to.x + (_dist*sin(_ele)*cos(_dir));
        from.y = to.y + (_dist*sin(_ele)*sin(_dir));
        from.z = to.z +(_dist*cos(_ele));
	}
	


rotate_orbit = function(val) {
	static snap_sign = 0;	
    var rot = val;	
    orbit.dir += rot;
    orbit.dir = round(orbit.dir);
	orbit.dir=rollover_angle(orbit.dir);
    if (snap) {
        if (abs(rot) < 0.001) {
            var c = orbit.dir;
            var a = 0;

            if (c mod 45 != 0) {
                if (c mod 45 > 22.5) {
                    a += 1;
                } else {
                    a -= 1;
                }
                orbit.dir += a;
            }
        }
    } else {
        if (abs(rot) < 0.001) {
            if (orbit.dir mod 45 != 0) {
                orbit.dir += snap_sign;
            }
        } else {
            snap_sign = sign(rot);
        }
    }
};


	
	
	
	
	
	
	

	draw=function(){
  draw_clear(c_cornflowerblue)
		var _cam = camera_get_active();
camera_set_view_mat(_cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
camera_set_proj_mat(_cam, pro_mat);
camera_apply(_cam);
	}
}
/*
enum camera_mode {
	none,
	orbit
}

function Camera() constructor {
	mode = camera_mode.none;
	focus = noone;
	from = {x:640/2 ,y:360*2, z: -360/2};
	to = {x:640/2 ,y:360/2, z: 0};
	up = {x:0 ,y:0, z: 1};
	orbit = {dir: 315,distance: 315,elevation: 30};//DIST384,
	dir=point_direction(from.x, from.y, to.x, to.y);
	zoom=2
	


	//pro_mat = matrix_build_projection_perspective_fov(60/2, display.get_width() / display.get_height(), 1.0, 32000.0);
	//pro_mat = matrix_build_projection_ortho(display.get_width()/zoom , display.get_height()/zoom, -128,32000);
	
	pro_mat = matrix_build_projection_perspective_fov(60/2,window_get_width()/window_get_height(),1,32000);
	//pro_mat = matrix_build_projection_ortho((display.width*display.s_scale)/zoom , (display.height*display.s_scale)/zoom, -128,32000);

	static snap = true;
	

	update = function() {
		switch mode{
			case camera_mode.none:
				update_none();break;
			case camera_mode.orbit:
				update_orbit();break;
		}
		dir=get_direction();
		
  };
	update_none=function(){
		if (focus==noone){return;}
		if (instance_exists(focus)) {
			to.x = focus.x;
			to.y = focus.y;
			to.z = focus.z;
		}else{focus=noone;}
	}
	update_orbit=function(){
		if (focus==noone){ mode = camera_mode.none; return;}
		if (instance_exists(focus)) {
				to.x = focus.x;
				to.y = focus.y;
				to.z = focus.z;
			} else {
				focus = noone;
				mode = camera_mode.none;
			}
		orbit.dir = rollover(orbit.dir, 0, 360);
			from.x=to.x+spherecart_x(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
			from.y=to.y+spherecart_y(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
			from.z=to.z+spherecart_z(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
		}
	rotate_orbit=function(val){
		static snap_sign = 0;
		var rot = val;
		if abs(rot)>0.001{
			orbit.dir += rot;
		}else{
			if (orbit.dir mod 45 != 0){
				if snap{
					if (orbit.dir % 45 > 22.5) {snap_sign = +1;} else {snap_sign = -1;}
				}
				orbit.dir += snap_sign;
			}else{ 
				snap_sign = sign(rot);
			}	
		}
		orbit.dir = rollover(orbit.dir, 0, 360);
		orbit.dir = round(orbit.dir);
	}
	
get_direction = function(snap = false) {
    // Calculate the direction from 'from' to 'to' in the XY plane
    var dir = point_direction(from.x, from.y, to.x, to.y);

    // If snapping is enabled, round the direction to the nearest 45 degrees
    if (snap) {
        dir = round(dir / 45) * 45;
    }

    return rollover(dir, 0, 360); // Ensure the direction is between 0 and 360 degrees
};


	draw = function() {
		draw_clear(c_cornflowerblue); // Clear the screen to black
		var cam = camera_get_active();
		camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
		camera_set_proj_mat(cam, pro_mat);
		camera_apply(cam);
	};
}

//camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(60,window_get_width()/window_get_height(),1,32000))
*/