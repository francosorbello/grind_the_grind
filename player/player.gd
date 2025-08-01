extends Node3D

@export var jump_height: float = 1.0
@export var jump_speed: float = 5.0
@export var air_time: float = 1

@onready var player_model : Node3D = $Model
@onready var air_time_timer : Timer = $AirTimeTimer


var _jumping : bool = false
var _falling : bool = false

var trick_moves : Dictionary[ScoreManager.TrickType, int] = {
	ScoreManager.TrickType.TRICK_Z: KEY_Z,
	ScoreManager.TrickType.TRICK_x: KEY_X,
	ScoreManager.TrickType.TRICK_C: KEY_C
}

func _ready():
	var model_anim_player : AnimationPlayer = player_model.get_node("AnimationPlayer")
	model_anim_player.play("skate-air")
	air_time_timer.timeout.connect(_on_air_time_timeout)
	$Sounds/GrindSound.play()


func _physics_process(delta: float) -> void:
	if _jumping:
		player_model.position.y += jump_speed * delta  # Move up while jumping
		if player_model.position.y >= jump_height:
			_jumping = false  # Stop jumping when reaching the height
			air_time_timer.start(air_time)  # Start the timer for air time
			
	if _falling:
		player_model.position.y -= jump_speed * delta  # Simulate gravity while falling
		if player_model.position.y <= 0:  # Reset position when landing
			player_model.position.y = 0
			_falling = false
			$Sounds/GrindSound.play()  # Resume grind sound when landing

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		jump()

func _input(event: InputEvent) -> void:
	# only allow tricks when air floating
	if event.is_action_released("trick") and not _jumping and not _falling:
		print("trick with ",event.keycode)

func jump() -> void:
	# Implement the jump logic here
	_jumping = true
	$Sounds/GrindSound.stop()  # Stop the grind sound when jumping
	$Sounds/JumpSound.play()  # Play the jump sound

func _on_air_time_timeout() -> void:
	# This function can be used to handle the end of the jump
	_falling = true

func die():
	$Sounds/GrindSound.stop()  # Stop the grind sound on death
	_falling = false
	_jumping = false

func do_trick(trick_type : ScoreManager.TrickType ) -> void:
	pass