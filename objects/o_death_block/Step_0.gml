if (collision_rectangle(x, y, x + 20, y - 1, o_player, 0, 1)) {
    touch = 1;
}

if (touch) {
    player = instance_nearest(x,y,o_player);
	
	if(player != noone){
		player.x = player.resx;
		player.y = player.resy;
		touch = 0;
	}
}



