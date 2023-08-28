extends Area

var gemCount = 0
signal moreGems
signal leftBody
#Stops time and sets up the Result screen 
signal stopTime
signal stopPause

func _on_GoalZone_body_entered(body):
	if (body.name == "Ball" && gemCount == 5):
		emit_signal("stopTime")
		emit_signal("stopPause")
	elif(body.name == "Ball" && gemCount <= 4):
		emit_signal("moreGems")


func _on_Gem_gemCount():
	gemCount += 1 
	$GemGet.play()


func _on_GoalZone_body_exited(body):
	if(body.name == "Ball"):
		emit_signal("leftBody")
