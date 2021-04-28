extends RigidBody2D

onready var arm = $Arm
export (int) var detect_radius
var vis_color = Color(.867, .91, .247, 0.1)
var speed = 200 #Pixeles
var target
var can_shoot = true

func initialize(projectile_container):
	arm.container = projectile_container

func _ready() -> void:
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	

func _physics_process(delta):
	if target:
		arm.rotation = (target.position - position).angle()
		if can_shoot:
			shoot(target.position)

func shoot(pos):
	arm.fire()
	can_shoot = false
	$Timer.start()

func _on_VisibilityNotifier2D_screen_entered(body) -> void:
	if target:
		return
	target = body

func _on_VisibilityNotifier2D_screen_exited(body) -> void:
	if body == target:
		target = null


func _on_Timer_timeout() -> void:
	can_shoot = true
