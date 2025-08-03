extends Node3D

@export var rotation_speed : float = 1.0

signal on_player_collision(Node3D) 

func _physics_process(delta):
	rotation.y += rotation_speed * delta

func _on_area_3d_area_shape_entered(_area_rid:RID, area:Area3D, _area_shape_index:int, _local_shape_index:int) -> void:
	if area.name == "PlayerCollider":
		on_player_collision.emit(area)
		queue_free()
