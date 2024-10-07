// ME ENCANTA EL FORNITE LO JUEGO TODO EL DIA ESTO NO ES MINECRAFT ME ENCANTA QUE BUENO

if(y > room_height + 64)
{
	x = resx;
	y = resy;
}

// ------- INPUT ------

if (keyboard_check(ord("D")))
{      
	if(x_speed < 0) x_speed = 0;
    if (x_speed <= x_speed_max) x_speed += x_accel;
    
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
{//aca
	if(!portal_jump){
	if(x_speed > 0)	x_speed = 0;
    if (x_speed >= -x_speed_max) x_speed -= x_accel;
	right=0;
	}
	
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
if (keyboard_check(ord("A")) and keyboard_check(ord("D"))){
	x_speed=0; 
	if (ground && !sinking) { 
        if (alarm[1] == -1) { 
			alarm[1] = sinking_timer; 
        }
    }
} 
// --------- Emotiza
if(keyboard_check(ord("B"))){
	if(ground){
		Emotiza=1;
		x_speed=0;
		y_speed=0;
	}
}
if(keyboard_check_released(ord("B"))){
	Emotiza=0;
}

// --------------- MARSHMALLOW -----------
if (alarm[1] == 0 && ground && !sinking && marsh_world ) {
    sinking = 1;
}

if (sinking && marsh_world) {
	expulsion = 1;
    y += sinking_speed * 0.5;
}



// ----------- JUMP --------------
if (keyboard_check_pressed(vk_space))
{
	if(ground or coyote_c or wall_stick)
	{
		Emotiza=0;
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
		
		y_speed = -jump_power;
		
		sinking = false;
        alarm[1] = sinking_timer;
	}
}
if (keyboard_check_released(vk_space))
{
	if(y_speed < 0) y_speed = 0;	
}

if(keyboard_check_pressed(ord("R")))
{
	y_speed -= 5;
	if(right)
	{
		x_speed += 10;	
	}
	else
	{
		x_speed -= 10;	
	}
}
// ------------ Slow ---------------

if(planet_fast){
	x_accel=0.8;
	
	if(x_speed>-9) x_speed -= fast_acc;;
}


// ------------ Portal Jump
if(portal_jump){
	
	if(x_speed>-7) x_speed-=3;
}

//-- Crear plataformas --//

if(keyboard_check_pressed(ord("Q")) and crystalPow and !ground)
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



if (keyboard_check(vk_shift)) {
    // Detectar colisión a la derecha
    if (collision_rectangle(x + 12, y - 3, x + 18, y - 30, o_solid, 0, 1) && right) {
        climb_var = 1;
    }
    // Detectar colisión a la izquierda
    else if (collision_rectangle(x - 12, y - 3, x - 18, y - 30, o_solid, 0, 1) && !right) {
        climb_var = 1;
    }
}

// Lógica de movimiento vertical durante la escalada
if (climb_var == 1) {
    if (keyboard_check(ord("W"))) {
        y_speed = -2; // Mover hacia arriba
    } else if (keyboard_check(ord("S"))) {
        y_speed = 2;  // Mover hacia abajo
    } else {
        y_speed = 0;  // Quedarse quieto si no se presiona ninguna tecla
    }
    
    // Opcional: desactivar el movimiento horizontal mientras escalas
    x_speed = 0;
}

// Si no se está presionando Shift, salir del estado de escalada
if (!keyboard_check(vk_shift)) {
    climb_var = 0;
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
if (!place_free(x,y+1)){
	ground=1;
	portal_jump=0;
	y_speed=0;
	coyote_c=1;
}
else{
	climb_var=0;
	ground=0;
	y_speed+=grav;
	if(coyote_c and alarm[11]==-1) alarm[11]=coyote_t;
	if(y_speed > fall_max) y_speed = fall_max;
	if(!place_free(x,y-1)){
		if(y_speed<0) y_speed=0;
	}
}

//Capture information


