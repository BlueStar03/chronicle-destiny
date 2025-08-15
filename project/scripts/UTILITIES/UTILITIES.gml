/// @function                draw_text_outline(x, y, str, [c_str=c_white], [c_out=c_black], [out=1], [q=45])
/// @description             Draws text with an outlined effect.
/// @param {Real}            x          The x-coordinate for the text.
/// @param {Real}            y          The y-coordinate for the text.
/// @param {String}          str        The string to be drawn.
/// @param {Color}           [c_str]    The color of the main text (default is c_white).
/// @param {Color}           [c_out]    The color of the outline (default is c_black).
/// @param {Real}            [out]      The distance of the outline from the text (default is 1).
/// @param {Real}            [q]        The angle increment for drawing the outline (default is 45).
function draw_text_outline(x, y, str, c_str=c_white, c_out=c_black, out=1, q=45) {
    // Save the current drawing color
    var c_temp = draw_get_color();

    // Set the color for the outline
    draw_set_color(c_out);

    // Draw the outline
    for (var i = 0; i < 360; i += q) {
        var ox = lengthdir_x(out, i);
        var oy = lengthdir_y(out, i);
        draw_text(x + ox, y + oy, str);
    }

    // Set the color for the main text
    draw_set_color(c_str);
    draw_text(x, y, str);

    // Restore the original drawing color
    draw_set_color(c_temp);
}



/// @function                rollover(val, lo, hi)
/// @description             Ensures the value wraps around within the range [lo, hi).
/// @param {Real}            val        The value to wrap.
/// @param {Real}            lo         The lower bound of the range.
/// @param {Real}            hi         The upper bound of the range.
/// @return {Real}                        The wrapped value within the range [lo, hi).
function rollover(val, lo, hi) {
    var range = hi - lo;
    var offset = (val - lo) % range;
    if (offset < 0) {
        offset += range;
    }
    return lo + offset;
}

/// @function                rollover_angle(angle, [degrees=true])
/// @description             Wraps an angle to stay within [0,360) if degrees, or [0,2π) if radians.
/// @param {Real}            angle      The input angle.
/// @param {Bool}            [degrees]  Whether the angle is in degrees (default true).
/// @return {Real}                       The wrapped angle.
function rollover_angle(angle, degrees = true) {
    if (degrees) {
        return rollover(angle, 0, 360);
    } else {
        return rollover(angle, 0, pi * 2);
    }
}
