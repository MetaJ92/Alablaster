extends Label

var gems = 0

func _ready():
	add_color_override("font_color", Color(1, 1, 0, 1))
	text = String(gems)+"/5"


func _on_gem_collected():
	gems += 1
	_ready()
