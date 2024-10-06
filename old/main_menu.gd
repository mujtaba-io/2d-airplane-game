extends Control

func _process(delta):
	if $play_button.pressed:
		get_tree().change_scene_to_file("res://level1.tscn")
	if $exit_button.pressed:
		pass
