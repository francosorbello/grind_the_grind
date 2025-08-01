extends Sprite3D

var alert_timeout : float = 1

signal on_alert_expired(alert : Node3D)

func _ready():
    $Timer.timeout.connect(_on_timeout)
    $Timer.start(alert_timeout)
    var _current_color : Color = modulate
    var tween := create_tween()
    tween.tween_property(self, "modulate", Color.WHITE, alert_timeout) #Color(current_color.r, current_color.g, current_color.b, 1), alert_timeout)

func _on_timeout() -> void:
    on_alert_expired.emit(self)
    queue_free()  # Remove the alert symbol after timeout