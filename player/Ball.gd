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

##Test shader script
#shader_type spatial;
#render_mode unshaded, depth_draw_never, ambient_light_disabled;
#
#uniform int step_count : hint_range(3, 15, 2) = 3; // 2 samples per step
#uniform float thickness : hint_range(1.0, 16.0, 0.1) = 3.0;
#uniform vec3 EDGE_COLOR = vec3(0.0);
#//uniform vec3 outlineColor = vec3(0.0);
#uniform float fade_start : hint_range(1.0, 1000.0, 0.1) = 100.0;
#uniform float fade_length : hint_range(1.0, 1000.0, 0.1) = 200.0;
#
#void fragment( )
#{
#	// Setup step parameters
#	float TAU = 3.14159265358979+3.14159265358979;
#	vec2 step_length = 1.0 / VIEWPORT_SIZE * thickness;
#	float step_angle = TAU / float(step_count);
#	// Per-pixel jitter to reduce patterning
#	float start_angle = fract(sin(dot(SCREEN_UV, vec2(12.9898, 78.233))) * 43758.5453) * TAU;
#	vec2 dir = vec2(cos(start_angle), sin(start_angle));
#	// step rotation matrix
#	mat2 rot = mat2(
#		vec2(cos(step_angle), -sin(step_angle)),
#		vec2(sin(step_angle),  cos(step_angle)));
#	vec3 avg_dx = vec3(0.0);
#	vec3 avg_dy = vec3(0.0);
#	// save closest pixel to uniformly fade line.
#	float min_z = 1e6;
#	// Sample and average derivatives for all pairs
#	for (int i = 0; i < step_count; i++) {
#		vec2 uv1 = SCREEN_UV + dir * step_length;
#		vec2 uv2 = SCREEN_UV - dir * step_length;
#		float d1 = texture(DEPTH_TEXTURE, uv1).r;
#		float d2 = texture(DEPTH_TEXTURE, uv2).r;
#		vec4 up1 = INV_PROJECTION_MATRIX * vec4(uv1 * 2.0 - 1.0, d1, 1.0);
#		vec4 up2 = INV_PROJECTION_MATRIX * vec4(uv2 * 2.0 - 1.0, d2, 1.0);
#		vec3 p1 = up1.xyz / up1.w;
#		vec3 p2 = up2.xyz / up2.w;
#		min_z = min(min_z, min(-p1.z, -p2.z));
#		vec3 diff = p1 - p2;
#		avg_dx += diff * dir.x;
#		avg_dy += diff * dir.y;
#
#		dir = rot * dir; // rotate direction for next step
#	}
#	// fade outline width with distance
#	float distance_fade = 1e-4 + smoothstep(fade_start + fade_length, fade_start, min_z);
#
#	// Edge mask
#	float edge = 1.0 - smoothstep(0.1, 0.15, dot(normalize(cross(avg_dy, avg_dx)), VIEW));
#
#	// Small vignette at screen edges
#	edge *= smoothstep(0.00, 0.015 * thickness,
#		1.0 - max(abs(SCREEN_UV.x - 0.5), abs(SCREEN_UV.y - 0.5)) * 2.0);
#
#	// blend_premul_alpha avoids need to sample screentexture.
#	ALBEDO = EDGE_COLOR * edge;
#	ALPHA = edge * distance_fade;
#}
