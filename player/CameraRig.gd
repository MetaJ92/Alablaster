extends Position3D

export var rotate_speed = PI/2

func _physics_process(delta):
	#Rotate outer gimbal around y axis
	var y_rotate = 0
	if Input.is_action_pressed("cam_right"):
		y_rotate +=1
	if Input.is_action_pressed("cam_left"):
		y_rotate -=1
	rotate_object_local(Vector3.UP, y_rotate*rotate_speed*delta)
	#Rotate inner gimbal around local x axis
	var x_rotate = 0
	if Input.is_action_pressed("cam_up"):
		x_rotate +=1
	if Input.is_action_pressed("cam_down"):
		x_rotate -=1
	rotate_object_local(Vector3.RIGHT, x_rotate*rotate_speed*delta)
