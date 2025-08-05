extends State

@export var rotation_speed : float = 1  # Speed of rotation while grinding

func enter():
    owner.do_grind_anim() 
    $GrindSound.play() 
    owner.score_manager.set_grinding(true)

func update(_delta: float) -> void:
    # if Input.is_action_just_released("jump"):
    #    state_machine.transition_to("JumpingState")
    #    return

    # var horizontal_input = Input.get_axis("move_left", "move_right")
    # # rotate z based on horizontal input
    # owner.rotation.z += -horizontal_input * _delta  * rotation_speed
    pass

func handle_sm_input(event: InputEvent) -> void:
    if event.is_action_released("trick") and $TrickAnimTimer.is_stopped():
        var trick_anim_time = owner.do_trick(owner.trick_moves[event.keycode])
        $TrickAnimTimer.start(trick_anim_time)

func exit():
    $GrindSound.stop()
    owner.score_manager.set_grinding(false)

func update_grind_stats():
    pass
