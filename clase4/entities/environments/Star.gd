extends Area2D

func _on_Star_body_entered(body: Node) -> void:
	if body.has_method("win"):
		body.win()
