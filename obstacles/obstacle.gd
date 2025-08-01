extends Area3D

@export var despawn_countdown : float = 5.0

signal on_despawn_countdown_reached(Node3D)
signal on_obstacle_collided(Node3D)

func _ready():
	$Timer.timeout.connect(on_timeout)
	$Timer.start(despawn_countdown)

func on_timeout() -> void:
	print("Obstacle despawned")
	on_despawn_countdown_reached.emit(self)


func _on_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	print("Obstacle collided with area", area.name)
	pass # Replace with function body.
