extends ItemContainer

func hit() -> void:
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions.get_children()[0].global_position
		open.emit(pos, current_direction)
		opened = true
