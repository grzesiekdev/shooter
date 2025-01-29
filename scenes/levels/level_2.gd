extends LevelParent


func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.15)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_house_player_entered() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 1)


func _on_house_player_exited() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
