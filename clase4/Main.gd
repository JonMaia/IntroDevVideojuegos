extends Node

onready var player = $Player
onready var turret_spawner = $TurretsSpawner
onready var respawn = $Respawn

func _ready():
	randomize()
	player.initialize(self, respawn)
	turret_spawner.initialize(player)

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_class("KinematicBody2D"):
		body.position = respawn.position
