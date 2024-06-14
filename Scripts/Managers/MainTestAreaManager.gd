extends Node3D

var player1Preload := preload("res://Scenes/Objects/Jack.tscn")
var player2Preload := preload("res://Scenes/Objects/Jack.tscn")

var player1: CharacterBody3D
var player2: CharacterBody3D

@export var player1SpawnPoint: Vector3
@export var player2SpawnPoint: Vector3

signal obstacle_should_spawn

func _ready():
	player1 = player1Preload.instantiate()
	if player1:
		add_child(player1)
		player1.position = player1SpawnPoint
		player1.playerNumber = 'p1'
		print("player1", player1)
		get_node('Camera3D').player1 = player1
	
	player2 = player2Preload.instantiate()
	if player2:
		add_child(player2)
		player2.position = player2SpawnPoint
		player2.playerNumber = 'p2'
		get_node('Camera3D').player2 = player2
		

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		emit_signal("obstacle_should_spawn")
	pass