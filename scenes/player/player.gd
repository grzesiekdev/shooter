extends CharacterBody2D

var can_shoot: bool = true
var can_grenade: bool = true

signal laser_shot(pos, direction)
signal grenade_shot(pos, direction)
	
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	velocity = direction * 600
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("primary action") and can_shoot:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers.pick_random()
		can_shoot = false
		$ShootTimer.start()
		laser_shot.emit(selected_laser.global_position, player_direction)
	
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		var grenade_marker = $GrenadeStartPosition.get_child(0)
		can_grenade = false
		$GrenadeTimer.start()
		grenade_shot.emit(grenade_marker.global_position, player_direction)
	
	
func _on_timer_timeout() -> void:
	can_shoot = true


func _on_grenade_timer_timeout() -> void:
	can_grenade = true
