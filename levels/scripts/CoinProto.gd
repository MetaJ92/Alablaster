extends Area

signal gemCollected
signal gemCount

func _physics_process(delta):
	rotate_y(deg2rad(3))

func _on_Gem_body_entered(body):
	if body.name == "Ball":
		queue_free()
		emit_signal("gemCount")
		emit_signal("gemCollected")
