extends CanvasLayer

#colors
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)

@onready
var laser_label: Label = %LaserAmountLabel

@onready
var grenade_label: Label = %GrenadeAmountLabel

@onready
var laser_icon: TextureRect = %LaserIcon

@onready
var grenade_icon: TextureRect = %GrenadeIcon

@onready
var health_bar: TextureProgressBar = %HealthBar

func _ready() -> void:
	Globals.connect("health_change", update_health_text)
	Globals.connect("laser_amount_change", update_laser_text)
	Globals.connect("grenade_amount_change", update_grenade_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
func update_health_text():
	health_bar.value = Globals.health
	
func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount > 0:
		label.modulate = green
		icon.modulate = green
	else:
		label.modulate = red
		icon.modulate = red
		
