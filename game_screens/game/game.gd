extends Node3D

@export var lose_screen : PackedScene
@export var player : Node3D

func lose_game() -> void:
    player.die()
    await get_tree().create_timer(3.0).timeout
    if lose_screen:
        IndieBlueprintSceneTransitioner.transition_to(
        lose_screen,
        IndieBlueprintPremadeTransitions.Voronoi,
        IndieBlueprintPremadeTransitions.Voronoi
    )
    pass

func _process(_delta):
    if Input.is_action_just_released("bail"):
        lose_game()