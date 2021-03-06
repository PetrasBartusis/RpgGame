///scr_move_state
if(!obj_player.in_combat){
    //movement for simple running
    movement = MOVE;
    spd = 3.5;
    image_speed = .5;
} else {
    //movement for combat
    movement = COMBAT;
    spd = 3;
    image_speed = .5;
}


//check if player is dashing
if(obj_input.dash_key){
    var xdir = lengthdir_x(8, face * 90);
    var ydir = lengthdir_y(8, face * 90);
    var speaker = instance_place(x + xdir, y + ydir, obj_speaker);
    if(speaker != noone){
        // Talk to it
        with (speaker) {
            if(!instance_exists(dialog)){
                dialog = instance_create(x + xoffset, y + yoffset, obj_dialog);
                dialog.text = text;
            } else {
                dialog.text_page++;
                dialog.text_count = 0;
                if(dialog.text_page > array_length_1d(dialog.text) - 1){
                    with(dialog){
                        instance_destroy();
                    }
                }
            }
        }
    } else if(obj_player_stats.stamina >= DASH_COST){
        // Dash
        state = scr_dash_state;
        alarm[0] = room_speed/6;
        obj_player_stats.stamina -= DASH_COST;
        obj_player_stats.alarm[0] = room_speed;
    }
}

//check if player is attacking
if(obj_input.attack_key){
    //start attack animation from the start
    if(in_combat){
        image_index = 0;
        state = scr_attack_state;
    }
}


//check if player is casting a spell
if(obj_input.spell_key){
    if(obj_player_stats.magicka >= FIREBALL_COST and in_combat){
        //create a projectile
        var p = instance_create(x, y, obj_projectile);
        var xforce = lengthdir_x(10, face * 90);
        var yforce = lengthdir_y(10, face * 90);
        p.creator = id;
        obj_player_stats.magicka -= FIREBALL_COST;
        obj_player_stats.alarm[1] = room_speed/2;
        switch(face){
            case RIGHT:
                p.sprite_index = spr_spell_right;
                break;
            case UP:
                p.sprite_index = spr_spell_up;
                break;
            case LEFT:
                p.sprite_index = spr_spell_left;
                break;
            case DOWN:
                p.sprite_index = spr_spell_down;
                break;
        }
        with(p){
            physics_apply_impulse(x, y, xforce, yforce);
        }
    }
}

//check if player is swapping
if(obj_input.swap_key){
    var nearest_weapon = instance_nearest(x, y, obj_weapon_item);
    if(place_meeting(x, y + 4, nearest_weapon)){
        scr_swap_weapons(nearest_weapon);
    }
}

if(obj_input.sheath_key){
    if(obj_player.in_combat){
        obj_player.in_combat = false;
    } else {
        obj_player.in_combat = true;
    }
}

// Get direction
dir = point_direction(0, 0, obj_input.xaxis, obj_input.yaxis);

// Get the length
if(obj_input.xaxis == 0 and obj_input.yaxis == 0){
    len = 0;
    } else {
    len = spd;
    scr_get_face(dir);
}

// Get the hspd and vspd
hspd = lengthdir_x(len, dir);
vspd = lengthdir_y(len, dir);

// Move
phy_position_x += hspd;
phy_position_y += vspd;

// Control the sprite
if(len == 0) {
    if(!in_combat){
        movement = IDLE;
        image_speed = .03;
    } else {
        movement = IDLE_COMBAT;
        image_speed = .05;
    }
    
}

