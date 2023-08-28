extends Area

var death = true

func _on_PauseMenu_leave_pause(leave):
	death = leave


func _on_DeathZone_body_entered(body):
	if (body.name == "Ball"):
		get_tree().reload_current_scene()
