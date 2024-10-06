// ------- INPUT ------

if (keyboard_check(ord("D")))
{      
	if(x_speed < 0) x_speed = 0;
	if(x_speed < x_speed_max) x_speed += x_accel;
	right=1;
}

if (keyboard_check(ord("A")))
{
	if(!portal_jump){
	if(x_speed > 0)	x_speed = 0;
	if(x_speed > -x_speed_max) x_speed -= x_accel;
	right=0;
	}
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

// ------------ Slow ---------------

if(planet_fast){
	x_accel=0.8;
	
	if(x_speed>-9) x_speed -= fast_acc;;
}

if(planet_slow){
	
}
// ------------ Portal Jump
if(portal_jump){
	
	if(x_speed>-7) x_speed-=3;
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
	portal_jump=0;
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