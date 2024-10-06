extends Area2D

var speed = 256


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("default")
	position.x -= speed * delta
	
	if position.x < -32:
		queue_free()


func _on_body_entered(body):
	if "coins" in body:
		body.coins += 1
		queue_free()
