extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body) -> void:
	print("Player has entered!!!!!")
	print(body)


func _on_player_laser_shot(laser_position, laser_direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = laser_position
	laser.direction = laser_direction
	laser.look_at(laser.global_position + laser_direction)
	$Projectiles.add_child(laser)
	
func _on_player_grenade_shot(grenade_position, grenade_direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = grenade_position
	grenade.linear_velocity = grenade_direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_house_player_entered() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 1)


func _on_house_player_exited() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
