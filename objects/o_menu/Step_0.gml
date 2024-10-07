if(keyboard_check_pressed(vk_down))
{
	if(selection < 3)
	{
		selection++;
		image_index = selection;
	}
} 
else if (keyboard_check_pressed(vk_up))
{
	if(selection > 1)
	{
		selection--;
		image_index = selection;
	}
}
if(keyboard_check_pressed(vk_enter))
{
	switch(selection)
	{
		case 1: room_goto(r_crystal)
		break;
		case 2: room_goto(r_night);
		break;
		case 3: room_goto(r_marshmallow);
		break;
	}
}