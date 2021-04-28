extends KinematicBody2D

# A penas inicia el nodo setea la variable con el nodo hijo
onready var arm = $Sprite/Arm
onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
var velocity: Vector2 = Vector2.ZERO
var speed = 200 #Pixeles

func initialize(projectile_container):
	arm.container = projectile_container

func _physics_process(delta):
	velocity.y += gravity * delta
	#var mouse_position: Vector2 = get_global_mouse_position()
	var mouse_position: Vector2 = get_local_mouse_position()
	arm.rotation = mouse_position.normalized().angle()
	if Input.is_action_just_pressed("fire"):
		arm.fire()
	
	# Manera optimizada
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))	
	position.x += direction_optimized * speed * delta
	move_and_collide(velocity * delta)
