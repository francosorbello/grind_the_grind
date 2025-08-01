extends Node3D

@export var lose_screen : PackedScene
@export var player : Node3D

func lose_game() -> void:
    player.die()
    if lose_screen:
        IndieBlueprintSceneTransitioner.transition_to(
		lose_screen,
		IndieBlueprintPremadeTransitions.Voronoi,
		IndieBlueprintPremadeTransitions.Voronoi
	)
    pass
