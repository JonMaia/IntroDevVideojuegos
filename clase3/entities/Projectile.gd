extends Node2D

#onready var timer = $DeleteTimer
export (float) var speed
var direction: Vector2

func initialize(fire_direction:Vector2, initial_position:Vector2):
	global_position = initial_position
	direction = fire_direction
	#timer.start()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

#func _on_DeleteTimer_timeout() -> void:
#	get_parent().remove_child(self)
#	queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	call_deferred("remove_child", self)
	queue_free()
