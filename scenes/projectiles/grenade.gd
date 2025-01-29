extends RigidBody2D

@export var speed:int = 750
@export var explosion_radius:int = 300
var explosion_active: bool = false

func explode() -> void:
	$GrenadeSpirit.visible = false
	explosion_active = true

func _process(_delta: float) -> void:
	if explosion_active:
		var containers: Array = get_tree().get_nodes_in_group('Container')
		var entities: Array = get_tree().get_nodes_in_group('Entities')
		var all_objects: Array = containers + entities
		
		for object in all_objects:
			if global_position.distance_to(object.global_position) < explosion_radius:
				if 'hit' in object:
					object.hit()
