vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord()
vertex_format_add_color();
__vformat=vertex_format_end();

#macro vformat global.__vformat



/// @function                vertex_add_point(vbuffer, xx, yy, zz, nx, ny, nz, uu, vv, col, alpha)
/// @description             Add a vertex to the given vertex buffer with position, normal, texture coordinates, and color.
/// @param {Id.VertexBuffer}            vbuffer    The vertex buffer to add to.
/// @param {Real}            xx         The X position of the vertex.
/// @param {Real}            yy         The Y position of the vertex.
/// @param {Real}            zz         The Z position of the vertex.
/// @param {Real}            nx         The X component of the normal vector.
/// @param {Real}            ny         The Y component of the normal vector.
/// @param {Real}            nz         The Z component of the normal vector.
/// @param {Real}            uu         The U texture coordinate.
/// @param {Real}            vv         The V texture coordinate.
/// @param {Real}            col        The vertex color value.
/// @param {Real}            alpha      The vertex alpha value.
function vertex_add_point(vbuffer, xx, yy, zz, nx=0, ny=0, nz=1, uu=0, vv=0, col=c_white, alpha=1) {
    vertex_position_3d(vbuffer, xx, yy, zz);
    vertex_normal(vbuffer, nx, ny, nz);
    vertex_texcoord(vbuffer, uu, vv);
    vertex_color(vbuffer, col, alpha);
}



/// @function draw_model(vbuffer, texture, x, y, z, [rx=0], [ry=0], [rz=0], [sx=1], [sy=1], [sz=1])
/// @desc Draw a vertex buffer with transform; scale is internally multiplied by (-8, 8, 8).
function draw_model(vbuffer, texture, x, y, z, rx = 0, ry = 0, rz = 0, sx = 1, sy = 1, sz = 1) {
    // Internal scale rule: (-8, 8, 8) * (sx, sy, sz)
    var _sx = -8 * sx;
    var _sy =  8 * sy;
    var _sz =  8 * sz;

    // Build and apply world matrix
    var _m = matrix_build(x, y, z, rx, ry, rz, _sx, _sy, _sz);
    matrix_set(matrix_world, _m);

    // Draw
    vertex_submit(vbuffer, pr_trianglelist, texture);

    // Restore
    matrix_set(matrix_world, matrix_build_identity());
}


/// angle_delta(a, b) → shortest signed delta (degrees) to go from a → b
function angle_delta(a, b) {
    // maps to (-180, 180]
    return ((b - a + 540) mod 360) - 180;
}

/// angle_lerp(a, b, amt) → move a toward b by fraction amt (0..1)
function angle_lerp(a, b, amt) {
    amt = clamp(amt, 0, 1);
    return a + angle_delta(a, b) * amt;
}
