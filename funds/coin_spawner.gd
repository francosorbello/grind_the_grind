extends Node3D

@export var coin_scene : PackedScene
@export var spawn_interval : float = 3.0
@export var path : Path3D

@onready var spawn_timer : Timer = $SpawnTimer

@export_group("Funds")
@export var funds_to_add : int = 10
@export var current_funds : FundRes

var _path_points : PackedVector3Array
func _ready():
	_path_points = path.get_curve().get_baked_points()
	
	spawn_timer.timeout.connect(on_spawn_timer_timeout)
	spawn_timer.wait_time = spawn_interval
	
	spawn_timer.start()

func on_spawn_timer_timeout():
	_spawn_coin()
	pass

func _spawn_coin():
	if _path_points.size() == 0:
		print("No points found in the path.")
		return

	# get a point on the path to spawn the obstacle
	var random_index = randi() % _path_points.size()
	var _spawn_position = _path_points[random_index]

	var coin_instance = coin_scene.instantiate()
	coin_instance.position = _spawn_position
	add_child(coin_instance)
	coin_instance.on_player_collision.connect(_on_player_collision)

func _on_player_collision(_area: Node3D) -> void:
	$CoinPickupSound.play()
	current_funds.add_funds(funds_to_add, Global.FundReason.COIN_PICKUP)
	pass
