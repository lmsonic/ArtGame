extends KinematicBody

class_name Player
var gravity := Vector3.DOWN * 12  # strength of gravity

var speed := 4  # movement speed

var jump_speed := 6  # jump strength

var spin := 3  # rotation speed

onready var sprite:AnimatedSprite3D = $AnimatedSprite3D

var velocity := Vector3()
var extracted:=false
var jump := false

func _ready():
	get_tree().call_group("knows_player","set_player",self)	 

func set_animation(name:String):
	sprite.play(name)

func get_input(delta:float):
	if not extracted:
		var vy :float= velocity.y
		velocity = Vector3() #moves according to local direction
		if Input.is_action_pressed("up"):
			velocity += -transform.basis.z * speed
		if Input.is_action_pressed("down"):
			velocity += transform.basis.z * speed
		if Input.is_action_pressed("right"):
			rotate_y(-spin*delta)
			velocity += transform.basis.x * speed
		if Input.is_action_pressed("left"):
			rotate_y(spin*delta)
			velocity += -transform.basis.x * speed
		
		if abs(velocity.x)>0 or abs(velocity.z)>0:
			#animation
			if velocity.z>0:
				sprite.play("walk")
			else:
				sprite.play("walk_reverse")
		else:
			sprite.play("idle")
		velocity.y = vy


func _physics_process(delta:float):
	if not extracted:
		velocity += gravity * delta
		get_input(delta)
		velocity = move_and_slide(velocity, Vector3.UP)
