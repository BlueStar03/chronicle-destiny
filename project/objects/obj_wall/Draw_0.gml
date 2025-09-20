var _s=8

var xs=-image_xscale;
var ys=image_yscale;
var zs=1;
//matrix_set(matrix_world, matrix_build(x,y,z,0,0,0,-_s*xs,_s*ys,_s));
//
//vertex_submit(model,pr_trianglelist,texture)
//
//matrix_set(matrix_world,matrix_build_identity());


draw_model(model,texture,x,y,z,0,0,0,_s*xs,_s*ys,_s*zs);