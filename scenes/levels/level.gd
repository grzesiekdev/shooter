extends Node2D


func _on_gate_player_entered_gate(body) -> void:
	print("Player has entered!!!!!")
	print(body)


func _on_player_laser_shot() -> void:
	print("JATATATA FROM LEVEL")
	
func _on_player_grenade_shot() -> void:
	print("GRENADE FROM LEVEL")
