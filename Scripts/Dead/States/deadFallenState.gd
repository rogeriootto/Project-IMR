extends DeadGrounded
class_name DeadFallen

@export var fall_collision: CollisionShape3D
@export var dead_collision: CollisionShape3D

func Enter():
	dead.position = GlobalVariables.astarNode.dead_should_fall(dead.global_transform.origin)
	animControl.play("Crouching", -1, 3)
	dead_collision.disabled = true
	fall_collision.disabled = false
	print("Dead FALL State")
	for deads in $"../../../Area3D".get_overlapping_bodies():
		deads.should_update_path = true
		deads.count_fallen = 0.0
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	#for deads in $"../../../Area3D".get_overlapping_bodies():
		#body.should_update_path = true
	pass