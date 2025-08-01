extends State


func pyhsics_update(delta : float) -> void:
    # This function is called every physics frame
    owner.player_model.position.y -= owner.fall_speed * delta  # Simulate gravity while falling
    if owner.player_model.position.y <= 0:  # Reset position when landing
        owner.player_model.position.y = 0
        state_machine.transition_to("GrindState")  # Transition to GrindState when landing
