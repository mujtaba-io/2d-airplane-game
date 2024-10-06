extends Control

func _process(delta):
	if $mainmenu_button.pressed:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	if $replay_button.pressed:
		# todo: check if they were previously playing level1 or level2
		get_tree().change_scene_to_file("res://level1.tscn")
