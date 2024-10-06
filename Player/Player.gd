extends RigidBody2D

@export var bullet_scene: PackedScene

var speed: float = 64 * 0.4

var coins: int = 0
var kills: int = 0


func _physics_process(delta):
	
	$UI/Coins.text = "Coins: " + str(coins)
	$UI/Kills.text = "kills: " + str(kills)
	
	$AnimatedSprite2D.play("default")
	if Input.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2(0, -mass * speed))
		$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, deg_to_rad(-30), 0.1)
	else:
		if $AnimatedSprite2D.rotation < 0:
			$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, deg_to_rad(0), 0.1)
	if Input.is_action_pressed("ui_down"):
		apply_central_impulse(Vector2(0, mass * speed))
		$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, deg_to_rad(30), 0.1)
	else:
		if $AnimatedSprite2D.rotation > 0:
			$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, deg_to_rad(0), 0.1)
	
	if Input.is_action_just_pressed("ui_home"):
		var bullet = bullet_scene.instantiate()
		bullet.shooter = self # i shot it
		bullet.position = self.position + Vector2(64, 0)
		bullet.direction = Vector2(1, 0)
		get_parent().add_child(bullet)
