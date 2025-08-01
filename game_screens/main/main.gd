extends Node
class_name Main

@export var game_scenes : Dictionary[String, PackedScene] = {
    "start": preload("res://game_screens/start/start.tscn"),
    "game": preload("res://game_screens/game/game.tscn"),
    "end": preload("res://game_screens/end/end.tscn")
}

@export var current_scene : String = "start"

func _ready():
    var start_scene = game_scenes[current_scene].instantiate()
    add_child(start_scene)
    start_scene.name = current_scene

func change_scene(new_scene: String):
    print("Changing scene to:", new_scene)
    if new_scene in game_scenes:
        IndieBlueprintSceneTransitioner.transition_to(game_scenes[new_scene].resource_path)