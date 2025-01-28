extends Area2D

@export var rotation_speed: int = 5
var available_options: Array = ['health', 'laser', 'laser', 'laser', 'laser', 'grenade']
var type: String = available_options.pick_random()

func _ready() -> void:
	if type == 'laser':
		$Sprite2D.modulate = Color(0.2, 0.2, 0.6)
	elif type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.2, 0.2)
	elif type == 'health':
		$Sprite2D.modulate = Color(0.2, 0.8, 0.2)
		
func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	body.add_item(type)
	queue_free()
