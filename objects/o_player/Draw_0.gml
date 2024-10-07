// --------- DETECCIÓN DE ESCALADA ------------
if (keyboard_check(vk_shift)) {
    if (collision_rectangle(x + 12, y - 3, x + 18, y - 30, o_solid, 0, 1) && right) {
        climb_var = 1; 
        ground = 0;     
    }
    else if (collision_rectangle(x - 12, y - 3, x - 18, y - 30, o_solid, 0, 1) && !right) {
        climb_var = 1; 
        ground = 0;
    }
}

// --------- MOVIMIENTO VERTICAL EN ESCALADA -----------
// Lógica para moverse verticalmente durante la escalada
if (climb_var == 1) {
    if (keyboard_check(ord("W"))) {
        y_speed = -2; // Subir al presionar W
    } else if (keyboard_check(ord("S"))) {
        y_speed = 2;  // Bajar al presionar S
    } else {
        y_speed = 0;  // Quedarse quieto si no se presiona nada
    }
    
    // Desactivar el movimiento horizontal mientras escala
    x_speed = 0;
}

// Si no se está presionando Shift, salir del estado de escalada
if (!keyboard_check(vk_shift)) {
    climb_var = 0;
    if (!place_free(x, y + 1)) {
        ground = 1;  // Volver al estado de suelo si está en el suelo
    }
}

// --------- SPRITE CHECKS ---------------

// Verificar si está escalando y cambiar el sprite
if (climb_var == 1) {
    if (y_speed == 0) {
        sprite_index = s_climbs_idle;  // Sprite de escalada en reposo
    } else {
        sprite_index = s_climb;  // Sprite de escalada en movimiento
    }
}
// Si no está escalando, manejar el resto de los estados
else if (ground) {
    if (!Emotiza) {
        if (x_speed == 0) {
            sprite_index = s_idle;  // Sprite en reposo en el suelo
        } else {
            sprite_index = s_walk;  // Sprite caminando
        }
    } else {
        sprite_index = s_crouch;  // Sprite agachado
    }
} 
// Si está en el aire (no en el suelo)
else {
    if (!Emotiza) {
        if (y_speed >= 0) {
            sprite_index = s_fall;  // Sprite cayendo
        } else {
            sprite_index = s_jump;  // Sprite saltando
        }
    } else {
        sprite_index = s_crouch;  // Sprite agachado en el aire
    }
}

// Ajustar la dirección de la imagen (escalado horizontal)
if (right) {
    image_xscale = 1;
} else {
    image_xscale = -1;
}
// Establecer el índice de la máscara
mask_index = s_player_mask; 

// Dibujar el sprite
draw_self();
