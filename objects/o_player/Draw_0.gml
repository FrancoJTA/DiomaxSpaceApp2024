// SPRITE CHECKS ---------------
if(ground){
	if(x_speed==0){
		sprite_index=s_idle;
	}
	else sprite_index=s_walk;
}
else{
	if(y_speed>=0) sprite_index=s_fall;
	else sprite_index=s_jump;
}

if(right) image_xscale=1;
else image_xscale=-1;

mask_index=s_player_mask; 




draw_self();