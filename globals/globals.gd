extends Node

signal health_change
signal laser_amount_change
signal grenade_amount_change

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	set(value):
		laser_amount = value
		laser_amount_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		grenade_amount_change.emit()

var player_vulnerable: bool = true

var health = 100: 
	set(value):
		if (value - health) > 0:
			health = min(value, 100)
		elif player_vulnerable:
			health = value
			player_vulnerable = false
			player_invulnerable_timer()
			player_hit_sound.play()
		health_change.emit()
		
var player_position: Vector2

func player_invulnerable_timer() -> void:
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

func _ready() -> void:
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://resources/audio/solid_impact.ogg")
	add_child(player_hit_sound)
