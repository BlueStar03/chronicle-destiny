shader_set(Shader1)

var s=22
new BBMOD_Matrix()
	.RotateZ(-0)
	.RotateX(0)
	.Scale(s/2, s, -s)
	.Translate(x, y, 0)
	.ApplyWorld();
// Same as:
//matrix_set(matrix_world, matrix_multiply(
//	matrix_build(0, 0, 0, 0, 0, -45, 100, 100, 100),
//	matrix_build(x, y, 0, 45, 0, 0, 1, 1, 1)));
model.submit();
new BBMOD_Matrix().ApplyWorld();
shader_reset();