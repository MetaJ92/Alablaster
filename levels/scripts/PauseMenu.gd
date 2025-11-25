extends Control

var is_paused = false setget set_is_paused
var allowPause = true
#var shaderMovement = true

func _unhandled_input(event):
	if(event.is_action_pressed("pause") && allowPause):
		self.is_paused = !is_paused
		$PauseCenterContainer/VBoxContainer/ResumeBtn.grab_focus()

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	if(is_paused):
		VisualServer.set_shader_time_scale(0.0)
	else:
		VisualServer.set_shader_time_scale(1.0)


func _on_ResumeBtn_pressed():
	self.is_paused = false


func _on_ReturnBtn_pressed():
	self.is_paused = false
	get_tree().change_scene("res://levels/MainMenu.tscn")


func _on_GoalZone_stopPause():
	allowPause = false


func _on_RetryBtn_pressed():
	self.is_paused = false
	get_tree().reload_current_scene()
