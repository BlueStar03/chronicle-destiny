function model_block(x1,y1,z1,x2,y2,z2,hrepeat=1,vrepeat=1,zrepeat=1) {
	var vb = vertex_create_buffer();

	vertex_begin(vb, vformat);

	//bottom
	vertex_add_point(vb,	x1,y1,z1,	0,0,-1,	0,0);
	vertex_add_point(vb,	x1,y2,z1,	0,0,-1,	0,vrepeat);
	vertex_add_point(vb,	x2,y2,z1,	0,0,-1,	hrepeat,vrepeat);
												
	vertex_add_point(vb,	x2,y2,z1,	0,0,-1,	hrepeat,vrepeat);
	vertex_add_point(vb,	x2,y1,z1,	0,0,-1,	hrepeat,0);
	vertex_add_point(vb,	x1,y1,z1,	0,0,-1,	0,0);
	//top								
	vertex_add_point(vb,	x1,y1,z2,	0,0,1,	0,0);
	vertex_add_point(vb,	x2,y1,z2,	0,0,1,	hrepeat,0);
	vertex_add_point(vb,	x2,y2,z2,	0,0,1,	hrepeat,vrepeat);
										
	vertex_add_point(vb,	x2,y2,z2,	0,0,1,	hrepeat,vrepeat);
	vertex_add_point(vb,	x1,y2,z2,	0,0,1,	0,vrepeat);
	vertex_add_point(vb,	x1,y1,z2,	0,0,1,	0,0);
	//front								
	vertex_add_point(vb,	x1,y2,z1,	0,1,0,	0,0);
	vertex_add_point(vb,	x1,y2,z2,	0,1,0,	0,zrepeat);
	vertex_add_point(vb,	x2,y2,z2,	0,1,0,	hrepeat,zrepeat);
												
	vertex_add_point(vb,	x2,y2,z2,	0,1,0,	hrepeat,zrepeat);
	vertex_add_point(vb,	x2,y2,z1,	0,1,0,	hrepeat,0);
	vertex_add_point(vb,	x1,y2,z1,	0,1,0,	0,0);
	//right										
	vertex_add_point(vb,	x2,y2,z1,	1,0,0,	0,0);
	vertex_add_point(vb,	x2,y2,z2,	1,0,0,	0,zrepeat);
	vertex_add_point(vb,	x2,y1,z2,	1,0,0,	vrepeat,zrepeat);
												
	vertex_add_point(vb,	x2,y1,z2,	1,0,0,	vrepeat,zrepeat);
	vertex_add_point(vb,	x2,y1,z1,	1,0,0,	vrepeat,0);
	vertex_add_point(vb,	x2,y2,z1,	1,0,0,	0,0);
	//back								
	vertex_add_point(vb,	x2,y1,z1,	0,-1,0,	0,0);
	vertex_add_point(vb,	x2,y1,z2,	0,-1,0,	0,zrepeat);
	vertex_add_point(vb,	x1,y1,z2,	0,-1,0,	hrepeat,zrepeat);
												
	vertex_add_point(vb,	x1,y1,z2,	0,-1,0,	hrepeat,zrepeat);
	vertex_add_point(vb,	x1,y1,z1,	0,-1,0,	hrepeat,0);
	vertex_add_point(vb,	x2,y1,z1,	0,-1,0,	0,0);
	//											
	vertex_add_point(vb,	x1,y1,z1,	-1,0,0,	0,0);
	vertex_add_point(vb,	x1,y1,z2,	-1,0,0,	0,zrepeat);
	vertex_add_point(vb,	x1,y2,z2,	-1,0,0,	vrepeat,zrepeat);
												
	vertex_add_point(vb,	x1,y2,z2,	-1,0,0,	vrepeat,zrepeat);
	vertex_add_point(vb,	x1,y2,z1,	-1,0,0,	vrepeat,0);
	vertex_add_point(vb,	x1,y1,z1,	-1,0,0,	0,0);

	vertex_end(vb);
	return vb;
}


function draw_3d_model(model,texture,xx,yy,zz,rx=0,ry=0,rz=0,sx=1,sy=1,sz=1){
	var matrix=matrix_build(xx,yy,zz,rx,ry,rz,sx,sy,sz);
	matrix_set(matrix_world,matrix)
	vertex_submit(model, pr_trianglelist, texture);
	matrix_set(matrix_world,matrix_build_identity())
}