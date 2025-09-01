/// @func draw_ring_menu(center_x, center_y, radius, values, start_deg, sweep_deg, inclusive_endpoints, rotate_outward, selection)
/// @desc Draw array items along an arc starting at start_deg and spanning sweep_deg degrees.
///       Positive sweep is counterclockwise. Negative sweep is clockwise.
///       The item at index == selection is highlighted.
/// @param center_x
/// @param center_y
/// @param radius
/// @param values                Array of items to draw
/// @param start_deg             Degrees. 0 = right, 90 = up
/// @param sweep_deg             Degrees to cover. Example: 45 or -45
/// @param inclusive_endpoints   [optional] default true
/// @param rotate_outward        [optional] default false
/// @param selection             [optional] default -1  index to highlight, -1 for none
function draw_ring_menu(center_x, center_y, radius, values, start_deg, sweep_deg, inclusive_endpoints, rotate_outward, selection)
{
    var _count = array_length(values);
    if (_count <= 0) return;

    // Optional args with safe defaults
    var _inclusive = (argument_count >= 7) ? inclusive_endpoints : true;
    var _rotate    = (argument_count >= 8) ? rotate_outward      : false;
    var _sel       = (argument_count >= 9) ? selection           : -1;

    // Save and center alignment
    var _old_h = draw_get_halign();
    var _old_v = draw_get_valign();
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    if (_inclusive) {
        var _steps = max(1, _count - 1); // hits both ends
        for (var i = 0; i < _count; i++) {
            var _t   = i / _steps;
            var _ang = start_deg + _t * sweep_deg; // degrees
            var _x   = center_x + lengthdir_x(radius, _ang);
            var _y   = center_y + lengthdir_y(radius, _ang);

            if (i == _sel) {
                if (_rotate) {
                    draw_text_transformed_colour(_x, _y, string(values[i]), 1, 1, _ang + 90, c_lime, c_lime, c_green, c_green, 1);
                } else {
                    draw_text_colour(_x, _y, string(values[i]), c_lime, c_lime, c_green, c_green, 1);
                }
            } else {
                if (_rotate) {
                    draw_text_transformed(_x, _y, string(values[i]), 1, 1, _ang + 90);
                } else {
                    draw_text(_x, _y, string(values[i]));
                }
            }
        }
    } else {
        // fills arc without duplicating the end
        for (var i = 0; i < _count; i++) {
            var _t   = i / _count;        // 0..(1 - 1/count)
            var _ang = start_deg + _t * sweep_deg;
            var _x   = center_x + lengthdir_x(radius, _ang);
            var _y   = center_y + lengthdir_y(radius, _ang);

            if (i == _sel) {
                if (_rotate) {
                    draw_text_transformed_colour(_x, _y, string(values[i]), 1, 1, _ang + 90, c_lime, c_lime, c_green, c_green, 1);
                } else {
                    draw_text_colour(_x, _y, string(values[i]), c_lime, c_lime, c_green, c_green, 1);
                }
            } else {
                if (_rotate) {
                    draw_text_transformed(_x, _y, string(values[i]), 1, 1, _ang + 90);
                } else {
                    draw_text(_x, _y, string(values[i]));
                }
            }
        }
    }

    // Restore alignment
    draw_set_halign(_old_h);
    draw_set_valign(_old_v);
}
