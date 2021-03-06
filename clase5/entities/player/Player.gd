extends KinematicBody2D

onready var cannon = $Cannon
onready var body = $Body
onready var play_animation = $AnimationPlayer

const FLOOR_NORMAL := Vector2.UP  # Igual a Vector2(0, -1)
const SNAP_DIRECTION := Vector2.UP
const SNAP_LENGHT := 32.0
const SLOPE_THRESHOLD := deg2rad(46)

export (float) var ACCELERATION:float = 60.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (int) var jump_speed = 500
export (float) var FRICTION_WEIGHT:float = 0.1
export (int) var gravity = 10

var projectile_container

var velocity:Vector2 = Vector2.ZERO
var snap_vector:Vector2 = SNAP_DIRECTION * SNAP_LENGHT

func initialize(projectile_container):
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container

func get_input():
	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()

	# Jump Action
	var jump = Input.is_action_just_pressed('jump')
	if jump and is_on_floor():
		play_animation.play("Jump")
		velocity.y -= jump_speed

	#horizontal speed
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		body.flip_h = velocity.x < 0
		if body.flip_h:
			body.position.x = -40
		else:
			body.position.x = 0
		if !play_animation.is_playing() and !jump:
			play_animation.play("Walk")
	else:
		if !play_animation.is_playing() and !jump:
			play_animation.play("Idle")
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0

	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)


func _physics_process(delta):
	get_input()
	
	# Apply velocity
	var snap:Vector2
	
	velocity.y += gravity

	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, SLOPE_THRESHOLD) # Usando move_and_slide_with_snap y con threshold de slope

func notify_hit():
	collision_layer = 0
	play_animation.stop()
	play_animation.play("dead")

func dead():
	print("I'm player and imma die")
	call_deferred("_remove")

func _remove():
	set_physics_process(false)
	hide()


