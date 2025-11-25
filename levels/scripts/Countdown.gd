extends Label

var countdown = 4
var countBool = true
signal startTime

#Does a 3 sec countdown before game starts
func _process(delta):
	if(countBool):
		countdown -= delta
		var countsec = fmod(countdown, 60)
		#var time_passed = "%02d" % [countsec]
	#	if(countsec < 1 && countBool):
	#		emit_signal("startTime")
	#		text = "Go!"
	#		countBool = false
		if(countsec > 3):
			add_color_override("font_color", Color(0.8627451, 0.078431375, 0.23529412, 1))
			#add_color_override("outline_color", Color(1, 1, 0.8784314, 1))
			self.get("custom_fonts/font").outline_color = Color(1, 1, 0.8784314, 1)
			##$Countdown.add_theme_color_override("font_color", Color(1, 0.5, 0))
			#self.add_theme_color_override()
			text = "      Ready.."
			#red orange gradient
		elif(countsec > 2):
			add_color_override("font_color", Color(0.85490197, 0.64705884, 0.1254902, 1))
			text = "      Set.."
			#yellow gradient
		elif(countsec < 0.5 && countBool):
			text = ""
			countBool = false
		elif(countsec < 1 && countBool):
			#text = "Countdown: "+String(time_passed)
			#green gradient
			add_color_override("font_color", Color(0.19607843, 0.8039216, 0.19607843, 1))
			text = "      Go!!"
			emit_signal("startTime")
			#countBool = false


#Displays message if the player
#goes to the goal b4 having 5 gems
func _on_GoalZone_moreGems():
	add_color_override("font_color", Color(1,0,0,1))
	text = "Collect More Gems"

#Makes the message label blank
#When the player leaves the goal area
func _on_GoalZone_leftBody():
	text = ""
