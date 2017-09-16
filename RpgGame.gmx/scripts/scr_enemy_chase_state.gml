///scr_enemy_chase_state
if(instance_exists(obj_player)){
	phy_position_x += sign(obj_player.x - x) * spd;
	phy_position_y += sign(obj_player.y - y) * spd;
}

