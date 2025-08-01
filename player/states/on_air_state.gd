extends State

@onready var air_time_timer : Timer = $AirTimeTimer
@export var air_time: float = 1

var trick_timeout : float = 0.2
var last_trick_time : float = 0.0

func _ready() -> void:
    air_time_timer.timeout.connect(_on_air_time_timeout)
    air_time_timer.wait_time = air_time

func _on_air_time_timeout() -> void:
    state_machine.transition_to("FallingState")  # Transition to FallingState when air time is up
    pass

func enter():
    air_time_timer.start()
    last_trick_time = 0


func handle_sm_input(event: InputEvent) -> void:
    # only allow tricks when air floating
    if event.is_action_released("trick") and can_do_trick():
        last_trick_time = Time.get_ticks_msec() / 1000.0
        var anim_length = owner.do_trick(owner.trick_moves[event.keycode])
        # var time_left : float = air_time_timer.time_left

func can_do_trick() -> bool:
    var current_time = Time.get_ticks_msec() / 1000.0
    var result : bool = (current_time - last_trick_time) > trick_timeout
    if result:
        print(current_time - last_trick_time)
    
    return result