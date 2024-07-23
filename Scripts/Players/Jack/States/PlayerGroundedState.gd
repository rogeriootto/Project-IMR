extends PlayerState
class_name PlayerGrounded

@export var player: CharacterBody3D
@export var animControl : AnimationPlayer
var speed: float = 7.0

var velocityTest : float
var cameraRotation: Vector3

@onready var interaction_area = get_tree().get_first_node_in_group("playerInteractableArea")

func Enter():
	pass
	
func Update(delta: float):
	velocityTest = abs(player.velocity.x) + abs(player.velocity.z)
	if velocityTest == 0:
		Transitioned.emit(self, 'PlayerIdle')
	else:
		Transitioned.emit(self, 'PlayerWalking')
		
func Physics_Update(delta: float):
	pass

func buttonsCheck():
	if Input.is_action_just_pressed("buildingMode_" + player.getPlayerNumber()):
		Transitioned.emit(self, 'PlayerBuilding')

func dropObstacle(obstacleName: String, spawnPosition: Vector3):
	SignalManager.emitObstacleSpawnRequest(obstacleName, spawnPosition)

var _onInteract = func():
	if player.interactableName == 'carro':
		Transitioned.emit(self, 'PlayerMovingObstacle')
	else:
		print('tirou')
		SignalManager.emitInteractRequest(player.getPlayerNumber())

func playerMovement(speedModifier: float = 0.0):
	var move_direction := Vector3.ZERO
	var velocity := Vector3.ZERO

	interaction_area.interact(_onInteract)
	
	var camera3Dnode = get_tree().get_first_node_in_group("camera")
	
	if player:
		move_direction.x = Input.get_action_strength("right_" + player.getPlayerNumber()) - Input.get_action_strength("left_" + player.getPlayerNumber())
		move_direction.z = Input.get_action_strength("down_"  + player.getPlayerNumber()) - Input.get_action_strength("up_" + player.getPlayerNumber())
		
		if camera3Dnode:
			move_direction = move_direction.rotated(Vector3.UP, camera3Dnode.global_rotation.y)

		velocity.x = move_direction.x * (speed + speedModifier)
		velocity.z = move_direction.z * (speed + speedModifier)
		
		if velocity.length() > 0.2:
			var look_direction = Vector2(velocity.z, velocity.x)
			player.rotation.y = look_direction.angle()
		
		if(Input.is_action_just_pressed("action_" + player.getPlayerNumber())):
			velocity.y += 10
		if(Input.is_action_just_pressed("action2_" + player.getPlayerNumber())):
			velocity.y -= 10
		player.velocity = velocity
		
		player.move_and_slide()
