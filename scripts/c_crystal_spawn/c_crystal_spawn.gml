// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function c_crystal_spawn(){
	xc = o_player.x - 480;
	for(i = 0; i < 30; i++)
	{
		yc = o_player.y - 480;
		yc += irandom_range(0,64)
		instance_create_layer(xc,yc,"att",o_crystal_rain)
		xc += 32;
	}
}