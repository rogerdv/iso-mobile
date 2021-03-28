extends Node2D

signal swiped(direction)
signal swiped_canceled(start_position)

var MAX_DIAGONAL_SLOPE = 1.3

onready var timer = $Timer
var swipe_start = Vector2()


func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		_start_detection(event.position)
	elif not timer.is_stopped():
		_end_detection(event.position)
		 
func _start_detection(position):
	swipe_start = position
	timer.start()

func _end_detection(position):
	timer.stop()
	var direction = (position - swipe_start).normalized()
	if abs(direction.x) + abs(direction.y)>=MAX_DIAGONAL_SLOPE:
		return
	
	if abs(direction.x) > abs(direction.y):	#Vertical swipe
		emit_signal("swiped",Vector2(-sign(direction.x),0))
	else:
		emit_signal("swiped",Vector2(direction.x,-sign(direction.y)))

func _on_Timer_timeout() -> void:
	emit_signal("swiped_canceled", swipe_start)
