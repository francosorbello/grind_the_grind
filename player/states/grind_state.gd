extends State

func enter():
    $GrindSound.play()  # Play grind sound when entering the grind state

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
       state_machine.transition_to("JumpingState")
   
func exit():
    $GrindSound.stop()