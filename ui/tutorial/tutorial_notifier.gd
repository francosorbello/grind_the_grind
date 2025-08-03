extends Node

@export var mesage : String

var emmited : bool = false

func notify() -> void:
    GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_TUTORIAL, {"tutorial": mesage})
    emmited = true