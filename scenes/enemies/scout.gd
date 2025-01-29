extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var laser_spawn_points: Array
var chosen_spawn_point: int = 0
var is_invulnerable: bool = false

@export var health: int = 50

signal laser(pos, direction)


func hit():
	if not is_invulnerable:
		health -= 10
		if health <= 0:
			queue_free()
		is_invulnerable = true
		$DamageCooldown.start()
		$Sprite2D.material.set_shader_parameter("progress", 0.3)
	
func _ready() -> void:
	laser_spawn_points = [$LaserSpawnPosition/Marker2D, $LaserSpawnPosition/Marker2D2]

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var pos: Vector2 = laser_spawn_points[chosen_spawn_point].global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_laser_cooldown_timeout() -> void:
	can_laser = true
	chosen_spawn_point += 1
	if chosen_spawn_point > 1:
		chosen_spawn_point = 0


func _on_damage_cooldown_timeout() -> void:
	is_invulnerable = false
	$Sprite2D.material.set_shader_parameter("progress", 0.0)
