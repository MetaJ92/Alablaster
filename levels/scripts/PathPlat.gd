extends Path

const speed: float = 0.1

onready var path : Spatial = $PathFollow
var direction : int = 1

func _process(delta)-> void:
	plat_movement(delta)

func plat_movement(delta) -> void:
	path.offset +=delta*speed*direction
	if path.offset == 1.0:
		direction = -1
	elif path.unit_offset == 0.0:
		direction = 1
