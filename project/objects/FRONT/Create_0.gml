var ts=16;
var td=ts*2;
var zv=0.1

vbuffer=vertex_create_buffer();
vertex_begin(vbuffer,vformat)

for (var i=0; i<room_width;i+=ts){
	for(var j=0; j<room_height; j+=ts){
    var col=c_red
		if((i%td==0&&j%td==0)||(i%td>0&&j%td>0)){ 
			 col=c_green;
		} else {
			 col=c_lime;
		}
		vertex_add_point(vbuffer,i,j,zv,,,,,,col);
		vertex_add_point(vbuffer,i+ts,j,zv,,,,,,col);
		vertex_add_point(vbuffer,i+ts,j+ts,zv,,,,,,col);
		
		vertex_add_point(vbuffer,i+ts,j+ts,zv,,,,,,col);
		vertex_add_point(vbuffer,i,j+ts,zv,,,,,,col);
		vertex_add_point(vbuffer,i,j,zv,,,,,,col);		
	}
}
vertex_end(vbuffer);