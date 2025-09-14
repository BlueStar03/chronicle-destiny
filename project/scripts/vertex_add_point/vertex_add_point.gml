/// @function import_obj(filename, vertex_format, scale=1, up="y", front="-z", right="x")
/// @desc Loads an OBJ and maps OBJ axes into engine (Right=X, Up=Y, Front=Z) using the provided axis strings.
///       Axis strings can be "x","-x","y","-y","z","-z".
///       Positions are scaled by `scale`; normals are remapped but NOT scaled.
///       UV V is flipped (1 - v) by default; change if your pipeline differs.
function import_obj(filename, vertex_format, scale=32, up="x", front="-y", right="z")
{
    // --- helpers ---------------------------------------------------
    var __axis_idx_sign = function(ax) {
        ax = string_lower(ax);
        switch (ax) {
            case "x":  return [0,  1];
            case "-x": return [0, -1];
            case "y":  return [1,  1];
            case "-y": return [1, -1];
            case "z":  return [2,  1];
            case "-z": return [2, -1];
            default:
                show_debug_message("import_obj_ext: invalid axis '" + ax + "', defaulting to 'x'.");
                return [0, 1];
        }
    };

    var __pick = function(x, y, z, idx) {
        return (idx == 0) ? x : ((idx == 1) ? y : z);
    };

    // Parse mapping (OBJ -> Engine axes)
    var R = __axis_idx_sign(right); var r_idx = R[0]; var r_sgn = R[1];
    var U = __axis_idx_sign(up);    var u_idx = U[0]; var u_sgn = U[1];
    var F = __axis_idx_sign(front); var f_idx = F[0]; var f_sgn = F[1];

    // Optional sanity check (duplicate source axes mean a non-orthonormal mapping)
    if ((r_idx == u_idx) || (r_idx == f_idx) || (u_idx == f_idx)) {
        show_debug_message("import_obj_ext: WARNING — right/up/front map to duplicate source axes.");
    }

    // --- read file into a string -----------------------------------
    var buffer = buffer_load(filename);
    if (buffer == -1) {
        show_debug_message("import_obj_ext: could not load '" + filename + "'");
        return -1;
    }
    var content_string = buffer_read(buffer, buffer_text);
    buffer_delete(buffer);

    // --- attribute storage (growable float buffers) ----------------
    static px = buffer_create(10000, buffer_grow, 4);
    static py = buffer_create(10000, buffer_grow, 4);
    static pz = buffer_create(10000, buffer_grow, 4);
    static nx = buffer_create(10000, buffer_grow, 4);
    static ny = buffer_create(10000, buffer_grow, 4);
    static nz = buffer_create(10000, buffer_grow, 4);
    static tx = buffer_create(10000, buffer_grow, 4);
    static ty = buffer_create(10000, buffer_grow, 4);

    // index 1 → byte offset 4, etc. (match the original trick)
    buffer_seek(px, buffer_seek_start, 4);
    buffer_seek(py, buffer_seek_start, 4);
    buffer_seek(pz, buffer_seek_start, 4);
    buffer_seek(nx, buffer_seek_start, 4);
    buffer_seek(ny, buffer_seek_start, 4);
    buffer_seek(nz, buffer_seek_start, 4);
    buffer_seek(tx, buffer_seek_start, 4);
    buffer_seek(ty, buffer_seek_start, 4);

    // --- parse lines -----------------------------------------------
    var lines = string_split(content_string, "\n");

    var vb = vertex_create_buffer();
    vertex_begin(vb, vertex_format);

    var i = 0, nlines = array_length(lines);
    repeat (nlines) {
        var this_line = lines[i++];
        if (this_line == "") continue;
        if (string_char_at(this_line, 1) == "#") continue;

        var tokens = string_split(this_line, " ");
        if (array_length(tokens) == 0) continue;

        var head = string_lower(tokens[0]);

        switch (head) {
            case "v":
                // store OBJ position in natural order
                buffer_write(px, buffer_f32, real(tokens[1]));
                buffer_write(py, buffer_f32, real(tokens[2]));
                buffer_write(pz, buffer_f32, real(tokens[3]));
                break;

            case "vt":
                buffer_write(tx, buffer_f32, real(tokens[1]));
                buffer_write(ty, buffer_f32, 1 - real(tokens[2])); // flip V (change to `real(tokens[2])` if not needed)
                break;

            case "vn":
                // store OBJ normal in natural order
                buffer_write(nx, buffer_f32, real(tokens[1]));
                buffer_write(ny, buffer_f32, real(tokens[2]));
                buffer_write(nz, buffer_f32, real(tokens[3]));
                break;

            case "f":
                var n = array_length(tokens);
                // split each "i/j/k" field
                for (var j = 1; j < n; j++) {
                    tokens[j] = string_split(tokens[j], "/");
                }

                // triangulate fan: (1, j-1, j)
                for (var j = 2; j < n; j++) {
                    var v1 = tokens[1];
                    var v2 = tokens[j - 1];
                    var v3 = tokens[j];

                    // ---- positions (OBJ -> engine mapped + scaled) ----
                    var pi1 = 4 * real(v1[0]);
                    var pi2 = 4 * real(v2[0]);
                    var pi3 = 4 * real(v3[0]);

                    var sv1x = buffer_peek(px, pi1, buffer_f32);
                    var sv1y = buffer_peek(py, pi1, buffer_f32);
                    var sv1z = buffer_peek(pz, pi1, buffer_f32);

                    var sv2x = buffer_peek(px, pi2, buffer_f32);
                    var sv2y = buffer_peek(py, pi2, buffer_f32);
                    var sv2z = buffer_peek(pz, pi2, buffer_f32);

                    var sv3x = buffer_peek(px, pi3, buffer_f32);
                    var sv3y = buffer_peek(py, pi3, buffer_f32);
                    var sv3z = buffer_peek(pz, pi3, buffer_f32);

                    var p1x =  r_sgn * __pick(sv1x, sv1y, sv1z, r_idx) * scale;
                    var p1y =  u_sgn * __pick(sv1x, sv1y, sv1z, u_idx) * scale;
                    var p1z =  f_sgn * __pick(sv1x, sv1y, sv1z, f_idx) * scale;

                    var p2x =  r_sgn * __pick(sv2x, sv2y, sv2z, r_idx) * scale;
                    var p2y =  u_sgn * __pick(sv2x, sv2y, sv2z, u_idx) * scale;
                    var p2z =  f_sgn * __pick(sv2x, sv2y, sv2z, f_idx) * scale;

                    var p3x =  r_sgn * __pick(sv3x, sv3y, sv3z, r_idx) * scale;
                    var p3y =  u_sgn * __pick(sv3x, sv3y, sv3z, u_idx) * scale;
                    var p3z =  f_sgn * __pick(sv3x, sv3y, sv3z, f_idx) * scale;

                    // ---- defaults ----
                    var t1x = 0, t1y = 0, t2x = 0, t2y = 0, t3x = 0, t3y = 0;
                    var n1x = 0, n1y = 0, n1z = 0;
                    var n2x = 0, n2y = 0, n2z = 0;
                    var n3x = 0, n3y = 0, n3z = 0;

                    // ---- texcoords / normals (if present) --------------
                    switch (array_length(v1)) {
                        case 2:
                            var ti = 4 * real(v1[1]);
                            t1x = buffer_peek(tx, ti, buffer_f32);
                            t1y = buffer_peek(ty, ti, buffer_f32);
                            break;
                        case 3:
                            if (v1[1] != "") {
                                ti  = 4 * real(v1[1]);
                                t1x = buffer_peek(tx, ti, buffer_f32);
                                t1y = buffer_peek(ty, ti, buffer_f32);
                            }
                            var ni = 4 * real(v1[2]);
                            var snx = buffer_peek(nx, ni, buffer_f32);
                            var sny = buffer_peek(ny, ni, buffer_f32);
                            var snz = buffer_peek(nz, ni, buffer_f32);
                            n1x = r_sgn * __pick(snx, sny, snz, r_idx);
                            n1y = u_sgn * __pick(snx, sny, snz, u_idx);
                            n1z = f_sgn * __pick(snx, sny, snz, f_idx);
                            break;
                    }
                    switch (array_length(v2)) {
                        case 2:
                            var ti = 4 * real(v2[1]);
                            t2x = buffer_peek(tx, ti, buffer_f32);
                            t2y = buffer_peek(ty, ti, buffer_f32);
                            break;
                        case 3:
                            if (v2[1] != "") {
                                ti  = 4 * real(v2[1]);
                                t2x = buffer_peek(tx, ti, buffer_f32);
                                t2y = buffer_peek(ty, ti, buffer_f32);
                            }
                            var ni = 4 * real(v2[2]);
                            var snx = buffer_peek(nx, ni, buffer_f32);
                            var sny = buffer_peek(ny, ni, buffer_f32);
                            var snz = buffer_peek(nz, ni, buffer_f32);
                            n2x = r_sgn * __pick(snx, sny, snz, r_idx);
                            n2y = u_sgn * __pick(snx, sny, snz, u_idx);
                            n2z = f_sgn * __pick(snx, sny, snz, f_idx);
                            break;
                    }
                    switch (array_length(v3)) {
                        case 2:
                            var ti = 4 * real(v3[1]);
                            t3x = buffer_peek(tx, ti, buffer_f32);
                            t3y = buffer_peek(ty, ti, buffer_f32);
                            break;
                        case 3:
                            if (v3[1] != "") {
                                ti  = 4 * real(v3[1]);
                                t3x = buffer_peek(tx, ti, buffer_f32);
                                t3y = buffer_peek(ty, ti, buffer_f32);
                            }
                            var ni = 4 * real(v3[2]);
                            var snx = buffer_peek(nx, ni, buffer_f32);
                            var sny = buffer_peek(ny, ni, buffer_f32);
                            var snz = buffer_peek(nz, ni, buffer_f32);
                            n3x = r_sgn * __pick(snx, sny, snz, r_idx);
                            n3y = u_sgn * __pick(snx, sny, snz, u_idx);
                            n3z = f_sgn * __pick(snx, sny, snz, f_idx);
                            break;
                    }

                    // ---- emit triangle --------------------------------
                    vertex_position_3d(vb, p1x, p1y, p1z);
                    vertex_normal(vb, n1x, n1y, n1z);
                    vertex_texcoord(vb, t1x, t1y);
                    vertex_color(vb, c_white, 1);

                    vertex_position_3d(vb, p2x, p2y, p2z);
                    vertex_normal(vb, n2x, n2y, n2z);
                    vertex_texcoord(vb, t2x, t2y);
                    vertex_color(vb, c_white, 1);

                    vertex_position_3d(vb, p3x, p3y, p3z);
                    vertex_normal(vb, n3x, n3y, n3z);
                    vertex_texcoord(vb, t3x, t3y);
                    vertex_color(vb, c_white, 1);
                }
                break;
        }
    }

    vertex_end(vb);
    vertex_freeze(vb);
    return vb;
}
