extends Area2D

@export var rotation_speed: int = 5
var available_options: Array = ['health', 'laser', 'laser', 'laser', 'laser', 'grenade']
@export var type: String = available_options.pick_random()
var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready() -> void:
	if type == 'laser':
		$Sprite2D.modulate = Color(0.2, 0.2, 0.6)
	elif type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.2, 0.2)
	elif type == 'health':
		$Sprite2D.modulate = Color(0.2, 0.8, 0.2)
		
	var target_position = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))
	tween.tween_property(self, "position", target_position, 0.5)
	
func _process(delta: float) -> void:
	rotation += rotation_speed * delta

func _on_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer2D.play()
	visible = false
	await $AudioStreamPlayer2D.finished
	if type == 'laser':
		Globals.laser_amount += 5
	elif type == 'grenade':
		Globals.grenade_amount += 1
	elif type == 'health':
		Globals.health += 10
	queue_free()
