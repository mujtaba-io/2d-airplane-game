extends RigidBody2D

var motion_y : float
var weight = 1.0

func _ready():
	pass

func _process(delta):
	$body.play("level1-idle")

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		motion_y = 1
		$body.rotation = lerp_angle($body.rotation, deg_to_rad(-30), 0.1)
	else:
		if $body.rotation < 0:
			$body.rotation = lerp_angle($body.rotation, deg_to_rad(0), 0.1)
	if Input.is_action_pressed("ui_down"):
		#lerp(motion.y, 650, 0.02)#Vector2(0, 200 * delta)
		$body.rotation = lerp_angle($body.rotation, deg_to_rad(30), 0.1)
		motion_y = -1 #tmp
	else:
		if $body.rotation > 0:
			$body.rotation = lerp_angle($body.rotation, deg_to_rad(0), 0.1)

func _integrate_forces(state):
	apply_central_impulse(Vector2(0, -weight*6) * motion_y)
	motion_y = 0
