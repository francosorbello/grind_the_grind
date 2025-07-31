extends Node3D

@export var path : Path3D

var _points : PackedVector3Array

func _ready() -> void:
    _points = path.get_curve().get_baked_points()
    if not _points:
        print("No points found in the path.")
    else:
        print("Path initialized with ", len(_points), " points.")

func _process(delta: float) -> void:
    for point in _points:
        # Draw each point in the path for debugging
        DebugDraw3D.draw_sphere(point, 0.1, Color(1, 0, 0,0))  # Red spheres for points
    # 	# Uncomment the next line to draw lines between points