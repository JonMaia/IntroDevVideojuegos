extends Camera2D

onready var anim_player = $AnimationPlayer

func _on_Player_ice_started() -> void:
	anim_player.play("vibrate")
	
func _on_Player_ice_stopped() -> void:
	anim_player.stop()
