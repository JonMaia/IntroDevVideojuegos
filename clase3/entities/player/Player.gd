extends Sprite

# A penas inicia el nodo setea la variable con el nodo hijo
onready var arm = $Arm
var speed = 200 #Pixeles

func initialize(projectile_container):
	arm.container = projectile_container


func _physics_process(delta):
	# Manera básica
#	var direction:int = 0
#	if Input.is_action_pressed("move_left"):
#		direction = -1
#	elif Input.is_action_pressed("move_right"):
#		direction = 1
	
	#position.x += direction * speed * delta
	
	#var mouse_position: Vector2 = get_global_mouse_position()
	var mouse_position: Vector2 = get_local_mouse_position()
	arm.rotation = mouse_position.normalized().angle()
	if Input.is_action_just_pressed("fire"):
		arm.fire()
	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -speed, speed)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	# Manera optimizada
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	position.x += direction_optimized * speed * delta


