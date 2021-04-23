extends Area2D

signal hit
export var speed = 400 # How fast the player will move (pixel/sec).
var screen_size # Size of the game window
var animation = ""
var new_anim = animation

func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2() # The player's movement vector.	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		new_anim = "right"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		new_anim = "left"
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		new_anim = "down"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		new_anim = "up"
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play(new_anim)
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body: Node) -> void:
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
