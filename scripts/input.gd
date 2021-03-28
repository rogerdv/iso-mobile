extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var joystick = get_node("../CanvasLayer/UI").get_joystick()
var ray = RayCast.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("../CanvasLayer/UI").connect("attack_pressed",get_node("../player"),"attack")

func _unhandled_input(event):
	pass
				
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var from = get_node("../player").get_camera().project_ray_origin(event.position)
		
		var to = from + get_node("../player").get_camera().project_ray_normal(event.position)*400
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 1)
		if result.size()>0:
			print("Collided with something")
			if result["collider"].name.find("npc")>0:
				result["collider"].select(true)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	get_node("../player").move(joystick.get_value().normalized(), delta)
	#check if some object is in the middle	
	var cam = get_node("../player").get_camera()
	ray.translation = cam.translation
	ray.cast_to = get_node("../player").translation
	if ray.is_colliding():	
		print("something")
		
	


