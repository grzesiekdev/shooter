extends CharacterBody2D

var can_shoot: bool = true
var can_grenade: bool = true

signal laser_shot
signal grenade_shot
	
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 600
	move_and_slide()
	
	if Input.is_action_just_pressed("primary action") and can_shoot:
		can_shoot = false
		$ShootTimer.start()
		laser_shot.emit()
	
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		grenade_shot.emit()
	
	

func _on_timer_timeout() -> void:
	can_shoot = true


func _on_grenade_timer_timeout() -> void:
	can_grenade = true
