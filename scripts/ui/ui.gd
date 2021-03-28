extends Control


# Declare member variables here. Examples:
var s
# var b: String = "text"

signal attack_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	s = OS.get_screen_size()
	_adjust_ui()
	
	
func _adjust_ui():	
	#adjust joystick location&scale
	var scale_x = 14.98 *s.x /100 /128
	var scale_y = 26.66*s.y /100 / 128
	$Joystick.position.x = s.x * 0.09
	$Joystick.position.y = s.y - (s.y*0.15)
	$Joystick.scale.x = scale_x
	$Joystick.scale.y = scale_y
	
	#adjust attack button
	scale_x = 7.49*s.x/100 / 64 
	scale_y = 13.3 *s.y/100 /64
	$attack.position.x = s.x - (scale_x*64 + s.x*0.02)
	$attack.position.y = s.y - (scale_y*64 + s.y*0.01)	
	$attack.scale.x = scale_x
	$attack.scale.y = scale_y
	
	#abilities buttons
	var positions = {1:[1.3,1.1],2:[1.28,1.37],3:[1.19,1.74],4:[1.09,1.78]}
	for i in range(1,5):
		var b_name =  "sk"+str(i)
		print(b_name)
		var b:TouchScreenButton = get_node(b_name)
		b.scale.x =scale_x
		b.scale.y =scale_y
		b.position.x = s.x / positions[i][0] #1.3
		b.position.y = s.y / positions[i][1] - s.y*0.06
	
func get_joystick():
	return $Joystick/TouchScreenButton

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	$fps.text = str(Engine.get_frames_per_second())


func _on_attack_pressed() -> void:
	emit_signal("attack_pressed")


func _on_skill_pressed(extra_arg_0):
	$Label.text = extra_arg_0
	$Label/label_clear.start()


func _on_label_clear_timeout():
	$Label.text =  ""
