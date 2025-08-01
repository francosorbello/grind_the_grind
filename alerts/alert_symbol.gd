extends Sprite3D

var alert_timeout : float = 1

signal on_alert_expired(alert : Node3D)

func _ready():
    $Timer.timeout.connect(_on_timeout)
    $Timer.start(alert_timeout)

func _on_timeout() -> void:
    on_alert_expired.emit(self)
    queue_free()  # Remove the alert symbol after timeout