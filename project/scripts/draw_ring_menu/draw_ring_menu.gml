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

/// @function        draw_dialogbox(who, name, mugshot, text, known, side, mode, D)
/// @description     Draw a dialog box with a mugshot, speaker name, and text. Positions depend on who and side.
/// @param {String}              who       Speaker identity. Use "npc" or "player".
/// @param {String}              name      Display name for the speaker.
/// @param {Asset.GMSprite}      mugshot   Sprite asset used as the speaker mugshot.
/// @param {String}              text      Dialog text to render inside the box.
/// @param {Bool}                known     Whether the speaker is known. Reserved for styling logic.
/// @param {String}              side      "right" or "left" to control mugshot flipping and layout bias.
/// @param {Bool}                mode      If true, use compact layout rules off by default.
/// @param {Any}                 D         Optional extra data or context. Unused by default.
/// @return {Any}                           No return value. Draws to the current target.
function draw_dialogbox(
    who = "npc",
    name = "alan",
    mugshot = spr_mugshot,
    text = "lorem",
    known = false,
    side = "right",
    mode = false,
    D = noone
) {
    draw_set_font(fnt_dialog);

    var pad = 5;

    var mw = sprite_get_width(mugshot);
    var mh = sprite_get_height(mugshot);

    var mx = 0;
    var my = 0;
    var bx = mw;
    var by = my;
    var bw = 256;
    var bh = mh;
    var tx = bx;
    var ty = my;
    var nx = mx;
    var ny = my;
    var ns = 5;
    var npad = 3;
    var flip = 1;

    if (who == "player") {
        mx = SCREEN.bottomright.x - mw;
        my = SCREEN.bottomright.y - mh;
        bw = SCREEN.quarter.width * 3;
        bx = mx - bw;
        by = my;
        tx = bx;
        ty = by;
        nx = mx;
        ny = my + ((mh / ns) * (ns - 1));
    } else {
        mx = SCREEN.bottomleft.x;
        my = SCREEN.bottomleft.y - mh;
        bw = SCREEN.quarter.width * 3;
        by = my;
        ty = by;
        nx = mx;
        ny = my + ((mh / ns) * (ns - 1));
    }

    if (!mode) {
        bw = SCREEN.width - mw;
        if (who == "player") {
            my = 0;
            by = 0;
            tx = 0;
            ty = 0;
            bx = mx - bw;
            nx = mx;
            ny = my + ((mh / ns) * (ns - 1));
        }
    }

    if (side == "right") {
        if (who == "player") {
            flip = -1;
            mx = mx + mw;
        }
    } else {
        if (who != "player") {
            flip = -1;
            mx = mx + mw;
        }
    }

    draw_sprite_stretched(spr_text_border, 0, bx, by, bw, bh);

    draw_sprite_ext(mugshot, 0, mx, my, flip, 1, 0, c_white, 1);
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(tx + pad, ty + pad, text);

    if (known) {
        // reserved for conditional styling
    }

    draw_sprite_stretched(spr_text_border, 0, nx, ny, mw, mh / ns);
    draw_set_color(c_black);
    draw_text(nx + npad, ny, name);
}
