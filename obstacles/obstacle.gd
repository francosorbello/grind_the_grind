extends Area3D

@export var despawn_countdown : float = 5.0

signal on_despawn_countdown_reached(Node3D)
signal on_player_collision(Node3D)

func _ready():
	$Timer.timeout.connect(on_timeout)
	$Timer.start(despawn_countdown)

func on_timeout() -> void:
	on_despawn_countdown_reached.emit(self)


func _on_area_shape_entered(_area_rid: RID, area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	print("Obstacle collided with area", area.name)
	if area.name == "PlayerCollider":
		on_player_collision.emit(area)
