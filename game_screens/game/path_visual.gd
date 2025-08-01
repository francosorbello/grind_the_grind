extends CSGPolygon3D

@export var path: Path3D

# Fix for wierd bug where setting the path in the editor triggers an error when switching scenes.
func _ready():
    path_node = path.get_path()