extends CharacterBody2D

var can_shoot: bool = true
var can_grenade: bool = true

signal laser_shot(pos, direction)
signal grenade_shot(pos, direction)

@export var max_speed: int = 1200
var speed: int = max_speed

	
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	velocity = direction * speed
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("primary action") and can_shoot:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers.pick_random()
		can_shoot = false
		$ShootTimer.start()
		Globals.laser_amount -= 1
		laser_shot.emit(selected_laser.global_position, player_direction)
		$LaserStartPositions/LaserParticlesEmitter.emitting = true
	
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		Globals.grenade_amount -= 1
		var grenade_marker = $GrenadeStartPosition.get_child(0)
		can_grenade = false
		$GrenadeTimer.start()
		grenade_shot.emit(grenade_marker.global_position, player_direction)
	
func _on_timer_timeout() -> void:
	if Globals.laser_amount > 0:
		can_shoot = true


func _on_grenade_timer_timeout() -> void:
	if Globals.grenade_amount > 0:
		can_grenade = true
