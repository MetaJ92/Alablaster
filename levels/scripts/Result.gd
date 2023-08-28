extends Control
#This is the script to the Result control
#This method takes a signal from the label named Timer and its script and tries to update the Result scene
signal recordTime(record)
signal recentTime(time_passed)

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	$AudioStreamPlayer.play()

func _on_Replay_pressed():
	self.is_paused = false
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	self.is_paused = false
	get_tree().change_scene("res://levels/MainMenu.tscn")

func _on_Timer_timeResult(time_passed, time, levelName):
	if (levelName == "Level01"):
		if(time < global.time01):
			global.time01 = time
			global.Record01 = time_passed
			emit_signal("recordTime", time_passed)
		else:
			emit_signal("recordTime", global.Record01)
	elif (levelName == "Level02"):
		if(time < global.time02):
			global.time02 = time
			global.Record02 = time_passed
			emit_signal("recordTime", time_passed)
		else:
			emit_signal("recordTime", global.Record02)
	elif (levelName == "Level03"):
		if(time < global.time03):
			global.time03 = time
			global.Record03 = time_passed
			emit_signal("recordTime", time_passed)
		else:
			emit_signal("recordTime", global.Record03)
	elif (levelName == "Level04"):
		if(time < global.time04):
			global.time04 = time
			global.Record04 = time_passed
			emit_signal("recordTime", time_passed)
		else:
			emit_signal("recordTime", global.Record04)
	#Displays time of run
	emit_signal("recentTime", time_passed)
	set_is_paused(true)
