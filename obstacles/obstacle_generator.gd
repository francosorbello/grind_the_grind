extends Node3D

@export var obstacle_scenes : Array[PackedScene]
@export var path : Path3D
@export var height_offset : float = 0.5

@export_group("Intervals")
@export var spawn_interval : float = 2.0
@export var alert_interval : float = 1.0

@onready var spawn_timer : Timer = $NextObstacleTimer
@onready var alert_timer : Timer = $ObstacleAlertTimer

var _path_points : PackedVector3Array

func _ready():
    _path_points = path.get_curve().get_baked_points()
    spawn_timer.timeout.connect(on_spawn_timer_timeout)
    spawn_timer.wait_time = spawn_interval

    spawn_timer.start()

func on_spawn_timer_timeout() -> void:
    if _path_points.size() == 0:
        print("No points found in the path.")
        return

    var random_index = randi() % _path_points.size()
    var spawn_position = _path_points[random_index]

    var obstacle_scene = obstacle_scenes[randi() % obstacle_scenes.size()]
    var obstacle_instance = obstacle_scene.instantiate()

    obstacle_instance.position = spawn_position + Vector3(0, height_offset, 0)  # Adjust height if necessary
    add_child(obstacle_instance)
    obstacle_instance.look_at(position)
    obstacle_instance.on_despawn_countdown_reached.connect(_on_despawn_reached)

    spawn_timer.start()  # Restart the timer for the next spawn

func _on_despawn_reached(obstacle : Node3D) -> void:
    obstacle.queue_free()