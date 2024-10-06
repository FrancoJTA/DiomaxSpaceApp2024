if (collision_rectangle(x - 12, y, x + 12, y - y_collision, o_player, 0, 1)) {
    touch = 1;
}

if (touch && collision_timer == -1) {
    collision_timer = stay_time; 
    y_point = y; 
}


if (collision_timer > 0) {
    collision_timer -= 1;
}


if (collision_timer == 0 && !up) {
    move_contact_solid(270, 4);
}

if (!place_free(x, y + block_y)) {
    up = 1; 
}


if (up) {
    y--; 
	
    if (y <= y_point) {
        up = 0; 
        touch = 0; 
        collision_timer = -1;
    }
}
