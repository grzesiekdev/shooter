extends Node

signal health_change
signal laser_amount_change
signal grenade_amount_change

var laser_amount = 20:
	set(value):
		laser_amount = value
		laser_amount_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		grenade_amount_change.emit()
		
var health = 60: 
	set(value):
		health = value
		health_change.emit()
		
