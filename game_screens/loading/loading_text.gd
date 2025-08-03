extends Label

@export var loading_text : String = "LOADING"

var current_text : String = loading_text

func _on_timer_timeout() -> void:
    if current_text == "LOADING...":
        current_text = loading_text

    current_text += "."
    text = current_text
