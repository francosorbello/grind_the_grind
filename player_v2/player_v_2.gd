extends Node3D

@export var movement_speed: float = 5.0
@export var path : Path3D
@export var path_curve : Curve

var _points : PackedVector3Array
var _current_point : Vector3

func _ready() -> void:
    _points = path.get_curve().get_baked_points()
    if not _points:
        print("No points found in the path.")
    else:
        print("Path initialized with ", len(_points), " points.")
        _current_point = _points[0]  # Start at the first point
        $PathFollower.position = _current_point

func _physics_process(delta: float) -> void:
    if _points.size() > 0:
        # Move towards the next point in the path
        var direction = (_current_point - $PathFollower.position).normalized()
        $PathFollower.position += direction * movement_speed * delta
        
        # Check if we reached the current point
        if $PathFollower.position.distance_to(_current_point) < 0.1:
            # Move to the next point in the path
            var current_index = _points.find(_current_point)
            if current_index < _points.size() - 1:
                _current_point = _points[current_index + 1]
            else:
                print("Reached the end of the path.")
                _current_point = _points[0]  # Loop back to the start       