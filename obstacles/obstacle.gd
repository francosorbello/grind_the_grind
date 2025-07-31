extends Area3D

@export var despawn_countdown : float = 5.0

signal on_despawn_countdown_reached(Node3D)

func _ready():
    $Timer.timeout.connect(on_timeout)
    $timer.start(despawn_countdown)

func on_timeout() -> void:
    print("Obstacle despawned")
    on_despawn_countdown_reached.emit(self)
