if (!wall_slide_enabled) exit;
// Starting Wall Slide
var result = key_right - key_left;
if (!is_on_floor())
{
    // If the player is falling close to the wall
    if (!can_move_x(result) && vspeed > 0)
    {
        wall_slide = true;
        wall_slide_dir = result;
        walk_ignore_dir = true;
        walk_ignore_move = true;
        dash_enabled = false;
    }
}
// Wall Slide
if (wall_slide)
{
    var t = wall_slide_t;
    gravity = 0;
    walk_speed = walk_speed_default;
    player_counters_reset();
    
    if (t == 0)
    {
        animation_play("wall_slide");
        fall_enabled = false;
        vspeed = 0;
    }
    if (t == 4) audio_play(wall_slide_sound);
    
    if (t == 5) dir = -wall_slide_dir;
    
    if (t >= 5)
	{
		if (instance_exists(wall_slide) && wall_slide_dust.script != noone)
		{
			script_execute(wall_slide_dust.script);
		}
	}
    if (t >= 7) vspeed = 2;
    
    if (is_on_floor(2) || result != wall_slide_dir || can_move_x(wall_slide_dir))
    {
        wall_slide = false;
        wall_slide_t = -1;
        fall_enabled = true;
        walk_ignore_dir = false;
        walk_ignore_move = false;
        dash_enabled = true;
        if (!is_on_floor(2)) vspeed = 0;
    }
    wall_slide_t++;
}