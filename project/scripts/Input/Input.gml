function Input() constructor {
	key={
		left:ord("A"),
		right:ord("D"),
		up:ord("W"),
		down:ord("S"),
		
		rot_left:ord("Q"),
		rot_right:ord("E"),

    dialog:ord("J"),
    silence:ord("F"),
		

	}
	
	
	horizontal=0;
	vertical=0;
	rotate=0;
  dialog=false;
  silence=false;
	update=function(){
		horizontal = keyboard_check(key.right)-keyboard_check(key.left);
		vertical = keyboard_check(key.down)-keyboard_check(key.up);
		rotate = keyboard_check(key.rot_left)-keyboard_check(key.rot_right);
    dialog=keyboard_check(key.dialog);
    silence=keyboard_check(key.silence);
		
		var len = abs(horizontal) + abs(vertical);
		if (len == 2) { // pressed both axes (diagonal)
			var inv = 1 / sqrt(2);
			horizontal *= inv; 
			vertical *= inv;
		}
	}
}