extends Control


func _ready():
	if(global.time01 != 600.0 && global.time02 != 600.0
	&& global.time03 != 600.0 && global.time04 != 600.0):
		$TitleCard.texture = load("res://assets_test/material/Rainbow_Title(1).png")

func _on_Button01_pressed():
	get_tree().change_scene("res://levels/Level01.tscn")


func _on_Button05_pressed():
	get_tree().quit()


func _on_Button02_pressed():
	get_tree().change_scene("res://levels/Level02.tscn")


func _on_Button04_pressed():
	get_tree().change_scene("res://levels/Level04.tscn")


func _on_Button03_pressed():
	get_tree().change_scene("res://levels/Level03.tscn") 
