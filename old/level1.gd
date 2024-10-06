extends Node2D

var plane2_scn = preload("res://plane2.tscn")
var hotairbaloon_scn = preload("res://hotairbaloon.tscn")
var airship_scn = preload("res://airship.tscn")

var index : int = 0
var entities = {}

var score : int = 0
var highscore : int = 0
var coins : Dictionary = {}
var game_over : bool = false

func _ready():
	randomize()
	##load_highscore()

func _process(delta):
	if game_over:
		##save_highscore(score)
		get_tree().change_scene_to_file("res://game_over_window.tscn")
	for key in coins:
		var coin = coins[key]
		coin.position.x -= delta * 200
		if has_node("plane"):
			if coin.position.distance_to($plane.position) < 30:
				score+=2
				coin.queue_free()
				coins.erase(key)
	if highscore < score:
		highscore = score
	$background.scroll_offset = Vector2(0, 0)
	$background/layer2.motion_offset += Vector2(-0.15, 0)
	$background/layer3.motion_offset += Vector2(-0.3, 0)
	$background/layer4.motion_offset += Vector2(-0.6, 0)
	$background/layer5.motion_offset += Vector2(-0.8, 0)
	
	$clouds.position.x -= 1
	if $clouds.position.x < -1500:
		$clouds.position.x = 1500
	$score_label.text = "Score: " + str(score)
	$highscore_label.text = "Highscore: " + str(highscore)
	for key in entities:
		var entity = entities[key]
		if entity.position.x < -20 or entity.position.y < -20:
			entity.queue_free()
			entities.erase(key)
"""
func save_highscore(score):
	var save_dict : Dictionary = {}
	if highscore >= score:
		save_dict = {"highscore" : highscore}
	else:
		save_dict = {"highscore" : score}
	var file = FileAccess.new()
	file.open("user://plane_game_save_file", File.WRITE)
	file.store_line(JSON.new().stringify(save_dict))
	file.close()

func load_highscore():
	var saved_game = FileAccess.new()
	saved_game.open("user://plane_game_save_file", File.READ)
	if saved_game.file_exists("user://plane_game_save_file"):
		#while not saved_game.eof_reached():
		var test_json_conv = JSON.new()
		test_json_conv.parse(saved_game.get_line())
		var current_line = test_json_conv.get_data()
		highscore = current_line["highscore"]
	saved_game.close()
"""
func _on_plane2_timer_timeout():
	var plane2 = plane2_scn.instantiate()
	plane2.position = Vector2(1200, randf_range(0, 540))
	plane2.z_index = 3
	#if score > 60:
	#	plane2.add_central_force($plane.position - plane2.position)
	add_child(plane2)
	entities[index] = plane2
	index += 1


func _on_hotairbaloon_timer_timeout():
	var hotairbaloon = hotairbaloon_scn.instantiate()
	hotairbaloon.position = Vector2(800, 800)
	hotairbaloon.z_index = 3
	#if score > 60:
	#	hotairbaloon.add_central_force($plane.position - hotairbaloon.position)
	add_child(hotairbaloon)
	entities[index] = hotairbaloon
	index += 1


func _on_airship_timer_timeout(): # only for dikhawa
	var airship = airship_scn.instantiate()
	airship.position = Vector2(2000, randf_range(0, 600))
	airship.z_index = 3
	#if score > 60:
	#	airship.add_central_force($plane.position - airship.position)
	add_child(airship)
	entities[index] = airship
	index += 1


func _on_explosion_timer_timeout():
	get_node("explosion").queue_free()
	game_over = true

var coin_texture = preload("res://assets/coin.png")
func _on_coin_timer_timeout():
	var coin = Sprite2D.new()
	coin.scale = Vector2(0.1, 0.1)
	coin.texture = coin_texture
	coin.position = Vector2(1080, randf_range(150, 400))
	coins[index] = coin # same index for coins as well [?]
	add_child(coin)
	index+=1
