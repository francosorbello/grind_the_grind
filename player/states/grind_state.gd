extends State

@export var rotation_speed : float = 1  # Speed of rotation while grinding

func enter():
    owner.do_grind_anim()  # Play grind animation when entering the grind state
    $GrindSound.play()  # Play grind sound when entering the grind state

func update(_delta: float) -> void:
    if Input.is_action_just_released("jump"):
       state_machine.transition_to("JumpingState")
       return
    var horizontal_input = Input.get_axis("move_left", "move_right")
    # rotate z based on horizontal input
    owner.rotation.z += -horizontal_input * _delta  * rotation_speed
   
func exit():
    $GrindSound.stop()