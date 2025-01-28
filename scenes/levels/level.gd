extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")


func _on_player_laser_shot(laser_position, laser_direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = laser_position
	laser.direction = laser_direction
	laser.look_at(laser.global_position + laser_direction)
	$Projectiles.add_child(laser)
	$UI.update_laser_text()
	
func _on_player_grenade_shot(grenade_position, grenade_direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = grenade_position
	grenade.linear_velocity = grenade_direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()

func _on_house_player_entered() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 1)


func _on_house_player_exited() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
