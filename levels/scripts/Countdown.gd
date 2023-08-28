extends Label

var countdown = 4
var countBool = true
signal startTime

#Does a 3 sec countdown before game starts
func _process(delta):
	countdown -= delta
	var countsec = fmod(countdown, 60)
	var time_passed = "%02d" % [countsec]
	if(countsec < 1 && countBool):
		emit_signal("startTime")
		text = ""
		countBool = false
	elif(countsec > 1):
		text = "Countdown: "+String(time_passed)

#Displays message if the player
#goes to the goal b4 having 5 gems
func _on_GoalZone_moreGems():
	add_color_override("font_color", Color(1,0,0,1))
	text = "Collect More Gems"

#Makes the message label blank
#When the player leaves the goal area
func _on_GoalZone_leftBody():
	text = ""
