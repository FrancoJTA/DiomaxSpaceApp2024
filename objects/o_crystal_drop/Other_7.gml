xcrys = x - 80
ycrys = o_player.y + 32;
for(i = 0; i < 5; i++)
{
	instance_create_layer(xcrys,ycrys,"instances",o_crystal_block);
	xcrys += 32;
}


instance_destroy();