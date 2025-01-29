extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect('open', _on_container_opened)
		
	for scout in get_tree().get_nodes_in_group('scouts'):
		scout.connect('laser', _on_scout_laser)
		
func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)

func _on_player_laser_shot(laser_position, laser_direction) -> void:
	create_laser(laser_position, laser_direction)
	
func _on_player_grenade_shot(grenade_position, grenade_direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = grenade_position
	grenade.linear_velocity = grenade_direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()

func create_laser(laser_position, laser_direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = laser_position
	laser.direction = laser_direction
	laser.look_at(laser.global_position + laser_direction)
	$Projectiles.add_child(laser)
	
func _on_scout_laser(pos, direction) -> void:
	create_laser(pos, direction)
