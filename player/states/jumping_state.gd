extends State


func enter():
    $JumpSound.play()
    owner.do_grab_anim()  # Play grab animation when entering the on-air state

func pyhsics_update(delta: float) -> void:
    owner.player_model.position.y += owner.jump_speed * delta  # Move up while jumping
    if owner.player_model.position.y >= owner.jump_height:
        state_machine.transition_to("OnAirState")  # Transition to FallingState when reaching the height