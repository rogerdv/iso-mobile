extends Particles


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var dir:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector3(dir.x,0,dir.y)*delta*-10)
