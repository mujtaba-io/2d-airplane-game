extends RigidBody2D

var is_added : bool = false
func _integrate_forces(state):
	if not is_added:
		apply_central_force(Vector2(-50, -200))
		is_added = true
