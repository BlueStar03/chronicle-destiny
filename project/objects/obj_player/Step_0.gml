var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Normalize diagonal movement so it is not faster
if (h != 0 || v != 0)
{
    var len = point_distance(0, 0, h, v);
    h /= len;
    v /= len;
}

var xmove = h * move_speed;
var ymove = v * move_speed;

// Horizontal collision
if (!place_meeting(x + xmove, y, obj_wall))
{
    x += xmove;
}
else
{
    while (!place_meeting(x + sign(xmove), y, obj_wall))
    {
        x += sign(xmove);
    }
}

// Vertical collision
if (!place_meeting(x, y + ymove, obj_wall))
{
    y += ymove;
}
else
{
    while (!place_meeting(x, y + sign(ymove), obj_wall))
    {
        y += sign(ymove);
    }
}