extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_bar(amount, full):
	#texture_progress = bar_green
	#if amount < 0.75 * full:
	#	texture_progress = bar_yellow
	#if value < 0.45 * full:
	#	texture_progress = bar_red
	value = amount
