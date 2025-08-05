extends Node3D

@export var lose_screen : PackedScene
@export var player : Node3D
@export var current_funds : FundRes

func _start():
	current_funds.reset()

func lose_game() -> void:
	$UIFixer.unfix()
	player.die()
	await get_tree().create_timer(2.0).timeout
	print("Game Over",lose_screen)
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

func _on_bail_out_button_pressed() -> void:
	print("Bail out button pressed")
	lose_game()
	pass # Replace with function body.
