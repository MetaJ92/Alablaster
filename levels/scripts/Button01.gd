extends Button

#var btn_font = get("res://assets_test/material/Dom Casual Regular.otf")

#This script is for the first button on a menu that should be highlighted when scene is visible. For othe rbuttons take out grab_focus() from _ready()
func _ready():
	grab_focus()
#	if(get_name() == "Button01" || get_name() == "ResumeBtn" || get_name() == "Replay"):
#		grab_focus()
	#Regular Colors
	#Letters Hex Yellow = e7e000
	#Outline Hex Blue = 022b6b DEFAULT FONT OUTLINE
	#Button Hex Cyan = 00c8d7
	
	#On_Focus Colors
	#Letters Hex = 37e80c
	#Outlines Hex = deff81
	#Button Hex Salmon = ffad94
	
	# Font
	#Pressed Orange e67016


#func _on_Button01_focus_entered():
#	print("Button01 Focus entered")
	#btn_font.outline_color = Color.red#Color("#ffad94")
	#pass # Replace with function body.
#	self.add_color_override("font_color", Color("#37e80c"))
	#self.add_font_override(Color("#deff81"))
#	self.add_color_override("bg_color", Color("#ffad94"))

	#self.add_color_override("font_color", Color("#37e80c"))
