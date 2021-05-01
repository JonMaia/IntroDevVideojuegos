extends "res://entities/Projectile.gd"

func _on_Projectile_body_entered(body: Node) -> void:
	if  body.has_method("notify_hit"):
		body.notify_hit()
