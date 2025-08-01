extends State

@export var jump_curve : Curve
@export var jump_travel_time : float = 0.4  # Time to reach the peak of the jump

var _final_height : float = 0.0
var _sample_point : float = 0.0

func enter():
    $JumpSound.play()
    owner.do_grab_anim()  # Play grab animation when entering the on-air state
    _final_height = owner.player_model.position.y + owner.jump_height

func exit():
    _sample_point = 0.0  # Reset the sample point when exiting the state


func pyhsics_update(delta: float) -> void:
    # sample the jump curve and multiply by the jump height to get the current vertical position
    _sample_point += (delta / jump_travel_time) 
    owner.player_model.position.y = _final_height * jump_curve.sample(_sample_point)

    if owner.player_model.position.y >= owner.jump_height:
        state_machine.transition_to("OnAirState")  # Transition to FallingState when reaching the height



func handle_sm_input(event: InputEvent) -> void:
    if event.is_action_released("trick"):
        owner.do_trick(owner.trick_moves[event.keycode])