extends "res://entities/Projectile.gd"

func _on_Projectile_body_entered(body: Node) -> void:
	if body.is_class("TileMap") or body.is_class("RigidBody2D"):
		self._remove()
	if  body.has_method("notify_hit"):
		body.notify_hit()
	
