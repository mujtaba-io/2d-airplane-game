extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_offset: float = 64

@export var coin_scene: PackedScene


func _process(delta):
	$ParallaxBackground.scroll_offset = Vector2(0, 0)
	$ParallaxBackground/ParallaxLayer.motion_offset += Vector2(-0.15, 0)
	$ParallaxBackground/ParallaxLayer2.motion_offset += Vector2(-0.3, 0)
	$ParallaxBackground/ParallaxLayer3.motion_offset += Vector2(-0.6, 0)


func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position.x = get_viewport().size.x + spawn_offset
	enemy.position.y = randf_range(28, get_viewport().size.y - 28)



func _on_coin_spawn_timer_timeout():
	var coin_pattern = randi_range(0, 3)  # Choose a random pattern (0-2)

	if coin_pattern == 0:  # Horizontal line pattern
		var coin_count = randf_range(3, 5)  # Random number of coins in the line
		var starting_y = randf_range(28, get_viewport().size.y - 28)
		for i in range(coin_count):
			var coin = coin_scene.instantiate()
			add_child(coin)
			coin.position.x = get_viewport().size.x + spawn_offset + i * 32  # Adjust spacing as needed
			coin.position.y = starting_y
	
	elif coin_pattern == 1:  # Diagonal line pattern (upward)
		var coin_count = randf_range(3, 5)  # Random number of coins in the line
		var starting_x = get_viewport().size.x + spawn_offset
		var starting_y = randf_range(28, get_viewport().size.y - 28)
		for i in range(coin_count):
			var coin = coin_scene.instantiate()
			add_child(coin)
			coin.position.x = starting_x - i * 32  # Adjust spacing as needed
			coin.position.y = starting_y - i * 32  # Adjust spacing as needed

	elif coin_pattern == 2:  # Diagonal line pattern (downward)
		var coin_count = randf_range(3, 5)  # Random number of coins in the line
		var starting_x = get_viewport().size.x + spawn_offset
		var starting_y = randf_range(28, get_viewport().size.y - 28)
		for i in range(coin_count):
			var coin = coin_scene.instantiate()
			add_child(coin)
			coin.position.x = starting_x - i * 32  # Adjust spacing as needed
			coin.position.y = starting_y + i * 32  # Adjust spacing as needed
