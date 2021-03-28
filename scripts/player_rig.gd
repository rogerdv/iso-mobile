extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var projectile = preload("res://assets/projectile-particles.tscn")
var current_dir
const GRAVITY = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass #current_dir = $player.global_transform.basis.z	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func signed_angle_to(u, v, axis):
	  var dir = u.cross(v).dot(axis)
	  var unsigned = u.angle_to(v)
	  if dir > 0:
		   return unsigned
	  else:
		   return -unsigned
		
func move(dir:Vector2, delta):
	
	if dir!=Vector2.ZERO:
		current_dir = dir
		var mod = delta*-5
		$player.play_anim("Run-loop")
		#var rel = $player.translation + Vector3(dir.x,0,dir.y)*-1
		#$player.look_at(rel,Vector3.UP)
		var a = signed_angle_to(transform.basis.z.normalized(), Vector3(dir.x, 0, dir.y).normalized(), Vector3.UP)
		#then just rotate about y
		#$player.rotate_y(a)
		$player.rotation = Vector3($player.rotation.x,a,$player.rotation.z)
		var coll = $player.move_and_collide(Vector3(dir.x,0,dir.y)*mod)
		$pivot.translation = $player.translation
	else:
		$player.play_anim("Idle-loop")

func attack():
	print("Attacking")
	var p = projectile.instance()
	get_parent().add_child(p)
	var forward = $player.global_transform.basis.z	
	p.dir = current_dir
	#p.translation =  $player.translation + Vector3(current_dir.x,1,current_dir.y)*-1
	p.global_transform.origin  = $player.global_transform.origin - forward 
	p.global_transform.origin.y += 1
	

func get_camera() -> Node:
	return $pivot/Camera
	

func _on_SwipeDetect_swiped(direction) -> void:
	if abs(direction.x)<abs(direction.y):	#vertica swipe, zoom
		$pivot/Camera.translation.y += direction.y
		$pivot/Camera.translation.z += direction.y
