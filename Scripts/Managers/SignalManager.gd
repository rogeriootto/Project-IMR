extends Node3D

signal obstacleSpawnRequest(obstacleName: String, obstaclePosition: Vector3)
signal showObstacleToP1Request(obstacleName: String, obstaclePosition: Vector3)
signal showObstacleToP2Request(obstacleName: String, obstaclePosition: Vector3)
signal obstacleRemoveRequest(obstaclePosition: Vector3)
signal interactRequest(playerNumber: String)
signal interactRequestP1()
signal interactRequestP2()
signal moveObstacleRequest(obstacle: Object)
signal interactableNameRequestP1(name: String)
signal interactableNameRequestP2(name: String)
signal deadTookDamage()
signal deadDied()
signal changeScenes()


func registerListner(signalName: String, target: Object, method: String): 
	if not has_signal(signalName):
		return
	var callable = Callable(target, method)
	if not is_connected(signalName, callable):
		connect(signalName, callable)
		#print("SignalManager: Connected signal " + signalName + " to " + " method " + method)
	
func unregisterListner(signalName: String, target: Object, method: String):
	var callable = Callable(target, method)
	if is_connected(signalName, callable):
		disconnect(signalName, callable)

func emitObstacleSpawnRequest(obstacleName: String, obstaclePosition: Vector3, player: Object):
	emit_signal("obstacleSpawnRequest", obstacleName, obstaclePosition, player)

func emitShowObstacleToP1(showObjectFlag: bool, obstacleName: String, obstaclePosition: Vector3):
	emit_signal("showObstacleToP1Request", showObjectFlag, obstacleName, obstaclePosition)

func emitShowObstacleToP2(showObjectFlag: bool, obstacleName: String, obstaclePosition: Vector3):
	emit_signal("showObstacleToP2Request", showObjectFlag, obstacleName, obstaclePosition)

func emitObstacleRemoveRequest(obstacle: StaticBody3D, player: Object):
	emit_signal("obstacleRemoveRequest",obstacle, player)

func emitMoveObstacleRequest(obstacle: Object, should_reconect_points: bool, playerNumber: String = ''):
	emit_signal("moveObstacleRequest",obstacle, should_reconect_points, playerNumber)

func emitInteractRequest(playerNumber: String = ''):
	emit_signal("interactRequest", playerNumber)

func emitInteractRequestP1():
	emit_signal("interactRequestP1", 'p1')

func emitInteractRequestP2():
	emit_signal("interactRequestP2", 'p2')

func emitInteractableNameP1(obstacleName: String):
	emit_signal("interactableNameRequestP1", obstacleName)

func emitInteractableNameP2(obstacleName: String):
	emit_signal("interactableNameRequestP2", obstacleName)

func emitChangeScenes():
	#print("emitChangeScenes")
	emit_signal("changeScenes", true)

#func emitDisconnectAreaRequest(obstacle: Object, comprimento: int, largura: int, altura: int):
#	emit_signal("disconnectAreaRequest", obstacle, comprimento, largura, altura)
