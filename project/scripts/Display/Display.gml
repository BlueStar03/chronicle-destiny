function Display() constructor {
    width  = window_get_width();
    height = window_get_height();

    // Optional: method to refresh values if the window resizes
    refresh = function() {
        width  = window_get_width();
        height = window_get_height();
    }
}
