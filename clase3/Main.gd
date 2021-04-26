extends Node

onready var player = $Player

func _ready() -> void:
	player.initialize(self)
