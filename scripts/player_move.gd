extends KinematicBody


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var move_vec = Vector3(0,0,0)
var motion = Vector3()
var current_dir
const GRAVITY = 20
var projectile = preload("res://assets/projectile-particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

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
		play_anim("Run-loop")
		#var rel = $player.translation + Vector3(dir.x,0,dir.y)*-1
		#$player.look_at(rel,Vector3.UP)
		var a = signed_angle_to(transform.basis.z.normalized(), Vector3(dir.x, 0, dir.y).normalized(), Vector3.UP)
		#then just rotate about y
		#$player.rotate_y(a)
		rotation = Vector3(rotation.x,a,rotation.z)
		var coll = move_and_collide(Vector3(dir.x,0,dir.y)*mod)
		if coll==null:
			$Camera.translate(Vector3(dir.x,0,dir.y)*mod)
			#$pivot.translation = $player.translation
	else:
		play_anim("Idle-loop")

func attack():
	print("Attacking")
	var p = projectile.instance()
	get_parent().add_child(p)
	var forward = global_transform.basis.z	
	p.dir = current_dir
	#p.translation =  $player.translation + Vector3(current_dir.x,1,current_dir.y)*-1
	p.global_transform.origin  = global_transform.origin - forward 
	p.global_transform.origin.y += 1
	

func get_camera() -> Node:
	return $Camera
	
func play_anim(animation:String):
	$AnimationPlayer.play(animation)

#func _physics_process(delta: float) -> void:
#	if move_vec!=Vector3.ZERO:
#		look_at(transform.origin + move_vec,Vector3.UP)
#		move_and_collide(move_vec)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
