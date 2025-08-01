extends State

func enter():
    owner.do_grind_anim()  # Play grind animation when entering the grind state
    $GrindSound.play()  # Play grind sound when entering the grind state

func update(_delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
       state_machine.transition_to("JumpingState")
   
func exit():
    $GrindSound.stop()