// ------- INPUT ------

if (keyboard_check(ord("D")))
{      
	if(x_speed < 0) x_speed = 0;
	
	if (crouch == 1) {
		if (x_speed > x_speed_max * 0.3) x_speed = x_speed_max * 0.3;
        if (x_speed <= x_speed_max * 0.3) x_speed += x_accel * 0.3;
    } 
	else 
	{
        if (x_speed <= x_speed_max) x_speed += x_accel;
    }
	right=1;
	
	sinking = 0; 
    idle_time = 0; 
    alarm[1] = sinking_timer;

    if (expulsion && combo) {
        if (collision_rectangle(x - 12, y - 4, x + 12, y - 2, o_terrain, 0, 1)) {
            y -= 1;
            combo = 0;
        } else {
            y -= 2;
            expulsion = 0;
        }
    }
}

if (keyboard_check(ord("A")))
{      
	if(x_speed > 0)	x_speed = 0;
	
	if (crouch == 1) {
		if (x_speed < -x_speed_max * 0.3) x_speed = -x_speed_max * 0.3;
        if (x_speed >= -x_speed_max * 0.3) x_speed -= x_accel * 0.3;
    } 
	else 
	{
        if (x_speed >= -x_speed_max) x_speed -= x_accel;
    }
	right=0;
	
	sinking = 0; 
    idle_time = 0; 
    alarm[1] = sinking_timer;

    if (expulsion && !combo) {
        if (collision_rectangle(x - 12, y - 4, x + 12, y - 2, o_terrain, 0, 1)) {
            y -= 1;
            combo = 1;
        } else {
            y -= 2;
            expulsion = 0;
        }
    }
}

if (!keyboard_check(ord("A")) and !keyboard_check(ord("D"))){
	x_speed=0;	
	if (ground && !sinking) { 
            if (alarm[1] == -1) { 
                alarm[1] = sinking_timer; 
            }
        }
} 
if (keyboard_check(ord("A")) and keyboard_check(ord("D"))) x_speed=0; //Podria ponerse el hundimiento igual?


// --------------- MARSHMALLOW -----------
if (alarm[1] == 0 && ground && !sinking && marsh_world ) {
    sinking = 1;
}

if (sinking && marsh_world) {
	expulsion = 1;
    y += sinking_speed * 0.5;
}
// -------------- CROUCH -----------------

if(keyboard_check(ord("S")))
{
	if(ground)
	{
		crouch = 1;
		weapon_mody = -14;
		
		sinking = 0; 
        alarm[1] = sinking_timer;
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
	if(ground or coyote_c or wall_stick)
	{
		ground = 0;
		coyote_c = 0;
		if (wall_stick) {
            if (right_wall) {
                while (collision_rectangle(x + 16, y - 20, x + 17, y - 21, o_walljump_block, 0, 1)) {
                    x--;
                }
            } else {
                while (collision_rectangle(x - 17, y - 20, x - 16, y - 21, o_walljump_block, 0, 1)) {
                    x++;
                }
            }
            wall_stick = 0;
        }
		
		if(crouch and place_free(x,y+1)) y+=1;
		else y_speed = -jump_power;
		
		sinking = false;
        alarm[1] = sinking_timer;
	}
}
if (keyboard_check_released(vk_space))
{
	if(y_speed < 0) y_speed = 0;	
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

if(collision_rectangle(x + 12,y-3,x + 18,y-30,o_solid,0,1) and right){
    if(keyboard_check(vk_shift)){
        if (keyboard_check(vk_up)) {
            y_speed = -2; 
        } else if (keyboard_check(vk_down)) {
            y_speed = 2; 
        } else {
            y_speed = 0; 
        }
    }
}

if(collision_rectangle(x - 12,y-3,x - 18,y-30,o_solid,0,1) and !right){
    if(keyboard_check(vk_shift)){
        if (keyboard_check(ord("W"))) {
            y_speed = -2; 
        } else if (keyboard_check(ord("S"))) {
            y_speed = 2; 
        } else {
            y_speed = 0; 
        }
    }
}

if (collision_rectangle(x + 16, y - 20, x + 17, y - 21, o_walljump_block, 0, 1)) {
    if (!ground) {
        x_speed = 0;
        y_speed = 0;
        wall_stick = 1;
        right_wall = 1; 
    }
}


if (collision_rectangle(x - 17, y - 20, x - 16, y - 21, o_walljump_block, 0, 1)) {
    if (!ground) {
        x_speed = 0;
        y_speed = 0;
        wall_stick = 1;
        right_wall = 0;
    }
}