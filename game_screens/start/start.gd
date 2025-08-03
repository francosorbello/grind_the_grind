extends Control

@export var game_scene : PackedScene

func _on_start_btn_pressed() -> void:
	$ClickSound.play() 
	IndieBlueprintSceneTransitioner.transition_to_with_loading_screen(
		game_scene.resource_path,
		"res://game_screens/loading/loading_screen.tscn",
		IndieBlueprintPremadeTransitions.Voronoi,
		IndieBlueprintPremadeTransitions.Voronoi
	)
	pass # Replace with function body.
