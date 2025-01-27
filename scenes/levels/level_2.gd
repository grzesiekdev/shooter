extends LevelParent


func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.15)
