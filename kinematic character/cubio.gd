extends KinematicBody

var gravity = Vector3.DOWN * 12  # strength of gravity

var speed = 4  # movement speed

var jump_speed = 6  # jump strength

var spin = 3  # rotation speed


var velocity = Vector3()
var jump = false

func get_input(delta):
	var vy = velocity.y
	velocity = Vector3()
	if Input.is_action_pressed("ui_up"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("ui_down"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("ui_right"):
		rotate_y(-spin*delta)
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("ui_left"):
		rotate_y(spin*delta)
		velocity += -transform.basis.x * speed
	velocity.y = vy


func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
