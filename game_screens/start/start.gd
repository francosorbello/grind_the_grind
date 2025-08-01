extends Control

@export var game_scene : PackedScene

func _on_start_btn_pressed() -> void:
	breakpoint
	IndieBlueprintSceneTransitioner.transition_to(
		game_scene.resource_path,
		IndieBlueprintPremadeTransitions.Voronoi,
		IndieBlueprintPremadeTransitions.Voronoi
	)
	pass # Replace with function body.
