extends Node

@export var game_s : String

func _on_reset_button_pressed() -> void:
    IndieBlueprintSceneTransitioner.transition_to(
		game_s,
		IndieBlueprintPremadeTransitions.Voronoi,
		IndieBlueprintPremadeTransitions.Voronoi
	)
    pass # Replace with function body.
