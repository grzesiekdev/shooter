extends Area2D

@export var speed: int = 1300
var direction: Vector2 = Vector2.ZERO
	
func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
	queue_free()


func _on_laser_timer_timeout() -> void:
	queue_free()
