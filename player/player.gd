extends Node3D

@export var jump_height: float = 1.0
@export var jump_speed: float = 5.0
@export var fall_speed: float = 5.0

@onready var player_model : Node3D = $Model

var trick_moves : Dictionary[ScoreManager.TrickType, int] = {
	ScoreManager.TrickType.TRICK_Z: KEY_Z,
	ScoreManager.TrickType.TRICK_x: KEY_X,
	ScoreManager.TrickType.TRICK_C: KEY_C
}

func _ready():
	var model_anim_player : AnimationPlayer = player_model.get_node("AnimationPlayer")
	model_anim_player.play("skate-air")

func die():
	pass

func do_trick(trick_type : ScoreManager.TrickType ) -> void:
	pass
