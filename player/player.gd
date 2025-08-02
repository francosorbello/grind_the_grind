extends Node3D

@export var jump_height: float = 1.0
@export var jump_speed: float = 5.0
@export var fall_speed: float = 5.0
@export var score_manager : ScoreManager

@onready var player_model : Node3D = $Model


var model_anim_player : AnimationPlayer
var last_trick_time : float = 0.0
var trick_timeout : float = 0.2

var trick_moves : Dictionary[int, Global.TrickType] = {
	KEY_Z: Global.TrickType.TRICK_Z,
	KEY_X: Global.TrickType.TRICK_x,
	KEY_C: Global.TrickType.TRICK_C
}

func _ready():
	model_anim_player = player_model.get_node("AnimationPlayer")

func die():
	$BongSound.play()
	await get_tree().physics_frame 
	call_deferred("enable_ragdoll")
	$Model/PlayerCollider/CollisionShape3D.disabled = true
	pass

func enable_ragdoll():
	$Model/Skeleton3D/PhysicalBoneSimulator3D.physical_bones_start_simulation()
	await get_tree().physics_frame 
	$"Model/Skeleton3D/PhysicalBoneSimulator3D/Physical Bone torso".apply_impulse(Vector3(1, 1, 0) * 10)

func do_trick(_trick_type : Global.TrickType ) -> float:
	if not can_do_trick():
		return -1.0
	# print("doing trick ",trick_type)
	last_trick_time = Time.get_ticks_msec() / 1000.0
	var prev_anim = model_anim_player.current_animation
	$TrickHitSound.play()
	model_anim_player.play("fall")
	model_anim_player.animation_finished.connect(func (_anim_name) : model_anim_player.play(prev_anim))  # Play air animation after falling
	return model_anim_player.current_animation_length

func do_grab_anim():
	model_anim_player.play("skate-grab")

func do_grind_anim():
	model_anim_player.play("skate-air")

func can_do_trick() -> bool:
	var current_time = Time.get_ticks_msec() / 1000.0
	var result : bool = (current_time - last_trick_time) > trick_timeout
	if result:
		print(current_time - last_trick_time)
	
	return result
