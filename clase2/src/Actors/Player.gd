extends Actor

func _physics_process(_delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	var moveH: float = Input.get_action_strength("move_right") - 	Input.get_action_strength("move_left") 
	var moveV: float = -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	return Vector2(moveH, moveV)

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y = calculate_jump(new_velocity.y, direction, speed, is_jump_interrupted)
	return new_velocity

func calculate_jump(velocityV: float, direction: Vector2, speed: Vector2, is_jump_interrupted: bool):
	# Apply gravity per delta time 
	velocityV += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		velocityV = speed.y * direction.y
	# Interrupted mult jump 
	if is_jump_interrupted:
		velocityV = 0.0
	return velocityV
