extends ItemContainer

func hit() -> void:
	if not opened:
		$LidSprite.hide()
		for i in range(3):
			var pos = $SpawnPositions.get_children().pick_random().global_position
			open.emit(pos, current_direction)
		opened = true
