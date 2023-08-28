extends Label

var time = 0;
var timer_on = false
var time_passed

signal timeResult

func _process(delta):
	add_color_override("font_color", Color(1, 1, 0, 1))
	if(timer_on):
		time += delta
	
	var mins = fmod(time, 60*60)/60
	var secs = fmod(time, 60)
	var mils = fmod(time,1)*1000
	
	time_passed = "%02d:%02d:%03d" % [mins,secs,mils]
	text = "Time: "+time_passed

#This starts the timer after the 3 sec countdown
func _on_startTime():
	timer_on = true 

#This stops the timer upon level complete
#Then it sends
func _on_GoalZone_stopTime():
	timer_on = false
	var levelName = get_tree().current_scene.name
	time_passed = String("%02d:%02d:%03d" % [fmod(time, 60*60)/60, fmod(time, 60), fmod(time,1)*1000])
	emit_signal("timeResult", time_passed, time, levelName)
