extends CharacterBody2D

var active: bool = false
@export var speed: int = 500

func _physics_process(_delta: float) -> void:
	if active:
		look_at(Globals.player_position)
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true


func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false


func _on_navigation_timer_timeout() -> void:
	if active:
		$NavigationAgent2D.target_position = Globals.player_position
