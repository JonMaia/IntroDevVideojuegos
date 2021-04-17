extends Sprite

export (float) var speed: float
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction: int = int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	position.x += direction * speed * delta
