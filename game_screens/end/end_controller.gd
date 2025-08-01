extends Node

@export var game_s : String

func _on_reset_button_pressed() -> void:
    # await get_tree().create_timer(3.0).timeout
    IndieBlueprintSceneTransitioner.transition_to(
		game_s,
		IndieBlueprintPremadeTransitions.Voronoi,
		IndieBlueprintPremadeTransitions.Voronoi
	)
    pass # Replace with function body.
