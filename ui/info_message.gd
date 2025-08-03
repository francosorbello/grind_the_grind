extends Label

func start(message : String):
    text = message
    show()
    var tween := create_tween()

    tween.tween_property(self, "position", Vector2(100,120), 0.7)
    tween.tween_property(self, "modulate:a", 0, 0.7)

    tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
    queue_free()