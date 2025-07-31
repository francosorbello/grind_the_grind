extends Path3D

@export var speed: float = 3

func _physics_process(delta: float) -> void:
	$PathFollow3D.progress += speed * delta
