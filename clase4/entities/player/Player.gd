extends KinematicBody2D

onready var cannon = $Sprite/Cannon
const FLOOR_NORMAL: = Vector2.UP
export (float) var ACCELERATION:float = 20.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (float) var FRICTION_WEIGHT:float = 0.1
export (float) var gravity: float = 10.0
export (int) var jump_speed: = 500
var velocity:Vector2 = Vector2.ZERO
var projectile_container
var player_respawn

func initialize(projectile_container_parent, respawn):
	self.projectile_container = projectile_container_parent
	cannon.projectile_container = projectile_container
	player_respawn = respawn

func _physics_process(delta):
	get_directions()
	cannon_fire()
	velocity.y += gravity
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func notify_hit():
	print("ouch")
	self.position = player_respawn.position

func get_directions():
	apply_movement_horizontal()
	apply_movement_vertical()

func apply_movement_horizontal():
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0

func apply_movement_vertical():
	var jump = Input.is_action_just_pressed("jump")
	if jump and is_on_floor():
		velocity.y -= jump_speed

func cannon_fire():
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()
