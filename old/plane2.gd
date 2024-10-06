extends RigidBody2D

var is_added : bool = false
var weight=1

func _integrate_forces(state):
	if not is_added:
		apply_central_force(Vector2(-200, weight))
		is_added = true


func _on_plane2_body_entered(body):
	if body.get_name() == "plane":
		var explosion = AnimatedSprite2D.new()
		explosion.frames = load("res://explosion.res")
		explosion.scale = Vector2(0.5,0.5)
		explosion.position = body.position
		explosion.name = "explosion"
		body.get_parent().add_child(explosion)
		body.get_parent().get_node("explosion_timer").start()
		body.queue_free()
		
		
