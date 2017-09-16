///scr_enemy_chase_state
scr_check_for_player();
//get a direction
var dir = point_direction(x, y, targetx, targety);
//get directional speed
var hspd = lengthdir_x(spd, dir);
var vspd = lengthdir_y(spd, dir);
//turn the enemy towards the player
image_xscale = sign(hspd);
//move enemy object
phy_position_x += hspd;
phy_position_y += vspd;
