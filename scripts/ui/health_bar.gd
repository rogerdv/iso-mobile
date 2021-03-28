extends Sprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bar = $Viewport/HealthBar2D

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = $Viewport.get_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update(value, full):
	bar.update_bar(value, full)
	

