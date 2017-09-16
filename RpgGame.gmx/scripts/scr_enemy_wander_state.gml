///scr_enemy_wander_state
scr_check_for_player();
if(point_distance(x, y, targetx, targety) > spd){
    //get a direction
    var dir = point_direction(x, y, targetx, targety);
    //get directional speed
    var hspd = lengthdir_x(spd, dir);
    var vspd = lengthdir_y(spd, dir);
    //turn the enemy towards the player and check if it's not 0
    if(hspd != 0){
        image_xscale = sign(hspd);
    }
    //move enemy object
    phy_position_x += hspd;
    phy_position_y += vspd;
}

