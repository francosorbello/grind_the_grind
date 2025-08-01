extends State

@export var fall_travel_time : float = 0.4  # Time to reach the peak of the jump
@export var fall_curve : Curve

var _starting_height : float = 0.0
var _sample_point : float = 0.0

func enter():
    _starting_height = owner.player_model.position.y

func exit():
    $FallSound.play()
    _sample_point = 0.0  # Reset the sample point when exiting the state

func pyhsics_update(delta: float) -> void:
    # sample the jump curve and multiply by the jump height to get the current vertical position
    _sample_point += (delta / fall_travel_time) 
    owner.player_model.position.y = _starting_height * fall_curve.sample(_sample_point)
    if owner.player_model.position.y <= 0:  # Reset position when landing
        owner.player_model.position.y = 0
        state_machine.transition_to("GrindState")  # Transition to GrindState when landing
