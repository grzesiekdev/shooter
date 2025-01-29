extends CharacterBody2D

var player_nearby: bool = false
var player_in_attack_range: bool = false
var player_too_close: bool = false
var can_attack: bool = true
var body_in_range: CharacterBody2D
var is_invulnerable: bool = false

@export var health: int = 90
@export var speed: int = 400

func _on_notice_area_body_entered(_body: Node2D) -> void:
	$AnimatedSprite.play("walk")
	player_nearby = true

func _on_notice_area_body_exited(_body: Node2D) -> void:
	$AnimatedSprite.stop()
	player_nearby = false
	
func _on_attack_area_body_entered(body: Node2D) -> void:
	player_in_attack_range = true
	body_in_range = body
	$AnimatedSprite.play("attack")

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_in_attack_range = false
	if player_nearby:
		$AnimatedSprite.play("walk")
	
func _process(delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)
		player_too_close = Globals.player_position.distance_to(global_position) < 230
		if not player_too_close:
			var direction: Vector2 = (Globals.player_position - global_position).normalized()
			position += direction * delta * speed
		
func hit() -> void:
	if not is_invulnerable:
		health -= 10
		if health <= 0:
			queue_free()
			is_invulnerable = true
		$DamageCooldown.start()
		$AnimatedSprite.material.set_shader_parameter("progress", 0.3)


func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	$AnimatedSprite.play("attack")

func _on_damage_cooldown_timeout() -> void:
	is_invulnerable = false
	$AnimatedSprite.material.set_shader_parameter("progress", 0.0)


func _on_animated_sprite_animation_finished() -> void:
	if player_in_attack_range and can_attack:
		if 'hit' in body_in_range:
			body_in_range.hit()
			can_attack = false
			$AttackCooldown.start()
