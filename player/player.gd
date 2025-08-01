extends Node3D

@export var jump_height: float = 1.0
@export var jump_speed: float = 5.0
@export var fall_speed: float = 5.0

@onready var player_model : Node3D = $Model

var model_anim_player : AnimationPlayer

var trick_moves : Dictionary[int, ScoreManager.TrickType] = {
	KEY_Z: ScoreManager.TrickType.TRICK_Z,
	KEY_X: ScoreManager.TrickType.TRICK_x,
	KEY_C: ScoreManager.TrickType.TRICK_C
}

func _ready():
	model_anim_player = player_model.get_node("AnimationPlayer")

func die():
	pass

func do_trick(trick_type : ScoreManager.TrickType ) -> float:
	# print("doing trick ",trick_type)
	var prev_anim = model_anim_player.current_animation
	$TrickHitSound.play()
	model_anim_player.play("fall")
	model_anim_player.animation_finished.connect(func (_anim_name) : model_anim_player.play(prev_anim))  # Play air animation after falling
	return model_anim_player.current_animation_length

func do_grab_anim():
	model_anim_player.play("skate-grab")

func do_grind_anim():
	model_anim_player.play("skate-air")
