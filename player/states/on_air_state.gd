extends State

@onready var air_time_timer : Timer = $AirTimeTimer
@export var air_time: float = 1

func _ready() -> void:
    air_time_timer.timeout.connect(_on_air_time_timeout)
    air_time_timer.wait_time = air_time

func _on_air_time_timeout() -> void:
    state_machine.transition_to("FallingState")  # Transition to FallingState when air time is up
    pass

func enter():
    air_time_timer.start()

func exit():
    air_time_timer.stop()  # Stop the timer when exiting the state

func handle_sm_input(event: InputEvent) -> void:
    if event.is_action_released("trick"):
        owner.do_trick(owner.trick_moves[event.keycode])
    if event.is_action_released("jump"):
        $KickDownSound.play()
        state_machine.transition_to("FallingState") 


