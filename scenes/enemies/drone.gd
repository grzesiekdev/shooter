extends CharacterBody2D

@export var speed: int = 400
@export var health: int = 30
@export var explosion_radius: int = 300

var active: bool = false
var vulnerable: bool = true
var explosion_active: bool = false

func _ready() -> void:
	$Explosion.hide()
	
func _process(delta: float) -> void:
	if active:
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("Explosion")
			explosion_active = true
		if explosion_active:
			var containers: Array = get_tree().get_nodes_in_group('Container')
			var entities: Array = get_tree().get_nodes_in_group('Entities')
			var all_objects: Array = containers + entities
			
			for object in all_objects:
				if global_position.distance_to(object.global_position) < explosion_radius:
					if 'hit' in object:
						object.hit()
	
func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
		$DroneSprite.material.set_shader_parameter("progress", 0.3)
	if health <= 0:
		$AnimationPlayer.play("Explosion")
		explosion_active = true

func _on_notice_area_body_entered(body: Node2D) -> void:
	active = true
	var tween: Tween = create_tween()
	tween.tween_property(self, "speed", 1000, 1)


func _on_notice_area_body_exited(body: Node2D) -> void:
	active = false
	speed = 400


func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$DroneSprite.material.set_shader_parameter("progress", 0.0)
