extends RigidBody

export var rollingForce = 50;
export var jumpHeight = 800
var countdown = 3


#Forward and Back
export (NodePath) var CameraGimbal_path
onready var CameraGimbal = get_node(CameraGimbal_path)

func _ready():
	$CameraGimbal.set_as_toplevel(true)
	$FloorCheck.set_as_toplevel(true)

func _physics_process(delta):
	var lastCamPos = $CameraGimbal.global_transform.origin
	var playerPos = global_transform.origin
	var newCamPos = lerp(lastCamPos, playerPos, 0.1)
	$CameraGimbal.global_transform.origin = newCamPos
	
	$FloorCheck.global_transform.origin = global_transform.origin
	
	#For Up and Down
	var forward = (-CameraGimbal.global_transform.basis.z*Vector3(1,0,1)).normalized()
	#For Left and Right
	var side = (-CameraGimbal.global_transform.basis.x*Vector3(1,0,1)).normalized()
	#Calculate a limit
	var limit = rollingForce/2
	
	countdown -= delta
	var onFloor = $FloorCheck.is_colliding()
	if(countdown < 0 && onFloor):
		if Input.is_action_pressed("forward"):
			apply_central_impulse(rollingForce*forward)
		elif Input.is_action_pressed("back"):
			apply_central_impulse(-rollingForce*forward)
		if Input.is_action_pressed("left"):
			apply_central_impulse(rollingForce*side)
		elif Input.is_action_pressed("right"):
			apply_central_impulse(-rollingForce*side)
	
	#This limits the velocity on Z
	if(onFloor):
		if (angular_velocity.z >= limit):
			angular_velocity.z = limit
		elif(angular_velocity.z <= -limit):
			angular_velocity.z = -limit
		#This limits the velocity on X
		if (angular_velocity.x >= limit):
			angular_velocity.x = limit
		elif(angular_velocity.x <= -limit):
			angular_velocity.x = -limit
	
	if(countdown < 0):
		onFloor = $FloorCheck.is_colliding()
		if Input.is_action_just_pressed("jump") and onFloor:
				apply_central_impulse(Vector3.UP*jumpHeight)
		if (!onFloor):
			if Input.is_action_pressed("forward"):
				apply_central_impulse((rollingForce*forward)/2)
			elif Input.is_action_pressed("back"):
				apply_central_impulse((-rollingForce*forward)/2)
			if Input.is_action_pressed("left"):
				apply_central_impulse((rollingForce*side)/2)
			elif Input.is_action_pressed("right"):
				apply_central_impulse((-rollingForce*side)/2)
