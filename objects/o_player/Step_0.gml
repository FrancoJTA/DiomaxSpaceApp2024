// ME ENCANTA EL FORNITE LO JUEGO TODO EL DIA ESTO NO ES MINECRAFT ME ENCANTA QUE BUENO

if(y > room_height + 64)
{
	x = 100;
	y = 200;
}

// ------- INPUT ------

if (keyboard_check(ord("D")))
{      
	if(x_speed < 0) x_speed = 0;
	if(x_speed < x_speed_max) x_speed += x_accel;
	right=1;
}

if (keyboard_check(ord("A")))
{      
	if(x_speed > 0)	x_speed = 0;
	if(x_speed > -x_speed_max) x_speed -= x_accel;
	right=0;
}

if (!keyboard_check(ord("A")) and !keyboard_check(ord("D"))) x_speed=0;
if (keyboard_check(ord("A")) and keyboard_check(ord("D"))) x_speed=0;
// -------------- CROUCH -----------------

if(keyboard_check(vk_down))
{
	if(ground)
	{
		crouch = 1;
		x_speed = 0;
		weapon_mody = -14;
	} 
}
else
{
	crouch = 0;
	weapon_mody = -25;
}

// ----------- JUMP --------------
if (keyboard_check_pressed(vk_space))
{
	if(ground or coyote_c)
	{
		ground = 0;
		coyote_c = 0;
		if(crouch and place_free(x,y+1)) y+=1;
		
		else y_speed = -jump_power;
	}
}
if (keyboard_check_released(vk_space))
{
	if(y_speed < 0) y_speed = 0;	
}

//-- Crear plataformas --//

if(keyboard_check_pressed(vk_shift) and crystalPow and !ground)
{
	drop = instance_create_layer(x,y,"instances",o_crystal_drop);
	if (image_xscale == 1) drop.image_xscale = 1; else drop.image_xscale = -1;
}

// ------- MOVIMIENTO -------
if(x_speed != 0)
{
	if(x_speed > 0) move_contact_solid(0,x_speed);
	else if (x_speed < 0) move_contact_solid(180,abs(x_speed));
}

if(y_speed != 0)
{
	if(y_speed > 0) move_contact_solid(270,y_speed);	
	else if (y_speed < 0) move_contact_solid(90,abs(y_speed));
}

// ---------- CHECKS ---------

if (!place_free(x,y+1)){
	ground=1;
	y_speed=0;
	coyote_c=1;
}
else{
	crouch=0;
	ground=0;
	y_speed+=grav;
	if(coyote_c and alarm[11]==-1) alarm[11]=coyote_t;
	if(y_speed > fall_max) y_speed = fall_max;
	if(!place_free(x,y-1)){
		if(y_speed<0) y_speed=0;
	}
}